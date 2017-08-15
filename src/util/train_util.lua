require("util")

local entity_util = require("src/util/entity_util")

local DISTANCE_LOCOMOTIVE_STATION = 3.605551275464
local MANUAL_DRIVE_LEEWAY = 0.15 --15%

local train_util = {}

function train_util.getHeadLocomotiveOfTrain(train)
    if train.speed == 0 then
        local headLocomotive = train_util.getHeadLocomotive(train)
        if headLocomotive then
            local direction = train_util.getDirection(headLocomotive)
            if direction then
                return headLocomotive, direction
            end
        end
    end
end

function train_util.findStationForManualTrain(train)
    local headLocomotive, direction = train_util.getHeadLocomotiveOfTrain(train)
    if headLocomotive then
        local center = entity_util.getCenterOfEntity(headLocomotive)
        local stations = headLocomotive.surface.find_entities_filtered{
            area = {{center.x - 5, center.y - 5}, {center.x + 5, center.y + 5}},
            type = "train-stop",
            force = headLocomotive.force
        }
        if #stations > 0 then
            for _,station in pairs(stations) do
                if station.direction == direction then
                    local stationCenter = entity_util.getCenterOfEntity(station)
                    local distance = util.distance(center, stationCenter)
                    if train_util.locomotiveStationDistanceIsValid(distance) then
                        return station
                    end
                end
            end
        end
    end
end

function train_util.getHeadLocomotive(train)
    local locomotives = train.locomotives
    if #locomotives.front_movers > 0 then
        return locomotives.front_movers[1]
    elseif #locomotives.back_movers > 0 then
        return locomotives.back_movers[1]
    end
end

function train_util.getDirection(locomotive)
    if locomotive.orientation == 0 then
        return defines.direction.north
    elseif locomotive.orientation == 0.25 then
        return defines.direction.east
    elseif locomotive.orientation == 0.5 then
        return defines.direction.south
    elseif locomotive.orientation == 0.75 then
        return defines.direction.west
    end
end

function train_util.locomotiveStationDistanceIsValid(distance)
    return math.abs((distance / DISTANCE_LOCOMOTIVE_STATION) - 1) <= MANUAL_DRIVE_LEEWAY
end

function train_util.findTrainOnStation(station)
    for _,train in pairs(station.surface.get_trains(station.force)) do
        if train.station == station then
            return train
        elseif not train.station and train.state == defines.train_state.manual_control then
            if train_util.findStationForManualTrain(train) == station then
                return train
            end
        end
    end
end

return train_util