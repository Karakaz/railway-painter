
require("mod-gui")

local GuiRuleSelection = require("src/player/gui/selection/GuiRuleSelection")
local GuiRuleSettings = require("src/player/gui/settings/GuiRuleSettings")

local GuiBuilder = {}
GuiBuilder.__index = GuiBuilder

function GuiBuilder.new(gui, factorioPlayer)
    local self = setmetatable({}, GuiBuilder)
    self.gui = gui
    self.factorioPlayer = factorioPlayer
    self.gui.playerFrameFlow = mod_gui.get_frame_flow(factorioPlayer)
    return self
end

function GuiBuilder:createGui()
    self:createWindow()
    self:addGuiFrame()
    self:addPreviewFrame()
end

function GuiBuilder:createGuiButton()
    local flow = mod_gui.get_button_flow(self.factorioPlayer)
    if not flow[RPName("open_gui_button")] then
        local button = flow.add({
            type = "sprite-button",
            name = RPName("open_gui_button"),
            style = mod_gui.button_style,
            sprite = "item/" .. RPName("icon_item"),
            tooltip = {RPName("open_gui_button_tooltip")}
        })
        button.style.visible = true
    end
end

function GuiBuilder:createWindow()
    self.gui.windowFlow = self.gui.playerFrameFlow.add{
        type = "flow",
        name = RPName("flow"),
        direction = "horizontal"
    }
    self.gui.windowFlow.style.visible = false
end

function GuiBuilder:addGuiFrame()
    self.gui.frame = self.gui.windowFlow.add{
        type = "frame",
        name = RPName("frame"),
        caption = {RPName("frame_caption")},
        direction = "vertical"
    }

    self.gui.frameTable = self.gui.frame.add{
        type = "table",
        name = RPName("frame_table"),
        colspan = 1
    }
    self:addErrorLabel()

    self.gui.selection = GuiRuleSelection.new(self.gui.frameTable)

    self:addRuleSettingsGui()
end

function GuiBuilder:addErrorLabel()
    self.gui.errorLabel = self.gui.frameTable.add{
        type = "label",
        name = RPName("error_label")
    }
    self.gui.errorLabel.style.font_color = {r = 1, g = 0, b = 0}
    self.gui.errorHandler:registerErrorLabel(self.gui.errorLabel)
end

function GuiBuilder:addRuleSettingsGui()
    self.gui.settings = GuiRuleSettings.new(self.gui.frameTable, self.gui.colorManager, self.factorioPlayer.force)
end

function GuiBuilder:addPreviewFrame()
    self.gui.previewArea.builder:createGui(self.gui.playerFrameFlow)
end

return GuiBuilder
