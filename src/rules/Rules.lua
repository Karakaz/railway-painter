
local Rule = require("src/rules/Rule")

local Rules = {}

function Rules:initialize()
    global.rules = {}
    self:loadRulesFromGlobal()
end

function Rules:loadRulesFromGlobal()
    self.rules = global.rules
end

function Rules:getRules()
    return self.rules
end

function Rules:getRuleTexts()
    local ruleTexts = {}
    for ruleText,_ in pairs(self.rules) do
        table.insert(ruleTexts, ruleText)
    end
    return ruleTexts
end

function Rules:getRule(ruleText)
    return self.rules[ruleText]
end

function Rules:saveRule(force, ruleText, trains, wagons, hex)
    self.rules[ruleText] = Rule.new(force.name, ruleText, trains, wagons, hex)
    return self.rules[ruleText]
end

function Rules:deleteRule(ruleText)
    self.rules[ruleText] = nil
end

return Rules
