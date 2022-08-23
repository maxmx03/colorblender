---@diagnostic disable: cast-local-type
local function removeString(str, pattern)
	return string.gsub(str, pattern, "")
end

local function tohexa(str)
	return tonumber("0x" .. str)
end

local function hex_to_rgb(hex)
	hex = removeString(hex, "#")

	local r = string.sub(hex, 1, 2)
	local g = string.sub(hex, 3, 4)
	local b = string.sub(hex, 5, 6)

	r = tohexa(r)
	g = tohexa(g)
	b = tohexa(b)

	return { r, g, b }
end

local function rgb_to_hex(red, green, blue)
	return string.format("#%.2X%.2X%.2X", red, green, blue)
end

local function blend(hex_fg, hex_bg, alpha)
	local rgb_bg = hex_to_rgb(hex_bg)
	local rgb_fg = hex_to_rgb(hex_fg)
	local min = math.min
	local max = math.max
	local floor = math.floor

	local function blend_channel(channel)
		local blended_channel = alpha * rgb_fg[channel] + ((1 - alpha) * rgb_bg[channel])

		return floor(min(max(0, blended_channel), 255) + 0.5)
	end

	return rgb_to_hex(blend_channel(1), blend_channel(2), blend_channel(3))
end

print(blend("#ffffff", "#000000", 0.5))
