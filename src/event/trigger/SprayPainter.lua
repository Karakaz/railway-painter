
local hex_util = require("src/util/hex_util")
local train_util = require("src/util/train_util")

local SprayPainter = {}

function SprayPainter:paintStation(station, config)
    station.color = hex_util.toRGB(config.hex)
    if config.trains then
        local train = train_util.findTrainOnStation(station)
        if train then
            self:paintTrain(train, config)
        end
    end
end

function SprayPainter:paintTrain(train, config)
    local color = hex_util.toRGB(config.hex)
    self:colorEntities(train.locomotives.front_movers, color)
    self:colorEntities(train.locomotives.back_movers, color)
    if config.wagons then
        self:colorEntities(train.cargo_wagons, color)
--        self:colorEntities(train.fluic_wagons, color) not colorable atm
    end
end

function SprayPainter:colorEntities(entities, color)
    for _,entity in pairs(entities) do
        entity.color = color
    end
end

return SprayPainter
