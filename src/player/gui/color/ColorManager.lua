
local ColorManager = {}
ColorManager.__index = ColorManager

function ColorManager.new(errorHandler)
    local self = setmetatable({}, ColorManager)
    self.errorHandler = errorHandler
    return self
end

function ColorManager:createGui(parentElement)
    self.parentElement = parentElement
    self:updateColorController()
end

function ColorManager:updateColorController()
    if remote.interfaces["color-picker"] then
        self:updateController(RailwayPainterConstants.ColorControllers.PICKER)
    else
        self:updateController(RailwayPainterConstants.ColorControllers.VANILLA)
    end
end

function ColorManager:updateController(controllerType)
    if self.controller and self.controller:getType() ~= controllerType then
        self.controller:destroy()
        self.controller = nil
    end
    if not self.controller then
        self.controller = controllerType.constructor(self.parentElement, self.errorHandler)
    end
end

function ColorManager:textFieldUpdated(textField)
    if self.controller:getType() == RailwayPainterConstants.ColorControllers.VANILLA then
        self.controller:textFieldUpdated(textField)
    end
end

-------------------------  Color Controller Interface  ------------------------

--- @return factorio color object {r, g, b}
function ColorManager:getColor()
    return self.controller:getColor()
end

--- @return a 6 digit hexadecimal value representing the color
function ColorManager:getHex()
    return self.controller:getHex()
end

function ColorManager:setColor(color)
    self.controller:setColor(color)
end

function ColorManager:setHex(hex)
    self.controller:setHex(hex)
end

--- @return one of the RailwayPainterConstants.ColorControllers
function ColorManager:getType()
    return self.controller:getType()
end

--- Detroy the gui elements
function ColorManager:destroy()
    self.controller:destroy()
end

return ColorManager
