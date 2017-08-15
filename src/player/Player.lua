
local ErrorHandler = require("src/player/error/ErrorHandler")
local ColorManager = require("src/player/gui/color/ColorManager")
local PreviewArea = require("src/player/preview/PreviewArea")
local Gui = require("src/player/gui/Gui")

local Player = {}
Player.__index = Player

function Player.new(factorioPlayer)
    local self = setmetatable({}, Player)
    self.factorioPlayer = factorioPlayer
    self.name = factorioPlayer.name
    self.force = factorioPlayer.force
    return self
end

function Player:initialize()
    if not self.initialized then
        self.errorHandler = ErrorHandler.new()
        self.colorManager = ColorManager.new(self.errorHandler)
        self.previewArea = PreviewArea.new(self.name, self.colorManager)
        self.gui = Gui.new(self.factorioPlayer, self.colorManager, self.previewArea, self.errorHandler)
        self.initialized = true

        local technology = self.factorioPlayer.force.technologies[RPName("technology")]
        if technology and technology.researched then
            self:enableRailwayPainter()
        end
    end
end

function Player:enableRailwayPainter()
    self.gui.builder:createGuiButton()
end

return Player