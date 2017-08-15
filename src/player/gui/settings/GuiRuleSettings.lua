
local GuiRuleSettingsBuilder = require("src/player/gui/settings/GuiRuleSettingsBuilder")

local GuiRuleSettings = {}
GuiRuleSettings.__index = GuiRuleSettings

function GuiRuleSettings.new(parentElement, colorManager, force)
    local self = setmetatable({}, GuiRuleSettings)
    self.colorManager = colorManager
    self.force = force
    self.builder = GuiRuleSettingsBuilder.new(self)
    self.builder:createGui(parentElement)
    return self
end

function GuiRuleSettings:loadSetting(rule, config)
    self.ruleField.text = rule
    self.regexCheckbox.state = config.regex
    self.trainCheckbox.state = config.trains
    self.wagonCheckbox.state = config.wagons
    self.colorManager:setHex(config.hex)
    self:showSettingsFrame()
end

function GuiRuleSettings:newRule()
    self.ruleField.text = ""
    self.regexCheckbox.state = false
    self.trainCheckbox.state = true
    self.wagonCheckbox.state = false
    self.colorManager:setHex("000000")
    self:showSettingsFrame()
end

function GuiRuleSettings:showSettingsFrame()
    self.frame.style.visible = true
end

function GuiRuleSettings:hideSettingsFrame()
    self.frame.style.visible = false
end

function GuiRuleSettings:saveRule()
    local rule = self.ruleField.text
    local regex = self.regexCheckbox.state
    local train = self.trainCheckbox.state
    local wagon = self.wagonCheckbox.state
    local hex = self.colorManager:getHex()
    Rules:saveRule(self.factorioPlayer.force, rule, regex, train, wagon, hex)
    self:hideSettingsFrame()
end

function GuiRuleSettings:ruleUpdated()
    if #self.ruleField.text > 0 then
        self.saveButton.enabled = true
    else
        self.saveButton.enabled = false
    end
end

return GuiRuleSettings