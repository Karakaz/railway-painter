
local ColorTable = require("src/player/gui/color/ColorTable")
local ColorPicker = require("src/player/gui/color/ColorPicker")

local RailwayPainterConstants = {
    MOD_NAME = "railway-painter",
    Errors = {
        ILLEGAL_COLOR = {"railway-painter_error_illegal_color_value"},
        ILLEGAL_HEX = {"railway-painter_error_illegal_hex"}
    },
    ColorControllers = {
        VANILLA = {
            constructor = ColorTable.new
        },
        PICKER = {
            constructor = ColorPicker.new
        }
    }
}

function RailwayPainterConstants.name(compnentName)
    return RailwayPainterConstants.MOD_NAME .. "_" .. compnentName
end

return RailwayPainterConstants
