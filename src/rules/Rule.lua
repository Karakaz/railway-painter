
local Rule = {}
Rule.__index = Rule

function Rule.new(force, text, regex, trains, wagons)
    local self = setmetatable({}, Rule)
    self.force = force
    self.text = text
    self.regex = regex
    self.trains = trains
    self.wagons = wagons
    return self
end

return Rule