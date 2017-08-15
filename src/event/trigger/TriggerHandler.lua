
local re = require("src/lib/reLua/re")

local SprayPainter = require("src/event/trigger/SprayPainter")

local TriggerHandler = {}

function TriggerHandler:ruleChanged(rule)
    local stations = game.surfaces["nauvis"].find_entities_filtered{
        type = "train-stop",
        force = rule.force
    }
    for _,station in pairs(stations) do
        if self:isAMatch(station.backer_name, rule, rule.regex) then
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
        if self:isAMatch(stationName, rule) then
            return rule
        end
    end
end

function TriggerHandler:isAMatch(stationName, rule)
    if rule.regex then
        return re.compile(rule.ruleText).execute(stationName)
    else
        return string.find(stationName, rule.ruleText)
    end
end

return TriggerHandler