
local hex_util = require("src/util/hex_util")
local train_util = require("src/util/train_util")

local SprayPainter = {}

function SprayPainter:paintStation(station, rule)
    station.color = hex_util.toRGB(rule.hex)
    if rule.trains then
        local train = train_util.findTrainOnStation(station)
        if train then
            self:paintTrain(train, rule)
        end
    end
end

function SprayPainter:paintTrain(train, rule)
    local color = hex_util.toRGB(rule.hex)
    self:colorEntities(train.locomotives.front_movers, color)
    self:colorEntities(train.locomotives.back_movers, color)
    if rule.wagons then
        self:colorEntities(train.cargo_wagons, color)
        self:colorEntities(train.fluid_wagons, color) -- Won't be shown unless color-picker is enabled
    end
end

function SprayPainter:colorEntities(entities, color)
    for _,entity in pairs(entities) do
        entity.color = color
    end
end

return SprayPainter
