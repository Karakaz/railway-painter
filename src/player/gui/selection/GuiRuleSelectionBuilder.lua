
local GuiRuleSelectionBuilder = {}

function GuiRuleSelectionBuilder:build()
    self:addSelectionDropdown()
    self:addSelectionButtons()
    self:addNewButton()
end

function GuiRuleSelectionBuilder:addSelectionDropdown()
    self.selection.selectionDropdown = self.parentElement.add{
        type = "drop-down",
        name = RPName("selection_dropdown"),
        items = Rules:getRuleTexts(),
        selected_index = 0
    }
    self.selection.selectionDropdown.style.minimal_width = 150
end

function GuiRuleSelectionBuilder:addSelectionButtons()
    self.selection.selectionFlow = self.parentElement.add{
        type = "flow",
        name = RPName("selection_flow"),
        direction = "horizontal"
    }

    self.selection.loadButton = self.selection.selectionFlow.add{
        type = "button",
        name = RPName("load_button"),
        caption = {RPName("load_button_caption")},
        enabled = false
    }

    self.selection.deleteButton = self.selection.selectionFlow.add{
        type = "button",
        name = RPName("delete_button"),
        caption = {RPName("delete_button_caption")},
        enabled = false
    }
end

function GuiRuleSelectionBuilder:addNewButton()
    self.selection.newButton = self.parentElement.add{
        type = "button",
        name = RPName("new_button"),
        caption = {RPName("new_button_caption")}
    }
end

function GuiRuleSelectionBuilder.new(selection, parentElement)
    local self = Object.new(GuiRuleSelectionBuilder)
    self.selection = selection
    self.parentElement = parentElement
    return self
end

return GuiRuleSelectionBuilder