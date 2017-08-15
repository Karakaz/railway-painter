
local GuiRuleSelectionBuilder = require("src/player/gui/selection/GuiRuleSelectionBuilder")

local GuiRuleSelection = {}
GuiRuleSelection.__index = GuiRuleSelection

function GuiRuleSelection.new(parentElement)
    local self = setmetatable({}, GuiRuleSelection)
    self.builder = GuiRuleSelectionBuilder.new(self, parentElement)
    self.builder:build()
    return self
end

function GuiRuleSelection:getSelectedRuleText()
    local index = self.selectionDropdown.selected_index
    return self.selectionDropdown.items[index]
end

function GuiRuleSelection:deleteRule()
    local rule = self:getSelectedRuleText()
    Rules:deleteRule(rule)
    self:enableSelection()
    self:disableSelectionButtons()
end

function GuiRuleSelection:disableSelection()
    self:clearSelectedRule()
    self:disableSelectionButtons()
    self.selectionDropdown.enabled = false
    self.newButton.enabled = false
end

function GuiRuleSelection:enableSelection()
    self:clearSelectedRule()
    self.selectionDropdown.enabled = true
    self.newButton.enabled = true
end

function GuiRuleSelection:clearSelectedRule()
    self.selectionDropdown.items = Rules:getRuleTexts()
    self.selectionDropdown.selected_index = 0
end

function GuiRuleSelection:updateSelection()
    if self.selectionDropdown.selected_index > 0 then
        self:enableSelectionButtons()
    else
        self:disableSelectionButtons()
    end
end

function GuiRuleSelection:enableSelectionButtons()
    self.loadButton.enabled = true
    self.deleteButton.enabled = true
end

function GuiRuleSelection:disableSelectionButtons()
    self.loadButton.enabled = false
    self.deleteButton.enabled = false
end

return GuiRuleSelection