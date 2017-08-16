
local ColorTable = {} -- implements ColorControllerInterface

function ColorTable:addHeader(name)
    self[name .. "Header"] = self.colorTable.add{
        type = "label",
        name = RPName(name .. "_header"),
        caption = {RPName(name .. "_header_caption")}
    }
end

function ColorTable:addField(name, minWidth)
    self[name .. "Field"] = self.colorTable.add{
        type = "textfield",
        name = RPName(name .. "_field")
    }
    self[name .. "Field"].style.minimal_width = minWidth
end

--@Override
function ColorTable:getColor()
    return hex_util.toRGB(self.colorHex)
end

--@Override
function ColorTable:getHex()
    return self.colorHex
end

--@Override
function ColorTable:setColor(color)
    self.colorHex = hex_util.toHex(color)
    self:updateGui()
end

--@Override
function ColorTable:setHex(hex)
    self.colorHex = hex
    self:updateGui()
end

function ColorTable:updateGui()
    local color = hex_util.toRGB(self.colorHex)
    self.redField.text = color.r
    self.greenField.text = color.g
    self.blueField.text = color.b
    self.hexField.text = self.colorHex
end

--@Override
function ColorTable:getType()
    return RailwayPainterConstants.ColorControllers.VANILLA
end

--@Override
function ColorTable:destroy()
    self.colorTable.destroy()
end

function ColorTable:textFieldUpdated(textField)
    if self:isTextFieldColorField(textField.name) then
        if self:validateColorFields() then
            self:setColorFromFields()
        end
    elseif textField.name == self.hexField.name then
        if self:validateHexField() then
            self:setHexFromField()
        end
    end
end

function ColorTable:isTextFieldColorField(textFieldName)
    return textFieldName == self.redField.name or
            textFieldName == self.greenField.name or
            textFieldName == self.blueField.name
end

function ColorTable:validateColorFields()
    if self:colorValuesAreOk() then
        if #self.redField.text > 3 then
            self.redField.text = self.redField.text:sub(1, 3)
        end
        if #self.greenField.text > 3 then
            self.greenField.text = self.greenField.text:sub(1, 3)
        end
        if #self.blueField.text > 3 then
            self.blueField.text = self.blueField.text:sub(1, 3)
        end
        return true
    else
        self.errorHandler:setError(RailwayPainterConstants.Errors.ILLEGAL_COLOR)
        return false
    end
end

function ColorTable:colorValuesAreOk()
    return #self.redField.text:gsub("[%d%.]", "") == 0 and
            #self.greenField.text:gsub("[%d%.]", "") == 0 and
            #self.blueField.text:gsub("[%d%.]", "") == 0
end

function ColorTable:validateHexField()
    local hex = self.hexField.text
    hex = hex:gsub("#", "")
    if #hex > 6 then
        hex = hex:sub(1, 6)
    end
    if #hex < 6 then
        hex = hex .. string.rep("0", 6 - #hex)
    end
    if tonumber("0x" .. hex) then
        self.hexField.text = hex
        return true
    else
        self.errorHandler:setError(RailwayPainterConstants.Errors.ILLEGAL_HEX)
        return false
    end
end

function ColorTable:setColorFromFields()
    local red = self:stringToColorValue(self.redField.text)
    local green = self:stringToColorValue(self.greenField.text)
    local blue = self:stringToColorValue(self.blueField.text)
    self:setColor({r = red, g = green, b = blue})
    self:clearErrors()
end

function ColorTable:stringToColorValue(text)
    return math.min(tonumber(text) or 0, 255)
end

function ColorTable:setHexFromField()
    self:setHex(self.hexField.text)
    self:clearErrors()
end

function ColorTable:clearErrors()
    self.errorHandler:clearError(RailwayPainterConstants.Errors.ILLEGAL_COLOR)
    self.errorHandler:clearError(RailwayPainterConstants.Errors.ILLEGAL_HEX)
end

function ColorTable.new(parentElement, errorHandler)
    local self = Object.new(ColorTable)
    self.errorHandler = errorHandler
    self.colorHex = "000000"

    self.colorTable = parentElement.add{
        type = "table",
        name = RPName("color_flow"),
        colspan = 4
    }

    self:addHeader("red")
    self:addHeader("green")
    self:addHeader("blue")
    self:addHeader("hex")

    self:addField("red", 40)
    self:addField("green", 40)
    self:addField("blue", 40)
    self:addField("hex", 65)

    self:updateGui()
    return self
end

return ColorTable
