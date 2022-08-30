local utf8Tools = {}

do
	local options = {}
	utf8Tools.options = options

	-- Check the Unicode surrogate range. Code points in this range are forbidden by the spec,
	-- but some decoders allow them through.
	options.check_surrogates = true

	-- Exclude certain bytes forbidden by the spec when calling getCodeUnit().
	options.match_exclude = true

	-- Lookup Tables and Patterns

	local function makeLUT(seq)
		local lut = {}
		for i, val in ipairs(seq) do
			lut[val] = true
		end
		return lut
	end

	utf8Tools.charpattern = "[%z\x01-\x7F\xC2-\xFD][\x80-\xBF]*"

	utf8Tools.u8_oct_1 = "[%z\x01-\x7F\xC2-\xFD]"

	utf8Tools.u8_ptn_t = {
		"^[%z\x01-\x7F]",
		"^[\xC0-\xDF][\x80-\xBF]",
		"^[\xE0-\xEF][\x80-\xBF][\x80-\xBF]",
		"^[\xF0-\xF7][\x80-\xBF][\x80-\xBF][\x80-\xBF]",
	}

	utf8Tools.u8_ptn_excl_t = {
		"^[%z\x01-\x7F]",
		"^[\xC2-\xDF][\x80-\xBF]",
		"^[\xE0-\xEF][\x80-\xBF][\x80-\xBF]",
		"^[\xF0-\xF4][\x80-\xBF][\x80-\xBF][\x80-\xBF]",
	}


	-- Octets 0xc0, 0xc1, and (0xf5 - 0xff) should never appear in a UTF-8 value
	utf8Tools.lut_invalid_octet = makeLUT( {
		-- 1100:0000, 1100:0001
		0xc0, 0xc1,
		-- 1111:0101 - 1111:1111
		0xf5, 0xf6, 0xf7, 0xf8, 0xf9, 0xfa,
		0xfb, 0xfc, 0xfd, 0xfe, 0xff
	}
	)

	-- Used to verify number length against allowed octet ranges.
	local lut_oct_min_max = {
		{0x00000, 0x00007f}, -- 1 octet
		{0x00080, 0x0007ff}, -- 2 octets
		{0x00800, 0x00ffff}, -- 3 octets
		{0x10000, 0x10ffff}, -- 4 octets
	}

	local function _assertArgType(arg_n, var, expected)
		if type(var) ~= expected then
			error("bad argument #" .. arg_n .. " (Expected " .. expected .. ", got " .. type(var) .. ")", 2)
		end
	end

	local function _errStrInvalidOctet(pos, val)
		return "Invalid octet value (" .. val .. ") in byte #" .. pos
	end

	local function _checkFollowingOctet(octet, position, n_octets)
		-- NOTE: Do not call on the first octet.

		if not octet then
			return "Octet #" .. tostring(position) .. " is nil."

			-- Check some bytes which are prohibited in any position in a UTF-8 code point
		elseif utf8Tools.lut_invalid_octet[octet] then
			return _errStrInvalidOctet(position, octet)

			-- Nul is allowed in single-octet code points, but not multi-octet
		elseif octet == 0 then
			return "Octet #" .. tostring(position) .. ": Multi-byte code points cannot contain 0 / Nul bytes."

			-- Verify "following" byte mark	
			-- < 1000:0000
		elseif octet < 0x80 then
			return "Byte #" .. tostring(position) .. " is too low (" .. tostring(octet) .. ") for multi-byte encoding. Min: 0x80"

			-- >= 1100:0000
		elseif octet >= 0xC0 then
			return "Byte #" .. tostring(position) .. " is too high (" .. tostring(octet) .. ") for multi-byte encoding. Max: 0xBF"
		end
	end

	local function _numberFromOctets(n_octets, b1, b2, b3, b4)
		return n_octets == 1 and b1
			or n_octets == 2 and (b1 - 0xc0) * 0x40 + (b2 - 0x80)
			or n_octets == 3 and (b1 - 0xe0) * 0x1000 + (b2 - 0x80) * 0x40 + (b3 - 0x80)
			or n_octets == 4 and (b1 - 0xf0) * 0x40000 + (b2 - 0x80) * 0x1000 + (b3 - 0x80) * 0x40 + (b4 - 0x80)
			or nil
	end


	local function _getLengthMarker(byte)
		-- (returns a number on success, or error string on failure)
		return (byte < 0x80) and 1 -- 1 octet: 0000:0000 - 0111:1111
			or (byte >= 0xC0 and byte < 0xE0) and 2 -- 2 octets: 1100:0000 - 1101:1111	
			or (byte >= 0xE0 and byte < 0xF0) and 3 -- 3 octets: 1110:0000 - 1110:1111
			or (byte >= 0xF0 and byte < 0xF8) and 4 -- 4 octets: 1111:0000 - 1111:0111
			or (byte >= 0x80 and byte < 0xBF) and "trailing octet (2nd, 3rd or 4th) receieved as 1st" -- 1000:0000 - 1011:1111
			or "Unable to determine octet length indicator in first byte of UTF-8 value"
	end

	local function _checkCodePointIssue(code_point, u8_len)
		if options.check_surrogates then
			if code_point >= 0xd800 and code_point <= 0xdfff then
				return false, "UTF-8 prohibits values between 0xd800 and 0xdfff (the surrogate range.) Received: "
					.. string.format("0x%x", code_point)
			end
		end

		-- Look for overlong values based on the octet count
		-- (Only applicable if known to have originated from a code unit.)
		if u8_len ~= false then
			local min_max = lut_oct_min_max[u8_len]
			if code_point < min_max[1] or code_point > min_max[2] then
				return false, u8_len .. "-octet length mismatch. Got: " .. code_point
					.. ", must be in this range: " .. min_max[1] .. " - " .. min_max[2]
			end
		end

		return true
	end

	local function _checkCodeUnitIssue(str, pos)
		local b1, b2, b3, b4
		b1 = string.byte(str, pos)
		if not b1 then
			return false, "string.byte() failed at position " .. pos
		end

		-- Bad length marker in octet 1?
		local ok_or_err = _getLengthMarker(b1)
		if type(ok_or_err) == "string" then
			return false, "failed to parse octet Length marker: " .. ok_or_err
		end
		local u8_len = ok_or_err

		-- Check octet 1 against some bytes which are prohibited in any position in a UTF-8 code point
		if utf8Tools.lut_invalid_octet[b1] then
			return false, _errStrInvalidOctet(1, b1)
		end

		local err_str

		-- Check subsequent bytes in longer code units
		-- Two bytes
		if u8_len == 2 then
			b2 = string.byte(str, pos+1)

			err_str = _checkFollowingOctet(b2, 2, u8_len); if err_str then return false, err_str; end

			-- Three bytes
		elseif u8_len == 3 then
			b2, b3 = string.byte(str, pos+1, pos+2)

			err_str = _checkFollowingOctet(b2, 2, u8_len); if err_str then return false, err_str; end
			err_str = _checkFollowingOctet(b3, 3, u8_len); if err_str then return false, err_str; end

			-- Four bytes
		elseif u8_len == 4 then
			b2, b3, b4 = string.byte(str, pos+1, pos+3)

			err_str = _checkFollowingOctet(b2, 2, u8_len); if err_str then return false, err_str; end
			err_str = _checkFollowingOctet(b3, 3, u8_len); if err_str then return false, err_str; end
			err_str = _checkFollowingOctet(b4, 4, u8_len); if err_str then return false, err_str; end
		end

		-- Need to check some more prohibited values
		local num_check = _numberFromOctets(u8_len, b1, b2, b3, b4)
		local point_ok, point_err = _checkCodePointIssue(num_check, u8_len)
		if not point_ok then
			return false, point_err
		end

		return true
	end


	local function _codePointToBytes(number)
		if number < 0x80 then
			return number

		elseif number < 0x800 then
			local b1 = 0xc0 + math.floor(number / 0x40)
			local b2 = 0x80 + (number % 0x40)

			return b1, b2

		elseif number < 0x10000 then
			local b1 = 0xe0 + math.floor(number / 0x1000)
			local b2 = 0x80 + math.floor( (number % 0x1000) / 0x40)
			local b3 = 0x80 + (number % 0x40)

			return b1, b2, b3

		elseif number < 0x10ffff then
			local b1 = 0xf0 + math.floor(number / 0x40000)
			local b2 = 0x80 + math.floor( (number % 0x40000) / 0x1000)
			local b3 = 0x80 + math.floor( (number % 0x1000) / 0x40)
			local b4 = 0x80 + (number % 0x40)

			return b1, b2, b3, b4
		end
	end


	local function _bytesToCodeUnit(b1, b2, b3, b4)
		if b4 then
			return string.char(b1, b2, b3, b4)
		elseif b3 then
			return string.char(b1, b2, b3)
		elseif b2 then
			return string.char(b1, b2)
		else
			return string.char(b1)
		end
	end

	-- / Internal Logic

	-- Public Functions -- Main Interface

	--- Get a UTF-8 code unit from a string at a specific byte-position.
	-- @param str The string to examine.
	-- @param pos The starting byte-position of the code unit in the string.
	-- @return The code unit, as a string, or nil + error string if unable to get a valid UTF-8 code unit.
	function utf8Tools.getCodeUnit(str, pos)
		_assertArgType(1, str, "string")
		_assertArgType(2, pos, "number")

		if pos < 1 or pos > #str then
			return nil, "string index is out of bounds"
		end

		-- Run up to four patterns matching UTF-8 code units, 1-4 bytes in size, anchored to 'pos'.
		-- These patterns exclude bytes forbidden by the RFC (see: lut_invalid_octet)
		local u8_str
		local u8_ptn = options.match_exclude and utf8Tools.u8_ptn_excl_t or utf8Tools.u8_ptn_t
		for i = 1, 4 do
			u8_str = string.match(str, u8_ptn[i], pos)
			if u8_str then
				break
			end
		end

		-- The Lua string library isn't able to communicate why a pattern failed, so if there's
		-- a problem, we'll have to do some additional work to identify the root cause.
		if not u8_str then
			local _, issue = _checkCodeUnitIssue(str, pos)
			issue = issue or "(Diagnosis failed. Possible issue with parsing or error handler?)"

			return nil, "Unable to get code unit: " .. issue
		end

		-- Three-byte code units contain a forbidden surrogate range of 0xd800 to 0xdfff.
		-- In UTF-8 form, this goes from ED A0 80 to ED A3 BF. it can be tested
		-- by checking if the first two bytes are (0xed, 0xa0-0xa3).
		if #u8_str == 3 and options.check_surrogates then
			if string.find(u8_str, "^\xED[\xA0-\xA3]") then
				return nil, "Code point is in the surrogate range, which is invalid for UTF-8"
			end
		end

		return u8_str
	end


	--- If str[pos] is not a start byte, return the index of the next byte which resembles the first octet of a UTF-8 code unit. Does not validate the following bytes.
	-- @param str The string to march through.
	-- @param pos Starting position in the string.
	-- @return The next start index (or the same old index if it appeared to be a start byte), or nil if none found.
	function utf8Tools.step(str, pos)
		_assertArgType(1, str, "string")
		_assertArgType(2, pos, "number")

		if pos < 1 or pos > #str then
			error("argument #2 is out of bounds")
		end

		local i = string.find(str, utf8Tools.u8_oct_1, pos)
		return (i) or nil
	end

	-- / Public Functions -- Main Interface

	-- Public Functions -- Diagnostics

	--- Scan a string for bytes that are forbidden by the UTF-8 spec. (see: lut_invalid_octet)
	-- @param str The string to check.
	-- @return Index and value of the first bad byte encountered, or nil if none found.
	function utf8Tools.invalidByteCheck(str)
		_assertArgType(1, str, "string")

		for i = 1, #str do
			local bad_byte = utf8Tools.lut_invalid_octet[string.byte(str, i)]
			if bad_byte then
				return i, string.byte(str, i)
			end
		end

		return nil
	end


	--- Scan a string for malformed UTF-8 code units (forbidden bytes[*1], code points in the surrogate range[*2], and
	--  mismatch between length marker and number of bytes.)
	--  [*1] 'options.match_exclude' must be true.
	--  [*2] 'options.check_surrogates' must be true.
	-- @param str The string to check.
	-- @return Index, plus a string which attempts to diagnose the issue, or nil if no malformed code units were found.
	function utf8Tools.hasMalformedCodeUnits(str)
		_assertArgType(1, str, "string")

		local i = 1
		while i <= #str do
			local u8_str, err = utf8Tools.getCodeUnit(str, i)
			if not u8_str then
				return i, err
			end
			i = i + #u8_str
		end

		return nil
	end

	-- / Public Functions: Diagnostics

	-- Public Functions: Conversions

	--- Try to convert a UTF-8 Code Unit in string form to a Unicode Code Point number.
	-- @param unit_str The string to convert. Must be between 1-4 bytes in size.
	-- @return The code point in number form, which may be invalid, and an error string if a problem
	-- was detected. If the second return value is nil, then this module thinks it's valid. Caller
	-- is responsible for deciding whether to accept or deny bad results.
	function utf8Tools.u8UnitToCodePoint(unit_str)
		_assertArgType(1, unit_str, "string")
		if #unit_str < 1 or #unit_str > 4 then
			error("argument #1 must be a string 1-4 bytes in size")
		end

		local ok, err = _checkCodeUnitIssue(unit_str, 1)

		local code_point = _numberFromOctets(#unit_str, string.byte(unit_str, 1, 4))

		-- (No point in error-checking the code point if a problem was found with the code unit.)
		if err == nil then
			local _
			_, err = _checkCodePointIssue(code_point, #unit_str)
		end

		return code_point, err
	end


	--- Try to convert a Unicode Code Point in numeric form to a UTF-8 Code Unit string.
	-- @param code_point_num The code point to convert. Must be an integer and at least 0. (WARNING: The high-end limit is not checked.)
	-- @return the code unit in string form, which may be invalid, and an error string if there was a problem 
	-- validating the code unit.
	-- If the second return value is nil, then this module thinks it's valid. Caller is responsible for
	-- deciding whether to accept or deny bad results.
	function utf8Tools.u8CodePointToUnit(code_point_num)
		if type(code_point_num) ~= "number" or code_point_num < 0 or code_point_num ~= math.floor(code_point_num) then
			error("argument #1 must be an integer >= 0")
		end

		local b1, b2, b3, b4 = _codePointToBytes(code_point_num)
		if not b1 then
			return "�", "failed to convert code point to UTF-8 bytes"
		end

		local u8_unit = _bytesToCodeUnit(b1, b2, b3, b4)
		local ok, err = _checkCodeUnitIssue(u8_unit, 1)

		return u8_unit, err
	end
end


local stringReader = {
	_VERSION = "1.0.0",
	_URL = "https://github.com/rabbitboots/string_reader",
	_DESCRIPTION = "Wrappers for Lua string functions.",
	_LICENSE = [[
	Copyright (c) 2022 RBTS

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
	]]
}
-- Assertions

do
	local dummy_t = {}
	local _mt_reader = {}
	_mt_reader.__index = _mt_reader
	stringReader._mt_reader = _mt_reader
	local function _errStrBadArg(arg_n, val, expected)
		return "bad argument #" .. arg_n .. " (expected " .. expected .. ", got " .. type(val) .. ")"
	end


	local function _assertArgType(arg_n, val, expected)
		if type(val) ~= expected then
			error(_errStrBadArg(arg_n, val, expected))
		end
	end


	local function _assertArgSeqType(arg_n, seq_n, val, expected)
		if type(val) ~= expected then
			error("argument # " .. arg_n .. ": bad table index #" .. seq_n
				.. " (expected " .. expected .. ", got " .. type(val) .. ")")
		end	
	end


	local function _assertNumGE(arg_n, val, ge)
		if type(val) ~= "number" then
			error(_errStrBadArg(arg_n, val, "number"), 2)
		elseif val < ge then
			error("bad argument #" .. arg_n .. ": number must be at least " .. ge, 2)
		end
	end


	-- (Checks the reader object internal state.)
	local function _assertState(str, pos)
		if type(str) ~= "string" then
			error("state assertion failure: str is not of type 'string'", 2)
		elseif type(pos) ~= "number" then
			error("state assertion failure: pos is not of type 'number'", 2)
		elseif pos < 1 then
			error("state assertion failure: pos must be at least 1", 2)
		end
		-- 'pos' being beyond #str is considered 'eos'
	end

	-- / Assertions

	-- Internal Functions

	--- Get the length marker from a UTF-8 code unit's first byte.
	-- @param byte The first byte to check.
	-- @return 1, 2, 3 or 4, or false if the byte was a trailing octet, or nil if it couldn't be interpreted as a UTF-8 byte.
	local function _u8GetOctetLengthMarker(byte)
		return (byte < 0x80) and 1 -- 0000:0000 - 0111:1111 (ASCII)
			or (byte >= 0xC0 and byte < 0xE0) and 2 -- 1100:0000 - 1101:1111
			or (byte >= 0xE0 and byte < 0xF0) and 3 -- 1110:0000 - 1110:1111
			or (byte >= 0xF0 and byte < 0xF8) and 4 -- 1111:0000 - 1111:0111
			or (byte >= 0x80 and byte < 0xBF) and false -- 1000:0000 - 1011:1111 (Trailing octet)
			or nil -- Not a UTF-8 byte?
	end


	-- Try to determine the line number and character column in 'str' based on the index in 'byte_pos'.
	local function _lineNum(str, byte_pos)
		if byte_pos > #str then
			return "(End of string)", "(n/a)"
		end

		-- March through every code-unit until we either catch up to 'pos'
		-- or we are unable to parse a code unit.
		local i, line_num, column = 1, 1, 1

		while true do
			local byte = string.byte(str, i)
			if not byte then
				return false
			end
			local code_unit_length = _u8GetOctetLengthMarker(byte)
			if not code_unit_length then
				return false
			end
			i = i + code_unit_length
			if i > byte_pos then
				break
			end

			-- Try to step around the Windows carriage return + line feed pair
			if byte == 0xd then
				local byte2 = string.byte(str, i + 1)
				if byte2 == 0xa then
					i = i + 1
				end
			end

			-- line feed
			if byte == 0xa then
				line_num = line_num + 1
				column = 0
			end
			column = column + 1
		end

		return line_num, column
	end


	local function _getLineInfo(self)
		if self.hide_line_num then
			return ""
		end

		local line_num, char_col

		-- Calling reader state assertions while handling an error risks overruling more
		-- valuable error messages with generic "bad state" ones.
		if type(self.str) ~= "string" or type(self.pos) ~= "number" then
			line_num, char_col = "Unknown (Corrupt reader)", "Unknown"

		else
			line_num, char_col = _lineNum(self.str, self.pos)
			-- Couldn't get current line: return unknown
			if not line_num then
				line_num, char_col = "(Unknown)", "(Unknown)"
			end
		end

		char_col = char_col or "(Unknown)"

		local line_info = "line " .. line_num
		if not self.hide_char_num then
			line_info = line_info .. " position " .. char_col
		end

		return line_info
	end


	local function _lit(str, pos, chunk)
		return (string.sub(str, pos, pos + #chunk-1) == chunk)
	end


	local function _fetch(str, pos, ptn, literal)
		local i, j = string.find(str, ptn, pos, literal)
		if i then
			return j + 1, string.sub(str, i, j)
		end

		return nil
	end


	local function _cap(str, pos, ptn)
		local i, j, c1, c2, c3, c4, c5, c6, c7, c8, c9 = string.find(str, ptn, pos)
		if not c1 then
			return nil
		end

		return j + 1, c1, c2, c3, c4, c5, c6, c7, c8, c9	
	end


	local function _clearCaptures(c)
		for i = #c, 1, -1 do
			c[i] = nil
		end
	end


	-- / Internal Functions

	-- Reader Methods: Main Interface

	--- Extract a substring from (pos + n) to (pos + n2) without advancing the reader position.
	-- @param n (Default: 0) First offset.
	-- @param n2 (Default: n) Second offset.
	-- @return The substring from (pos + n) to (pos + n2), or an empty string if that position is completely out of bounds.
	function _mt_reader:peek(n, n2)
		-- **WARNING**: This operates on byte offsets, and may return invalid portions of multi-byte UTF-8 code units as a result.
		_assertState(self.str, self.pos)
		_clearCaptures(self.c)

		n = n == nil and 0 or n
		n2 = n2 == nil and n or n2
		_assertArgType(1, n, "number")
		_assertArgType(2, n2, "number")

		-- self:peek() -> string.sub(self.str, self.pos, self.pos)
		-- self:peek(1) -> string.sub(self.str, self.pos + 1, self.pos + 1)
		-- self.peek(0, 5) -> string.sub(self.str, self.pos, self.pos + 4) -- (reads 5 bytes)

		return string.sub(self.str, self.pos + n, self.pos + n2)
	end


	--- Try to read one UTF-8 code unit from self.str starting at self.pos. If successful, advance position. If position is eos, return nil. If the current byte is not the start of a valid UTF-8 code unit, or is not a valid UTF-8 byte, raise an error.
	-- @param _guard Internal use, leave nil.
	-- @return String containing the char or code unit, or nil if reached end of string.
	function _mt_reader.u8Char(self, _guard)
		_assertState(self.str, self.pos)
		_assertArgType(1, _guard, "nil")
		_clearCaptures(self.c)

		-- eos
		if self.pos > #self.str then
			return nil
		end

		local u8_len = _u8GetOctetLengthMarker(string.byte(self.str, self.pos))
		if u8_len == false then
			error("encoding or parsing error: got trailing octet / continuation byte.")
		elseif u8_len == nil then
			error("encoding error: got non-UTF-8 byte")
		end

		local retval = string.sub(self.str, self.pos, self.pos + u8_len-1)
		self.pos = self.pos + u8_len

		return retval
	end


	--- Try to read n UTF-8 code units in self.str, beginning at self.pos. If successful, advance position. If either the starting or final position is eos, return nil. If there is a problem decoding the UTF-8 bytes, raise a Lua error.
	-- @param n (Required) How many code units to read from pos. Must be at least 1.
	-- @return String chunk plus bytes read, or nil if reached end of string.
	function _mt_reader.u8Chars(self, n)
		_assertState(self.str, self.pos)
		_assertNumGE(1, n, 1)
		_clearCaptures(self.c)

		local orig_pos = self.pos
		local temp_pos = self.pos
		local u8_count = 0

		-- Find the last byte of the last u8Char in the specified range.
		while true do
			if u8_count >= n then
				break

				-- eos
			elseif temp_pos > #self.str then
				return nil
			end

			local u8_len = _u8GetOctetLengthMarker(string.byte(self.str, temp_pos))

			if u8_len == false then
				error("encoding or parsing error: got trailing octet / continuation byte.")
			elseif u8_len == nil then
				error("encoding error: got non-UTF-8 byte")
			end

			u8_count = u8_count + 1
			temp_pos = temp_pos + u8_len
		end

		local retval = string.sub(self.str, orig_pos, temp_pos - 1)

		self.pos = temp_pos

		return retval, temp_pos - orig_pos
	end


	--- Try to read a one-byte string from self.str at self.pos. If successful, advance position. If position is eos, return nil.
	-- @param _guard Internal use, must be left nil. Intended to help catch byteChar|byteChars mispellings.
	-- @return String containing the char, or nil if reached end of string.
	function _mt_reader:byteChar(_guard)
		-- **WARNING**: This may return incomplete portions of multi-byte UTF-8 code units.
		_assertState(self.str, self.pos)
		_assertArgType(1, _guard, "nil")
		_clearCaptures(self.c)

		-- eos
		if self.pos > #self.str then
			return nil
		end

		local retval = string.sub(self.str, self.pos, self.pos)

		self.pos = self.pos + 1
		return retval
	end


	--- Try to read n chars (bytes) in self.str from self.pos to self.pos + n or #self.str, whichever is shorter. If successful, advance position. If range goes out of bounds (eos), return nil.
	-- @param n (Required) How many bytes to read from pos. Must be at least 1.
	-- @return String chunk plus bytes read, or nil if reached end of string.
	function _mt_reader:byteChars(n)
		-- **WARNING**: This may return incomplete portions of multi-byte UTF-8 code units.
		_assertState(self.str, self.pos)
		_assertNumGE(1, n, 1)
		_clearCaptures(self.c)

		local orig_pos = self.pos

		-- eos
		if self.pos > #self.str then
			return nil
		end
		local far_pos = self.pos + n-1
		if far_pos > #self.str then
			return nil
		end

		local retval = string.sub(self.str, self.pos, far_pos)

		self.pos = far_pos + 1

		return retval, far_pos - (orig_pos - 1)
	end


	--- Check for 'chunk' anchored to the current position, as a string literal (no pattern matching.) If found, advance position and return the chunk. If not found, stay put and return nil.
	-- @param chunk The string literal to check.
	-- @return the chunk string if found, nil if not.
	function _mt_reader:lit(chunk)
		_assertState(self.str, self.pos)
		_assertArgType(1, chunk, "string")
		_clearCaptures(self.c)

		if _lit(self.str, self.pos, chunk) then
			self.pos = self.pos + #chunk
			return chunk
		end

		return nil
	end

	--- Version of self:lit() that raises an error if the match isn't successful.
	-- @param chunk The string literal to check.
	-- @param err_reason (Optional) An error message to pass to the error handler, if the search was not successful.
	-- @return the chunk string, if found. If not, raises an error.
	function _mt_reader:litReq(chunk, err_reason)
		local retval = self:lit(chunk)
		if not retval then
			err_reason = err_reason or "litReq failed"
			self:errorHalt(err_reason)
		end

		return retval
	end


	--- Search for 'ptn' starting at the current position.
	-- @param ptn The string pattern to find.
	-- @param literal (Default: false) When true, conducts a "plain" search with no magic pattern tokens. (Unlike self:lit(), this is not anchored to the current position.)
	-- @return The successful string match, or nil if the search failed.
	function _mt_reader:fetch(ptn, literal)
		_assertState(self.str, self.pos)
		_assertArgType(1, ptn, "string")
		literal = literal ~= nil and literal or false
		_assertArgType(2, literal, "boolean")
		_clearCaptures(self.c)

		local new_pos, chunk = _fetch(self.str, self.pos, ptn, literal)
		if new_pos then
			self.pos = new_pos
			return chunk
		end

		return nil
	end


	--- Version of self:fetch() which raises an error if the pattern search failed.
	-- @param ptn The string pattern to find.
	-- @param literal (Default: false) When true, conducts a "plain" search with no magic pattern tokens. (Unlike self:lit(), this is not anchored to the current position.)
	-- @param err_reason (Optional) An error message that can be passed to the error handler there wasn't a match.
	-- @return The pattern match substring on success. On failure, raise a Lua error.
	function _mt_reader:fetchReq(ptn, literal, err_reason)
		local chunk = self:fetch(ptn, literal)
		if not chunk then
			err_reason = err_reason or "fetch failed"
			self:errorHalt(err_reason)
		end
		return chunk
	end


	--- Search for a string pattern containing capture definitions. If the first capture was successful, assign the capture results to an internal table, advance position, and return true. If false, clear existing captures and return false.
	-- @param ptn A string pattern with at least one capture definition. Lua supports up to nine captures per string search. 
	-- @return true on successful pattern match, nil if the pattern match failed. Successful captures can be read in 'self.c[1..9]'.
	function _mt_reader:cap(ptn)
		_assertState(self.str, self.pos)
		_assertArgType(1, ptn, "string")
		_clearCaptures(self.c)

		-- The reason for storing captures and not returning them directly is so that you
		-- can include self:cap() in an if/elseif/else chain.

		local new_pos, c1, c2, c3, c4, c5, c6, c7, c8, c9 = _cap(self.str, self.pos, ptn)
		if c1 then
			self.pos = new_pos
			local c = self.c
			c[1], c[2], c[3], c[4], c[5], c[6], c[7], c[8], c[9] = c1, c2, c3, c4, c5, c6, c7, c8, c9
			return true
		end

		return nil
	end


	--- A version of self:cap() which raises an error if the match was unsuccessful.
	-- @param ptn A string pattern with at least one capture definition. Lua supports up to nine captures per string search. 
	-- @param err_reason (Optional) An error message that can be passed to the error handler there wasn't a match.
	-- @return Nothing. Successful captures can be read in 'self.c[1..9]'. On failure, raises a Lua error.
	function _mt_reader:capReq(ptn, err_reason)
		local success = self:cap(ptn)
		if not success then
			err_reason = err_reason or "capReq failed"
			self:errorHalt(err_reason)
		end
	end


	--- Step over optional whitespace.
	-- @return true if the position advanced, false if not.
	function _mt_reader:ws()
		_assertState(self.str, self.pos)
		_clearCaptures(self.c)

		local old_pos = self.pos
		local i, j = string.find(self.str, "%S", self.pos)

		if not i then -- marched to eos
			self.pos = #self.str + 1
		else
			self.pos = i
		end

		return self.pos ~= old_pos
	end


	--- Pass over mandatory whitespace, raising an error if none is encountered.
	-- @param err_reason (Optional) An error message that can be passed to the error handler there wasn't a match.
	-- @return Nothing.
	function _mt_reader:wsReq(err_reason)
		_assertState(self.str, self.pos)
		_clearCaptures(self.c)

		if not string.match(string.sub(self.str, self.pos, self.pos), "%s") then
			err_reason = err_reason or "mandatory whitespace not found"
			self:errorHalt(err_reason)
		end

		local i, j = string.find(self.str, "%s+", self.pos)

		if not i then -- marched to eos
			self.pos = #self.str + 1
		else
			self.pos = j + 1
		end
	end


	--- Assuming we are currently on non-whitespace, advance to the next whitespace character.
	-- @return nothing.
	function _mt_reader:wsNext()
		_assertState(self.str, self.pos)
		_clearCaptures(self.c)

		-- If current position is on whitespace, stay put.
		if string.match(string.sub(self.str, self.pos, self.pos), "%s") then
			return
		end
		local i, j = string.find(self.str, "%s", self.pos + 1)

		if i then
			self.pos = i
		else
			self.pos = #self.str + 1
		end
	end


	--- Assign a new string to the reader. Resets position to 1.
	-- @param new_str The string to set.
	-- @return Nothing.
	function _mt_reader:newStr(new_str)
		_assertArgType(1, new_str, "string")
		_clearCaptures(self.c)

		self.str = new_str
		self.pos = 1
	end


	--- Reset position to start of string.
	-- @return Nothing.
	function _mt_reader:reset()
		_clearCaptures(self.c)
		self.pos = 1
	end


	--- Manually clear stored captures. (Most methods do this automatically as a first step.)
	-- @return nothing.
	function _mt_reader:clearCaptures()
		_clearCaptures(self.c)
	end


	--- Check if reader is past the end of the string.
	-- @return true if end of string reached, false otherwise.
	function _mt_reader:isEOS()
		_assertState(self.str, self.pos)
		return self.pos > #self.str
	end


	--- Move the reader position to the end of the string. (#self.str + 1)
	-- @return nothing.
	function _mt_reader:goEOS()
		_assertState(self.str, self.pos)
		self.pos = #self.str + 1
	end

	-- / Reader Methods: Main Interface

	-- Reader Methods: Util

	--- Get the current line number. Line start is determined by the number of line feed characters from byte 1 to (self.pos - 1).
	-- @return Count of newlines, or "(End of String)" if position is out of bounds.
	function _mt_reader:lineNum()
		_assertState(self.str, self.pos)
		return _lineNum(self.str, self.pos)
	end


	function _mt_reader:warn(warn_str)
		_assertArgType(1, warn_str, "string")

		if self.terse_errors then
			return
		end

		print(_getLineInfo(self) .. ": " .. warn_str)
	end


	--- Raise a Lua error with the current position's line number included in the output.
	-- @param err_str The string to print. If not a string, a generic string indicating the object type will be used instead (similar to passing a bad type to error() in Lua 5.4.)
	-- @param err_level (Default: 1) The stack level to pass to error().
	function _mt_reader:errorHalt(err_str, err_level)
		if self.terse_errors then
			error("Parsing failed.")
		end

		err_level = err_level ~= nil and err_level or 2

		-- error() would normally catch a bad arg #1, but we may need to concatenate this to the line and char numbers.
		if type(err_str) ~= "string" then
			err_str = "(err_str is a " .. type(err_str) .. " object)"
		end

		error(_getLineInfo(self) .. ": " .. err_str, err_level)
	end

	-- / Reader Methods: Util

	-- Public Functions

	--- Make a new reader object.
	-- @param str (Optional) The string to read. Default: empty string ("")
	-- @param opts (Optional) Table of options to pass.
	-- @param opts.terse_errors When true, all errorHalt() calls print just "Parsing failed.", and warn() is muted.
	-- @param opts.hide_line_num When true, doesn't print the line and character number in errorHalt() and warn().
	function stringReader.new(str, opts)
		str = (str == nil) and "" or str
		opts = (opts == nil) and dummy_t or opts

		_assertArgType(1, str, "string")
		_assertArgType(2, opts, "table")

		local self = {}

		self.str = str
		self.pos = 1

		-- Omits line number from error messages
		self.hide_line_num = opts.hide_line_num or false
		self.hide_char_num = opts.hide_char_num or false -- 'hide_line_num == true' overrides this
		-- Replaces all error messages with "Parsing failed", and silences warnings.
		-- This also hides the line number and character number.
		self.terse_errors = opts.terse_errors or false

		-- Capture results 1-9
		self.c = {}
		setmetatable(self, _mt_reader)

		return self
	end


	function stringReader.lineNum(str, pos)
		-- Don't assert reader state: this should be usable out of context.
		_assertArgType(1, str, "string")
		_assertArgType(2, pos, "number")

		return _lineNum(str, pos)
	end
end

-- Prerelease -- 2022-03-17
local labelStack = {}
do
	

	local _mt_stack = {}
	_mt_stack.__index = _mt_stack

	local _stack_max = 65536

	function labelStack.new()

		local self = {}

		-- 0: Print nothing
		-- 1: self:report() prints the current label
		-- 2: self:report() prints the entire label stack
		-- 3: self:report() prints every time a label is pushed or popped
		self.report_level = 0
		self.stack = {"<stack_root>"}

		self.top = self.stack[#self.stack]

		setmetatable(self, _mt_stack)

		return self
	end

	function _mt_stack:push(label)
		if #self.stack >= _stack_max then
			error("LabelStack overflow")
		end
		self.stack[#self.stack + 1] = label
		self.top = label
		if self.report_level >= 3 then
			print(string.rep(" ", #self.stack-1) .. "+" .. label)
		end
	end

	function _mt_stack:pop()
		local label
		label, self.stack[#self.stack] = self.stack[#self.stack], nil
		if self.report_level >= 3 then
			print(string.rep(" ", #self.stack) .. "-" .. label)
		end
		return label
	end

	function _mt_stack:report()
		if self.report_level >= 1 then
			if self.report_level == 1 then
				print("L " .. self.top)

			elseif self.report_level >= 2 then
				for i = 1, #self.stack do
					print("> (" .. i .. ") " .. self.stack[i])
				end
				print("n")
			end
		end
	end
end


--local path = ... and (...):match("(.-)[^%.]+$") or ""

-- Shared functions for xmlToTable submodules.

--[[
	Copyright (c) 2022 RBTS
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
--]]

local xmlShared = {}

-- Assertions

function xmlShared.assertArgType(arg_n, var, expected)
	if type(var) ~= expected then
		error("bad argument #" .. arg_n .. " (Expected " .. expected .. ", got " .. type(var) .. ")", 2)
	end
end

function xmlShared.assertArgNumGE(arg_n, var, min)
	if type(var) ~= "number" or var < min then
		error("argument #" .. arg_n .. " needs to be a number >= " .. min)
	end
end

local xmlObj = {}

-- Submodules
local _assertArgType = xmlShared.assertArgType
local _assertArgNumGE = xmlShared.assertArgNumGE

-- Component metatables
do
	-- The parser root -- not part of the XML spec
	local _mt_parser_root = {}
	_mt_parser_root.__index = _mt_parser_root
	xmlObj._mt_parser_root = _mt_parser_root

	local _mt_element = {}
	_mt_element.__index = _mt_element
	xmlObj._mt_element = _mt_element

	local _mt_char_data = {}
	_mt_char_data.__index = _mt_char_data
	xmlObj._mt_char_data = _mt_char_data

	local _mt_pi = {}
	_mt_pi.__index = _mt_pi
	xmlObj._mt_pi = _mt_pi
end
do
	--- Get the main document element from the parser root. (The method is to find the first element child of the parser root.)
	-- @return The document root entity, or nil if it can't be found. 
	local function _getRootElement(self)
		for i, child in ipairs(self.children) do
			if child.id == "element" then
				return child
			end
		end
		return nil
	end
	xmlObj._mt_parser_root.getRootElement = _getRootElement


	--- Get an attribute key="value" pair based on its key.
	-- @param The calling entity.
	-- @param key_id String ID to check.
	-- @return The attribute value, or nil if it wasn't populated in this element.
	local function _getAttribute(self, key_id)
		-- Don't assert 'self'
		_assertArgType(1, key_id, "string")

		local index = self.attribs_hash[key_id]
		local attrib_t = self.attribs[index]

		if attrib_t then
			return attrib_t.value
		end

		return nil
	end
	xmlObj._mt_element.getAttribute = _getAttribute
	-- The parser root isn't part of the XML document and doesn't have attributes.


	--- Find the first child element starting from 'i' with the name 'id'.
	-- @param id String ID of the child element.
	-- @param i (Default: 1) Where to start searching in the child table.
	-- @return Child element table and child index, or nil if not found or if the list is empty.
	local function _findChild(self, id, i)
		-- Don't assert 'self'
		i = (i == nil) and 1 or i
		_assertArgType(1, id, "string")
		_assertArgNumGE(2, i, 1)

		for ii = i, #self.children do
			local child = self.children[ii]
			if child.name == id then
				return child, ii
			end
		end

		return nil
	end
	xmlObj._mt_parser_root.findChild = _findChild
	xmlObj._mt_element.findChild = _findChild


	--- Convenience method to get text string from a PI or character data table.
	-- @return the contents of 'entity.text'
	local function _getText(self)
		-- Don't assert 'self'
		return self.text
	end
	xmlObj._mt_char_data.getText = _getText
	xmlObj._mt_pi.getText = _getText
end

local xmlToTable = {
	_VERSION = "1.0.1",
	_URL = "https://github.com/rabbitboots/xml_to_table",
	_DESCRIPTION = "Converts a subset of XML to a Lua table.",
	_LICENSE = [[
	Copyright (c) 2022 RBTS

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
	]]
}

--[[
	This file should cooperate with 'strict.lua', a common Lua troubleshooting snippet / library.
--]]

-- Submodules
do
	local _assertArgType = xmlShared.assertArgType
	local _assertArgNumGE = xmlShared.assertArgNumGE


	-- Libraries

	-- Module-wide config
	local options = {}
	xmlToTable.options = options

	options.prepass = {}
	-- Check entire XML string for Nul chars, which are prohibited by the spec.
	options.prepass.doc_check_nul = true

	-- Check entire XML string for code points that are not supported per the spec.
	options.prepass.doc_check_xml_unsupported_chars = true

	-- Convert '\r\n' and '\r' to '\n', per the spec. You may disable this if you control the incoming
	-- XML strings, and know for a fact that they are already normalized. (Doing this in Lua may
	-- generate up to two temporary versions of the XML document string.)
	options.prepass.normalize_end_of_line = true

	-- Confirm that XML Names conform to the characters in 'lut_name_start_char' and 'lut_name_char'.
	options.validate_names = true

	-- Fail on duplicate attribute declarations within an element.
	-- (The spec forbids this.)
	options.check_dupe_attribs = true

	-- Allow bad escape sequences through as-is, so long as they start with '&' and end with ';'
	-- Not recommended, and forbidden by the spec.
	options.ignore_bad_escapes = false

	-- Keep character data entities which are comprised solely of whitespace between element tags
	options.keep_insignificant_whitespace = false -- XXX this may not be working correctly.


	-- Lookup Tables and Patterns

	-- Set up a lookup table
	local function makeLUT(t)
		local lut = {}
		for i, v in ipairs(t) do
			lut[v] = true
		end
		return lut
	end


	-- Set up an inverse lookup table
	local function makeInverseLUT(t)
		local lut = {}
		for k, v in pairs(t) do
			lut[v] = k
		end
		return lut
	end


	--- Check if a value is within one of a series of ranges.
	local function checkRangeLUT(lut, value)
		for _, range in ipairs(lut) do
			if type(range) == "number" then
				if value == range then
					return true
				elseif value < range then
					return false
				end
			else
				if value >= range[1] and value <= range[2] then
					return true
				elseif value < range[1] then
					return false
				end
			end
		end
		return false
	end


	local lut_attrib_escape = {
		["<"] = "lt",
		[">"] = "gt",
		["&"] = "amp",
		["\""] = "quot",
		["'"] = "apos"
	}
	-- "&#n;", where 'n' is a series of 0-9 digits
	-- "&#xn;", where 'n' is a series of 0-f hex values
	local lut_attrib_reverse = makeInverseLUT(lut_attrib_escape)


	-- Valid code points and code point ranges for an XML document as a whole.
	-- https://www.w3.org/TR/xml/#charsets
	-- https://en.wikipedia.org/wiki/Valid_characters_in_XML
	local lut_xml_unicode = {
		0x0009,
		0x000a,
		0x000d,
		{0x0020, 0xd7ff},
		{0xe000, 0xfffd},
		{0x10000, 0x10ffff},
	}

	-- Valid code points for the start of a name
	local lut_name_start_char = {
		string.byte(":"),
		{string.byte("A"), string.byte("Z")},
		string.byte("_"),
		{string.byte("a"), string.byte("z")},
		{0xC0, 0xD6},
		{0xD8, 0xF6},
		{0xF8, 0x2FF},
		{0x370, 0x37D},
		{0x37F, 0x1FFF},
		{0x200C, 0x200D},
		{0x2070, 0x218F},
		{0x2C00, 0x2FEF},
		{0x3001, 0xD7FF},
		{0xF900, 0xFDCF},
		{0xFDF0, 0xFFFD},
		{0x10000, 0xEFFFF},
	}

	-- Valid code points for names. (This is in addition to lut_name_start_char.)
	local lut_name_char = {
		string.byte("-"),
		string.byte("."),
		{string.byte("0"), string.byte("9")},
		0xB7,
		{0x0300, 0x036F},
		{0x203F, 0x2040},
	}

	-- / Lookup Tables and Patterns

	local function indent(reps)
		return string.rep(" ", reps)
	end


	--- Parse an escaped character (ie &lt;)
	-- @param chunk Contents of the escape sequence, with the opening '&' and closing ';' omitted.
	-- @return the code unit, or the original chunk plus error string if there was a problem. Caller is responsible
	-- for deciding whether to use the bad data or not. When called through gsub, this second
	-- return value is discarded.
	local function _unescape(chunk)
		-- Direct escape match?
		if lut_attrib_reverse[chunk] then
			return lut_attrib_reverse[chunk]

			-- Try numeric codes
		elseif string.sub(chunk, 1, 1) == "#" then
			-- Decimal (&#n;)
			local base, start_i = 10, 2

			-- Adjustments for hex numbers (&#xn;)
			if string.sub(chunk, 2, 2) == "x" then
				base, start_i = 16, 3
			end

			local code_from_str = tonumber(string.upper(string.sub(chunk, start_i, #chunk)), base)
			if not code_from_str then
				return chunk, "parsing numeric escape value failed"
			end

			local u8_unit, err = utf8Tools.u8CodePointToUnit(code_from_str)
			if err then
				return chunk, "code point to code unit conversion failed"
			end

			return u8_unit
		end

		return chunk, "no escape match found"
	end


	--- Normalize whitespace characters (0x20, 0xD, 0xA, 0x9) to 0x20 (" ")
	local function normalizeAttribWhitespace(str)
		-- https://www.w3.org/TR/REC-xml/#AVNormalize
		return string.gsub(str, "[\x20\x0D\x0A\x09]", "\x20")
	end


	local function unescapeXMLString(sub_str)
		if string.match(sub_str, "<") then
			return false, "'<' literal is not allowed in quoted values."
		end

		-- Convert whitespace symbols to 0x20 (" ")
		sub_str = normalizeAttribWhitespace(sub_str)

		-- Prepass: if no ampersands, just return the original string without going through
		-- the trouble of table.concat().
		if not string.find(sub_str, "&") then
			return sub_str
		end

		local seq = {}
		local i, j, chunk = 1, 0, nil

		while true do
			local last_pos = i
			i, j = string.find(sub_str, "&", j + 1)

			-- End of string
			if not i then
				table.insert(seq, string.sub(sub_str, last_pos, #sub_str))
				break
			end

			local pos_amp = i

			i, j, chunk = string.find(sub_str, "^(.-);", j + 1)
			if not i then
				return false, "couldn't parse escape sequence: found '&' without closing ';'"
			end

			-- Add string contents from last point to just before ampersand
			table.insert(seq, string.sub(sub_str, last_pos, pos_amp - 1))

			-- Advance past semicolon
			i = j + 1

			local u8_unit, err = _unescape(chunk)
			if err then
				if not options.ignore_bad_escapes then
					return false, "unknown escape code (failure to parse content between '&' and ';')"

				else
					-- This seems like a very bad idea, but it might be helpful when debugging.
					u8_unit = "&" .. chunk .. ";"
				end
			end
			table.insert(seq, u8_unit)
		end

		return table.concat(seq)
	end


	--- gsub-powered version of unescapeXMLString(). Probably faster, but doesn't handle failure scenarios.
--[[
local function unescapeXMLString(sub_str) -- XXX untested
	return string.gsub(sub_str, "&(.*);", _unescape)
end
--]]


	local function stepEq(self)
		self:ws()
		self:fetchReq("^=", false, "failed to parse eq (=) separating key-value pair")
		self:ws()
	end

	local function getAttribQuoted(self, err_reason)
	--[[
	NOTE: illegal use of the '<' literal appearing in quoted text is checked in unescapeXMLString().
	--]]
		self:cap("^([\"'])(.-)%1")
		local in_quotes = self.c[2]
		self:clearCaptures()

		-- Raise error only if 'err_reason' was populated
		if not in_quotes and err_reason then
			self:errorHalt(err_reason)
		end

		local esc, esc_err = unescapeXMLString(in_quotes)
		if esc_err then
			self:errorHalt(esc_err)
		end

		return esc
	end


	local function validateXMLName(self, name)
		local i = 1
		while i < #name do
			local u8_unit, u8_err = utf8Tools.getCodeUnit(name, i)
			if not u8_unit then
				self:errorHalt("failed to read character #" .. i .. " in XML Name: " .. u8_err)
			end

			local u8_code = utf8Tools.u8UnitToCodePoint(u8_unit)
			if not u8_code then
				self:errorHalt("failed to convert character #" .. i .. " in XML Name to a code point")
			end

			if not checkRangeLUT(lut_name_start_char, u8_code) then
				if i == 1 then
					self:errorHalt("invalid first character in XML Name")

				elseif not checkRangeLUT(lut_name_char, u8_code) then
					self:errorHalt("invalid character #" .. i .. " in XML Name")
				end
			end

			i = i + #u8_unit
		end
	end


	local function getXMLName(self, err)
		local name = self:fetch("^([^%s=\"'<>/&]+)")

		if name and options.validate_names then
			validateXMLName(self, name)

			-- If 'err' was populated, throw an error. Silently ignore match failure otherwise.
		elseif not name then
			self:errorHalt(err)
		end

		return name
	end


	local function getXMLDecl(self, xml_state, pos_initial)
		if pos_initial ~= 1 then
			self:errorHalt("XML Declaration can only appear at start of document")
		end
		-- The other forbidden stuff -- max 1 xmlDecl per document, no xmlDecl after
		-- document root is declared -- are prevented by the requirement for it to
		-- be the very first thing in the doc with no preceding whitespace.

		local version_num, encoding_val, standalone_val

		self:fetchReq("^%s+version", false, "couldn't read xmlDecl mandatory version identifier")
		stepEq(self)

		self:capReq("^([\"'])(1%.[0-9]+)%1", "couldn't read xmlDecl version value")
		version_num = self.c[2]

		if self:fetch("^%s+encoding") then
			stepEq(self)
			encoding_val = getAttribQuoted(self, "couldn't read xmlDecl encoding value")
		end

		if self:fetch("^%s+standalone") then
			stepEq(self)
			standalone_val = getAttribQuoted(self, "couldn't read xmlDecl standalone value")
		end

		self:fetchReq("^(%?>)", false, "couldn't find xmlDecl closing '?>'")

		local decl = {}
		decl.id = "xml_decl"
		decl.version = version_num
		decl.encoding = encoding_val
		decl.standalone = standalone_val
		-- no metatable

		return decl
	end


	local function getXMLComment(self, xml_state)

		-- Find the comment close and collect an exclusive substring
		local pos_start = self.pos

		self:fetchReq("%-%-", false, "couldn't find closing '--'")
		self:fetchReq("^>", false, "couldn't find '>' to go with closing '--'")

		local pos_end = self.pos - 4

	--[[
	local entity = {}
	entity.id = "comment"
	entity.text = string.sub(self.str, pos_start, pos_end)
	-- no metatable

	-- Don't escape comments

	return entity
	--]]
	end


	local function getXMLProcessingInstruction(self, xml_state)
		local pi_name = getXMLName(self, "failed to read PI name")

		-- Find the PI close and collect an exclusive substring
		local pos_start = self.pos
		self:fetchReq("%?>", false, "failed to locate PI tag close ('?>')")

		local pos_end = self.pos - 3

		local entity = {}
		entity.id = "pi"
		entity.name = pi_name
		entity.text = string.sub(self.str, pos_start, pos_end)
		setmetatable(entity, xmlObj._mt_pi)

		-- Don't escape PI contents.
		-- Application is responsible for parsing this, basically.

		return entity
	end


	local function getXMLDocType(self, xml_state)
		if xml_state.doc_root then
			self:errorHalt("Document Type Declaration cannot appear once document root is declared.")

		elseif xml_state.doc_type then
			self:errorHalt("Only one Document Type Declaration is permitted per document.")
		end

		error("sorry, !DOCTYPE tags are not supported yet")
	end


	local function getXMLElement(self, xml_state)
		if xml_state.doc_close then
			self:errorHalt("element appears after root element close")
		end

		local element_name = getXMLName(self, "failed to read element name")

		local attribs = {}
		local attribs_hash = {}
		local is_empty_tag = false

		if self:lit(">") then
			-- Just eat the char

		elseif self:lit("/>") then
			is_empty_tag = true

		else
			self:wsReq("missing required space after element name")

			-- Loop to get key-value attribute pairs
			while true do
				if self:isEOS() then
					self:errorHalt("reached end of file while looping for element attribs.")

				elseif self:lit(">") then
					break

				elseif self:lit("/>") then
					is_empty_tag = true
					break
				end

				local a_name = getXMLName(self, "fetching element attrib key failed")

				if options.check_dupe_attribs and attribs_hash[a_name] then
					self:errorHalt("duplicate element attribute key")
				end
				stepEq(self)
				local a_val = getAttribQuoted(self, "fetching element quoted attribute value failed")

				local attrib = {}

				attrib.name = a_name
				attrib.value = a_val

				table.insert(attribs, attrib)
				attribs_hash[a_name] = #attribs

				self:ws()
			end
		end

		local entity = {}
		entity.id = "element"
		entity.name = element_name
		entity.attribs = attribs
		entity.attribs_hash = attribs_hash
		entity.children = {}

		setmetatable(entity, xmlObj._mt_element)

		return entity, is_empty_tag
	end


	local function getXMLCharacterData(self, xml_state)

		local con_t = {}

		-- NOTE: This handles both character data and "CDATA" sections. As CDATA is essentially a
		-- way to escape characters that otherwise don't play well with XML, I have opted to
		-- combine them into one text entity.
		while true do
			-- CDATA sections
			if self:lit("<![CDATA[") then
				local pos_start = self.pos
				-- Find closing CDATA tag.
				self:fetchReq("%]%]>", false, "couldn't find closing CDATA tag")
				local pos_end = self.pos - 3

				-- Don't escape CDATA Sections.
				table.insert(con_t, string.sub(self.str, pos_start, pos_end))
				break

				-- Normal Character Data sections
			else
				local pos_start = self.pos
				local pos_end
				-- Need some special handling to account for whitespace following the end of the
				-- root element (which is permitted) versus non-ws pcdata (which is disallowed)
				if not xml_state.doc_close then
					self:fetchReq("<", false, "Couldn't find '<' that ends character data")
					self.pos = self.pos - 1
					pos_end = self.pos - 1

				else
					if self:fetch("<") then
						self.pos = self.pos - 1
					else
						self:goEOS()
					end
					pos_end = self.pos - 1
				end

				local temp_str = string.sub(self.str, pos_start, pos_end)
				-- https://www.w3.org/TR/REC-xml/#syntax
				if string.match(temp_str, "%]%]>") then
					self:errorHalt("the sequence ']]>' is not permitted in plain character data")
				end

				local str_esc, esc_err = unescapeXMLString(temp_str)
				if esc_err then
					self:errorHalt(esc_err)
				end

				table.insert(con_t, str_esc)
				break
			end
		end

		local combined = table.concat(con_t)

		local contains_non_whitespace = string.find(combined, "%S")
		if contains_non_whitespace then
			if not xml_state.doc_root then
				self:errorHalt("Character data appears before root element is declared")
			end
			if xml_state.doc_close then
				self:errorHalt("Character data appears after root element close")
			end
		end

		local entity = {}
		entity.id = "character_data"
		entity.text = combined
		setmetatable(entity, xmlObj._mt_parser_char_data)

		return entity
	end


	local function handleXMLClosingTag(self, xml_state, top)
		local close_name = getXMLName(self, "Couldn't read closing tag name")
		self:ws()
		self:litReq(">", "Couldn't read '>' for closing tag")
		if top.id ~= "element" or top.name ~= close_name then
			self:errorHalt("Opening/closing tag name mismatch")
		end
	end


	local function handleXMLCharacterData(self, xml_state, top, entity)
		if options.keep_insignificant_whitespace or string.find(entity.text, "%S") then
			-- If the previous entity was also character data, merge their contents
			local entity_prev = top.children[#top.children]
			if entity_prev and entity_prev.id == "character_data" then
				entity_prev.text = entity_prev.text .. entity.text

			else
				table.insert(top.children, entity)
			end
		end
	end


	local function _parseLoop(self, xml_state, stack)

		while true do
			xml_state.label:push("_parseLoop")

			local top = stack[#stack]
			local pos_initial = self.pos

			-- End of string
			if self:isEOS() then
				if not xml_state.doc_root then
					self:errorHalt("reached end of string without finding opening root tag")

				elseif not xml_state.doc_close then
					self:errorHalt("reached end of string without closing root element")
				end
				xml_state.label:pop()
				break

				-- XML Declaration
			elseif self:lit("<?xml") then
				xml_state.label:push("xmlDecl")

				xml_state.decl = getXMLDecl(self, xml_state, pos_initial)
				self:ws()

				xml_state.label:pop()

				-- Document Type Declaration / DTD
			elseif self:lit("<!DOCTYPE") then
				xml_state.label:push("XML DocType")

				xml_state.doc_type = getXMLDocType(self, xml_state)

				xml_state.label:pop()

				-- XML Comment
			elseif self:lit("<!--") then
				xml_state.label:push("XML Comment")

				-- Can appear after doc root close.
				local entity = getXMLComment(self, xml_state)
				-- Attaching comments would break character data nodes
				--table.insert(top.children, entity)
				self:ws()

				xml_state.label:pop()

				-- Processing Instruction / PI
			elseif self:lit("<?") then
				xml_state.label:push("XML PI")

				-- Can appear after doc root close.
				local entity = getXMLProcessingInstruction(self, xml_state)
				table.insert(top.children, entity)
				self:ws()

				xml_state.label:pop()

				-- Character Data -- CDATA entry point
			elseif self:peek(0, #"<![CDATA["-1) == "<![CDATA[" then
				xml_state.label:push("XML Character Data (CDATA Entry Point)")

				local entity = getXMLCharacterData(self, xml_state)
				handleXMLCharacterData(self, xml_state, top, entity)

				xml_state.label:pop()

				-- Closing tag
			elseif self:lit("</") then
				xml_state.label:push("XML Closing Tag")

				handleXMLClosingTag(self, xml_state, top)
				table.remove(stack)

				-- If we're back at the parser root, mark the document as closed.
				-- Comments, PIs, and whitespace may appear after the root element
				-- close tag.
				if #stack == 1 then
					xml_state.doc_close = true
				end

				xml_state.label:pop()

				-- Element
			elseif self:lit("<") then
				xml_state.label:push("XML Element")

				local entity, is_empty = getXMLElement(self, xml_state)

				-- Was this the document root?
				if not xml_state.doc_root then
					xml_state.doc_root = true
				end

				table.insert(top.children, entity)
				if not is_empty then
					table.insert(stack, entity)
				end

				self:ws()

				xml_state.label:pop()

				-- Character Data - non-CDATA entry point
			elseif self:peek() ~= "<" then
				xml_state.label:push("XML Character Data (non-CDATA Entry Point)")

				local entity = getXMLCharacterData(self, xml_state)
				handleXMLCharacterData(self, xml_state, top, entity)

				xml_state.label:pop()

			else
				xml_state.label:push("Unhandled Chunk")

				self:errorHalt("XML parsing failed. (Unable to read XMLDecl, PI, Comment, Character Data, CDATA Section or Element Open/Close)")

				xml_state.label:pop()
			end

			xml_state.label:pop()
		end
	end


	local function _parsePrepass(str)
		_assertArgType(1, str, "string")

		local err_pre = "XML prepass failure: "

	--[[
	Main Loop: UTF-8 Code Units
	Aux Loop: Individual bytes -- only runs if one of the associated options are active
	--]]

		local do_aux_loop = false
		if options.prepass.doc_check_nul then
			do_aux_loop = true
		end

		local i = 1
		while i <= #str do
			if i > #str then
				break
			end

			local u8_code, err = utf8Tools.getCodeUnit(str, i)
			if not u8_code then
				return false, err_pre .. "couldn't parse code unit at byte #" .. i .. ": " .. err
			end

			-- Check for UTF-8 code points that are explictly unsupported by the XML spec.
			-- This also checks for malformed code units, as it has to parse every code unit
			-- in the string.
			if options.prepass.doc_check_xml_unsupported_chars then
				local code_point = utf8Tools.u8UnitToCodePoint(u8_code)
				if not code_point then
					return false, err_pre .. "failed to convert UTF-8 code unit to Unicode code point. Position :" .. i

				elseif not checkRangeLUT(lut_xml_unicode, code_point) then
					return false, err_pre .. "unsupported character at position: " .. i
				end
			end

			if do_aux_loop then
				for j = 1, #u8_code do
					local byte = string.byte(u8_code, j)
					-- Check for Nul bytes (0000:0000), which are permitted in UTF-8
					-- but forbidden by the XML spec.
					if options.prepass.doc_check_nul then
						if byte == 0 then
							return false, err_pre .. "document cannot contain Nul (/0) bytes. Byte position: " .. i + (j-1)
						end
					end
				end
			end

			i = i + #u8_code
		end

	--[[
	The spec mandates that all instances of "\r\n" (0xd, 0xa) and "\r" (0xd) be normalized to just \n (0xa).
	As far as I can tell, this includes CDATA sections.
	-- https://www.w3.org/TR/REC-xml/#sec-line-ends
	--]]
		if options.prepass.normalize_end_of_line then
			str = string.gsub(str, "\x0D\x0A", "\x0A")
			str = string.gsub(str, "\x0D", "\x0A")
		end

		return str
	end

	-- Public Functions

	function xmlToTable.convert(str)
		_assertArgType(1, str, "string")

		-- Only run the prepass if any checks are true.
		if options.prepass then
			for k, v in pairs(options.prepass) do
				if v == true then
					local err
					str, err = _parsePrepass(str)
					if not str then
						error("XML prepass failed: " .. err)
					end
					break
				end
			end
		end

		local self = stringReader.new(str)

		local xml_state = {}

		xml_state.id = "_parser_object_"
		xml_state.children = {}

		xml_state.decl = false
		xml_state.doc_type = false
		xml_state.doc_root = false
		xml_state.doc_close = false

		-- Debug help
		xml_state.label = labelStack.new()

		--xml_state.label.report_level = 999
		xml_state.label.report_level = 0

		xml_state.label:push("Begin Parse")

		-- Skip leading whitespace
		self:ws()

		local stack = {xml_state}

		_parseLoop(self, xml_state, stack)

		if not xml_state.doc_root then
			self:errorHalt("document root element not found") -- XXX might not ever trigger
		end

		-- NOTE: some entities are permitted after the document root.
		-- Non-whitespace character data is forbidden, though.

		setmetatable(xml_state, xmlObj._mt_parser_root)

		xml_state.label:pop()

		-- Remove build/debug fields
		xml_state.label = nil

		return xml_state
	end

	local function _indent(seq, level)
		if level > 0 then
			table.insert(seq, string.rep(" " , level))
		end
	end

	local function _dumpTree(entity, seq, _depth)
		for i, child in ipairs(entity.children) do
			_indent(seq, _depth)

			if child.id == "element" then
				table.insert(seq, "<" .. child.name)
				if #child.attribs > 0 then
					table.insert(seq, " ")
					for j, attrib in ipairs(child.attribs) do
						-- Switch quotes depending on attrib contents
						local quote = "\""
						if string.find(attrib.value, "\"") then
							quote = "'"
						end
						table.insert(seq, attrib.name .. "=\"" .. attrib.value .. "\"")
						if j < #child.attribs then
							table.insert(seq, " ")
						end
					end
				end
				if #child.children == 0 then
					table.insert(seq, " />\n")

				else
					table.insert(seq, ">\n")
					_dumpTree(child, seq, _depth + 1)
					_indent(seq, _depth)
					table.insert(seq, "</" .. child.name .. ">\n")
				end

			elseif child.id == "pi" then
				table.insert(seq, "<?" .. child.name .. " " .. child.text .. "?>")
				table.insert(seq, "\n")

			elseif child.id == "character_data" then
				table.insert(seq, child.text)
				table.insert(seq, "\n")

			else
				table.insert(seq, "(unknown element content)\n")
			end
		end
	end


	--- Dump a nested Lua table to the terminal, formatted like an XML string. NOTE: this is intended for debugging, and not guaranteed to generate valid XML. No processing is done on the table contents, so if you've made changes since the initial conversion, those will be passed through.
	function xmlToTable.dumpTree(entity)
		_assertArgType(1, entity, "table")

		local seq = {}

		-- Handle bits that are outside of the document root
		if entity.id == "_parser_object_" then
			local decl = entity.decl
			if decl then
				table.insert(seq, "<?xml")
				if decl.version then
					table.insert(seq, " version=\"" .. decl.version .. "\"")
				end
				if decl.encoding then
					table.insert(seq, " encoding=\"" .. decl.encoding .. "\"")
				end
				if decl.standalone then
					table.insert(seq, " standalone=\"" .. decl.standalone .. "\"")
				end
				table.insert(seq, "?>\n")
			end

			if entity.doc_type then
				table.insert(seq, "<!-- (!DOCTYPE not implemented yet) -->")
			end

			if entity.doc_root then
				_dumpTree(entity, seq, 0)
			end
		end

		return table.concat(seq)
	end
end
return xmlToTable
