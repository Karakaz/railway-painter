
local hex_util = {}

function hex_util.toRGB(hex)
    hex = hex:gsub("#", "")
    return {
        r = tonumber("0x" .. hex:sub(1, 2)),
        g = tonumber("0x" .. hex:sub(3, 4)),
        b = tonumber("0x" .. hex:sub(5, 6))
    }
end

function hex_util.toHex(color)
    return string.format("%02x", color.r) ..
            string.format("%02x", color.g) ..
            string.format("%02x", color.b)
end

return hex_util