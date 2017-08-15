
local GuiRuleSettingsBuilder = require("src/player/gui/settings/GuiRuleSettingsBuilder")

local GuiRuleSettings = {}
GuiRuleSettings.__index = GuiRuleSettings

function GuiRuleSettings.new(parentElement, colorManager, factorioPlayer)
    local self = setmetatable({}, GuiRuleSettings)
    self.colorManager = colorManager
    self.factorioPlayer = factorioPlayer
    self.builder = GuiRuleSettingsBuilder.new(self)
    self.builder:createGui(parentElement)
    return self
end

function GuiRuleSettings:loadRule(rule)
    self.ruleField.text = rule.ruleText
    self.regexCheckbox.state = rule.regex
    self.trainCheckbox.state = rule.trains
    self.wagonCheckbox.state = rule.wagons
    self.colorManager:setHex(rule.hex)
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
    local rule = Rules:saveRule(self.factorioPlayer.force, rule, regex, train, wagon, hex)
    self:hideSettingsFrame()
    return rule
end

function GuiRuleSettings:ruleUpdated()
    if #self.ruleField.text > 0 then
        self.saveButton.enabled = true
    else
        self.saveButton.enabled = false
    end
end

return GuiRuleSettings