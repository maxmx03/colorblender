local function remove_string(str, pattern)
	return string.gsub(str, pattern, "")
end

local function tohexa(str)
	return tonumber("0x" .. str)
end

local function hex_to_rgb(hex)
	hex = remove_string(hex, "#")

	local r = string.sub(hex, 1, 2)
	local g = string.sub(hex, 3, 4)
	local b = string.sub(hex, 5, 6)

	---@diagnostic disable: cast-local-type
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

local function main()
	local function has_args()
		if #arg >= 3 then
			return true
		end

		return false
	end

	if not has_args() then
		print(arg[1], arg[2], arg[3])

		return io.write("colorblender needs three arguments, foreground, background and alpha")
	end

	local fg = arg[1]
	local bg = arg[2]
	local alpha = tonumber(arg[3])

	if alpha < 0 or alpha > 1 then
		return io.write("Alpha must be between 0 and 1")
	end

	print(blend(fg, bg, alpha))
end

main()
