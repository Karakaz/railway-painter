
local ColorPicker = {} -- implements ColorControllerInterface
ColorPicker.__index = ColorPicker

function ColorPicker.new(parentElement)
    local self = setmetatable({}, ColorPicker)
    self.colorPicker = remote.call("color-picker", "add-instance", {
        parent = parentElement,
        container_name = RPName("color_picker")
    })
    return self
end

function ColorPicker:getColor()
    return remote.call("color-picker", "get_color", self.colorPicker)
end

function ColorPicker:getHex()
    return remote.call("color-picker", "get_hex_color", self.colorPicker)
end

function ColorPicker:setColor(color)
    remote.call("color-picker", "set_color", self.colorPicker, color)
end

function ColorPicker:setHex(hex)
    remote.call("color-picker", "set_hex_color", self.colorPicker, hex)
end

function ColorPicker:getType()
    return RailwayPainterConstants.ColorControllers.PICKER
end

function ColorPicker:destroy()
    self.colorPicker.destroy()
end

return ColorPicker