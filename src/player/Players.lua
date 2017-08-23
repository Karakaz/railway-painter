
local Player = require("src/player/Player")

local Players = {}

function Players:initialize()
    global.players = {}
    self:loadPlayersFromGlobal()
    for _,factorioPlayer in pairs(game.players) do
        self:fetch(factorioPlayer):initialize()
    end
end

function Players:loadPlayersFromGlobal()
    self.players = global.players
end

function Players:updateColorController()
    for _,player in pairs(self.players) do
        player.gui:updateColorController()
    end
end

function Players:unlockRailwayPainter(force)
    for _,player in pairs(self.players) do
        if player.force.name == force.name then
            player:enableGuiButton()
        end
    end
end

function Players:fetch(identifier)
    if type(identifier) == "number" then
        return self:fetchFromFactorioPlayer(game.players[identifier])
    elseif type(identifier) == "table" then
        return self:fetchFromFactorioPlayer(identifier)
    elseif type(identifier) == "string" then
        return self:fetchFromName(identifier)
    end
end

function Players:fetchFromFactorioPlayer(factorioPlayer)
    local name = factorioPlayer.name
    if not self.players[name] then
        self.players[name] = Player.new(factorioPlayer)
    end
    return self.players[name]
end

function Players:fetchFromName(name)
    if not self.players[name] then
        for _,factorioPlayer in pairs(game.players) do
            if factorioPlayer.name == name then
                self.players[name] = Player.new(factorioPlayer)
                break
            end
        end
    end
    return self.players[name]
end

return Players
