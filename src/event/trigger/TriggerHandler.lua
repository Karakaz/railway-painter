
local re = require("src/lib/reLua/re")

local SprayPainter = require("src/event/trigger/SprayPainter")

local TriggerHandler = {}

function TriggerHandler:ruleChanged(rule, config, force)
    local rule, config, force = Rules:get
    local stations = game.surface["nauvis"].find_entities_filtered{
        type = "train-stop",
        force = force
    }
    for _,station in pairs(stations) do
        if self:isAMatch(station.backer_name, rule, config.regex) then
             SprayPainter:paintStation(station, config)
        end
    end

end

function TriggerHandler:renamedStation(station)
    local rule, config = self:findRule(station.backer_name)
    if rule then
        SprayPainter:paintStation(station, config)
    end
end

function TriggerHandler:trainOnStation(train, station)
    local rule, config = self:findRule(station.backer_name)
    if rule then
        SprayPainter:paintTrain(train, config)
    end
end

function TriggerHandler:findRule(stationName)
    for rule, config in pairs(Rules:getRules()) do
        if self:isAMatch(stationName, rule, config.regex) then
            return rule, config
        end
    end
end

function TriggerHandler:isAMatch(stationName, rule, regex)
    if regex then
        return re.compile(rule).execute(stationName)
    else
        return string.find(stationName, rule)
    end
end

return TriggerHandler