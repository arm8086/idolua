-- most of this code is stolen from https://github.com/stephenjbradshaw/SPEAR-to-MIDI
local split = string.split
local gsub = string.gsub

function strip(str)
	return gsub(str, "^%s*(.-)%s*$", "%1")
end

function sublist_index_avg(list, index)
	local sum = 0
	for _, v in list do
		sum += v[index]
	end
	return sum / #list
end

function process_line(line)
	local partial = {}
	local split_line = split(strip(line), " ")
	while #split_line > 0 do
		local timepoint = {}
		for i = 0, 3 do
			local item = gsub(table.remove(split_line, 1), ",", ".")
			table.insert(timepoint, item)
		end
		table.insert(partial, timepoint)
	end
	return partial
end

function scaleValue(value, inMin, inMax, outMin, outMax)
	local normalizedValue = (value - inMin) / (inMax - inMin)
	local scaledValue = normalizedValue * (outMax - outMin) + outMin

	return scaledValue
end

return function(data)
	local lines = split(data, "\n")
	local partials = {}
	for _, v in ipairs(lines) do
		table.insert(partials, process_line(v))
	end
	local min_amp = sublist_index_avg(partials[1], 3)
	local max_amp = sublist_index_avg(partials[1], 3)
	for _, partial in ipairs(partials) do
		local temp_amp = sublist_index_avg(partial, 3)
		if temp_amp < min_amp then
			min_amp = temp_amp
		end
		if temp_amp > max_amp then
			max_amp = temp_amp
		end
	end
	local data = {}
	for _, partial in ipairs(partials) do
		local average_freq = sublist_index_avg(partial, 2)
		local average_amp = sublist_index_avg(partial, 3)
		local volume = scaleValue(average_amp, min_amp, max_amp, 0, 1)
		local on_time = partial[1][1]
		local off_time = partial[#partial][1]
		table.insert(data, {
			startTime = on_time,
			endTime = off_time,
			freq = average_freq,
			vol_mult = volume
		})
	end
	return data
end
