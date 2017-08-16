
local GuiRuleSettingsBuilder = require("src/player/gui/settings/GuiRuleSettingsBuilder")

local GuiRuleSettings = {}

function GuiRuleSettings:loadRule(rule)
    self.ruleField.text = rule.ruleText
    self.trainCheckbox.state = rule.trains
    self.wagonCheckbox.state = rule.wagons
    self.colorManager:setHex(rule.hex)
    self:showSettingsFrame()
end

function GuiRuleSettings:newRule()
    self.ruleField.text = ""
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
    local train = self.trainCheckbox.state
    local wagon = self.wagonCheckbox.state
    local hex = self.colorManager:getHex()
    local rule = Rules:saveRule(self.factorioPlayer.force, rule, train, wagon, hex)
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

function GuiRuleSettings.new(parentElement, colorManager, factorioPlayer)
    local self = Object.new(GuiRuleSettings)
    self.colorManager = colorManager
    self.factorioPlayer = factorioPlayer
    self.builder = GuiRuleSettingsBuilder.new(self)
    self.builder:createGui(parentElement)
    return self
end

return GuiRuleSettings