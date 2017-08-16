
local SprayPainter = require("src/event/trigger/SprayPainter")

local TriggerHandler = {}

function TriggerHandler:ruleChanged(rule)
    local stations = game.surfaces["nauvis"].find_entities_filtered{
        type = "train-stop",
        force = rule.force
    }
    for _,station in pairs(stations) do
        if station.backer_name:find(rule.ruleText) then
             SprayPainter:paintStation(station, rule)
        end
    end

end

function TriggerHandler:renamedStation(station)
    local rule = self:findRule(station.backer_name)
    if rule then
        SprayPainter:paintStation(station, rule)
    end
end

function TriggerHandler:trainOnStation(train, station)
    local rule = self:findRule(station.backer_name)
    if rule then
        SprayPainter:paintTrain(train, rule)
    end
end

function TriggerHandler:findRule(stationName)
    for _,rule in ipairs(Rules:getRules()) do
        if stationName:find(rule.ruleText) then
            return rule
        end
    end
end

return TriggerHandler