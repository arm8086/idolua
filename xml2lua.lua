function newParser()

	XmlParser = {};

	function XmlParser:ToXmlString(value)
		value = string.gsub (value, "&", "&amp;");		-- '&' -> "&amp;"
		value = string.gsub (value, "<", "&lt;");		-- '<' -> "&lt;"
		value = string.gsub (value, ">", "&gt;");		-- '>' -> "&gt;"
		value = string.gsub (value, "\"", "&quot;");	-- '"' -> "&quot;"
		value = string.gsub(value, "([^%w%&%;%p%\t% ])",
			function (c) 
				return string.format("&#x%X;", string.byte(c)) 
			end);
		return value;
	end

	function XmlParser:FromXmlString(value)
		value = string.gsub(value, "&#x([%x]+)%;",
			function(h) 
				return string.char(tonumber(h,16)) 
			end);
		value = string.gsub(value, "&#([0-9]+)%;",
			function(h) 
				return string.char(tonumber(h,10)) 
			end);
		value = string.gsub (value, "&quot;", "\"");
		value = string.gsub (value, "&apos;", "'");
		value = string.gsub (value, "&gt;", ">");
		value = string.gsub (value, "&lt;", "<");
		value = string.gsub (value, "&amp;", "&");
		return value;
	end

	function XmlParser:ParseArgs(s)
		local arg = {}
		string.gsub(s, "(%w+)=([\"'])(.-)%2", function (w, _, a)
			arg[w] = self:FromXmlString(a);
		end)
		return arg
	end

	function XmlParser:ParseXmlText(xmlText)

		local stack = {}

		local top = {
			name=nil,
			value=nil,
			properties={},
			child={}
		}
		table.insert(stack, top)
		local ni, c, label, xarg, empty
		local i, j = 1, 1

		while true do
			ni,j,c,label,xarg,empty = string.find(xmlText, "<(%/?)([%w:]+)(.-)(%/?)>", i)

			if not ni then 
				break 
			end

			local text = string.sub(xmlText, i, ni-1);

			if not string.find(text, "^%s*$") then
				top.value = (top.value or "") .. self:FromXmlString(text);
			end

			if empty == "/" then  -- empty element tag
				table.insert(top.child, {name=label,value=nil,properties=self:ParseArgs(xarg),child={}})
			elseif c == "" then   -- start tag
				top = {name=label, value=nil, properties=self:ParseArgs(xarg), child={}}
				table.insert(stack, top)   -- new level
			else  -- end tag
				local toclose = table.remove(stack)  -- remove top
				top = stack[#stack]
				if #stack < 1 then
					error("XmlParser: nothing to close with "..label)
				end

				if toclose.name ~= label then
					error("XmlParser: trying to close "..toclose.name.." with "..label)
				end

				table.insert(top.child, toclose)
			end

			i = j+1
		end		

		local text = string.sub(xmlText, i);

		if not string.find(text, "^%s*$") then
			stack[#stack].value=(stack[#stack].value or "")..self:FromXmlString(text);
		end

		if #stack > 1 then
			error("XmlParser: unclosed "..stack[stack.n].name)
		end

		return stack[1].child[1];
	end

	function XmlParser:loadUrl(xmlFilename)
		local hFile = game:GetService("HttpService"):GetAsync(xmlFilename)
		if hFile then
			local x = self:ParseXmlText(hFile)
			return x,nil
		end
	end

	return XmlParser
end

local xml = newParser()

-- Returns true if array is a table with consecutive numeric indices
local function isArray(array)
	for k, _ in pairs(array) do
		if type(k) ~= "number" then
			return false
		end
	end
	return true --Found nothing but numbers !
end

local function buildTree(node_root)
	local node = node_root

	-- Return the value if node is a leaf
	if #node.child < 1 then
		return node.value
	end

	-- The luaDict that we are building
	local nodeObj = {}

	-- Store properties if any
	for key,value in pairs(node.properties) do
		nodeObj[key] = value
	end

	-- Build a tree with children
	for key,value in ipairs(node.child) do
		local childNode = value

		-- Recursive magic happens here
		if (nodeObj[childNode.name] == nil) then
			nodeObj[childNode.name] = buildTree(childNode) 
		elseif (type(nodeObj[childNode.name]) ~= "table") then
			--[[ This happens when it finds there is already a member with that name,
				 We convert to an array and append this new table ]]
			local oldObject = nodeObj[childNode.name]

			-- Create an array
			nodeObj[childNode.name] = {}

			-- Insert the tables
			table.insert(nodeObj[childNode.name], oldObject)
			table.insert(nodeObj[childNode.name], buildTree(childNode))
		elseif (isArray(nodeObj[childNode.name])) then
			-- The array is good to keep storing elements with the same name
			table.insert(nodeObj[childNode.name], buildTree(childNode))
		else
			-- We need an array of dicts
			local oldObject = nodeObj[childNode.name]
			nodeObj[childNode.name] = {}
			table.insert(nodeObj[childNode.name], oldObject)
			table.insert(nodeObj[childNode.name], buildTree(childNode))
		end
	end
	return nodeObj
end
local m = {}
function m.loadXML(xml_text)
	local root = buildTree(xml_text)
	return root
end
function m.loadURL(url)
	local fileContents = xml:loadFile(url)
	return m.loadXML(fileContents)
end
return m
