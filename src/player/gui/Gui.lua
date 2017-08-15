
local GuiBuilder = require("src/player/gui/GuiBuilder")

local Gui = {}
Gui.__index = Gui

function Gui.new(factorioPlayer, colorManager, previewArea, errorHandler)
    for k,v in pairs(game.surfaces) do
        game.print(tostring(k))
    end
    local self = setmetatable({}, Gui)
    self.previewArea = previewArea
    self.colorManager = colorManager
    self.errorHandler = errorHandler
    self.builder = GuiBuilder.new(self, factorioPlayer)
    self.builder:createGui()
    return self
end

function Gui:updateColorController()
    self.settings.colorManager.updateColorController()
end

function Gui:toggle()
    self.windowFlow.style.visible = not self.windowFlow.style.visible
end

function Gui:loadRule()
    local rule = self.selection:getSelectedRule()
    local config = Rules:getConfig(rule)
    self.settings:loadSetting(rule, config)
    self.previewArea:loadConfig(config)
    self.selection:disableSelection()
end

function Gui:deleteRule()
    self.selection:deleteRule()
end

function Gui:newRule()
    self.settings:newRule()
    self.previewArea:newRule()
    self.selection:disableSelection()
end

function Gui:saveRule()
    local rule = self.settings:saveRule()
    self.previewArea:hide()
    self.selection:enableSelection()
    return rule
end

function Gui:cancelRule()
    self.settings:hideSettingsFrame()
    self.previewArea:hide()
    self.selection:enableSelection()
end

function Gui:trainCheckboxUpdated()
    if self.settings.trainCheckbox.state then
        self.previewArea:addLocomotive()
    else
        self.previewArea:removeLocomotive()
    end
end

function Gui:wagonCheckboxUpdated()
    if self.settings.wagonCheckbox.state then
        self.previewArea:addWagons()
    else
        self.previewArea:removeWagons()
    end
end

function Gui:colorFieldUpdated(textField)
    self.settings.colorManager:textFieldUpdated(textField)
    self.previewArea:updateColor()
end

return Gui
