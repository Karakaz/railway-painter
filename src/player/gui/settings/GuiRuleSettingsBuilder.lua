
local GuiRuleSettingsBuilder = {}

function GuiRuleSettingsBuilder:createGui(parentElement)
    self.settings.frame = parentElement.add{
        type = "frame",
        name = RPName("settings_frame"),
        direction = "vertical"
    }
    self.settings.frame.style.visible = false

    self:addRuleField()
    self:addTrainCheckbox()
    self:addWagonCheckbox()
    self:addColorGui()
    self:addActionFlow()
end

function GuiRuleSettingsBuilder:addRuleField()
    self.settings.ruleField = self.settings.frame.add{
        type = "textfield",
        name = RPName("rule_field"),
        tooltip = {RPName("rule_field_tooltip")}
    }
end

function GuiRuleSettingsBuilder:addTrainCheckbox()
    self.settings.trainCheckbox = self.settings.frame.add{
        type = "checkbox",
        name = RPName("train_checkbox"),
        caption = {RPName("train_checkbox_caption")},
        tooltip = {RPName("train_checkbox_tooltip")},
        state = true
    }
end

function GuiRuleSettingsBuilder:addWagonCheckbox()
    self.settings.wagonCheckbox = self.settings.frame.add{
        type = "checkbox",
        name = RPName("wagon_checkbox"),
        caption = {RPName("wagon_checkbox_caption")},
        tooltip = {RPName("wagon_checkbox_tooltip")},
        state = false
    }
end

function GuiRuleSettingsBuilder:addColorGui()
    self.settings.colorFlow = self.settings.frame.add{
        type = "flow",
        name = RPName("color_flow"),
        direction = "horizontal"
    }
    self.settings.colorManager:createGui(self.settings.colorFlow)
end

function GuiRuleSettingsBuilder:addActionFlow()
    self.settings.actionFlow = self.settings.frame.add{
        type = "flow",
        name = RPName("action_flow"),
        direction = "horizontal"
    }
    self.settings.saveButton = self.settings.actionFlow.add{
        type = "button",
        name = RPName("save_button"),
        caption = {RPName("save_button_caption")},
        enabled = false
    }
    self.settings.cancelButton = self.settings.actionFlow.add{
        type = "button",
        name = RPName("cancel_button"),
        caption = {RPName("cancel_button_caption")}
    }
end

function GuiRuleSettingsBuilder.new(settings)
    local self = Object.new(GuiRuleSettingsBuilder)
    self.settings = settings
    return self
end

return GuiRuleSettingsBuilder
