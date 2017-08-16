
local Rule = {}

function Rule.new(force, ruleText, trains, wagons, hex)
    local self = Object.new(Rule)
    self.force = force
    self.ruleText = ruleText
    self.trains = trains
    self.wagons = wagons
    self.hex = hex
    return self
end

return Rule