
local ErrorHandler = require("src/player/error/ErrorHandler")
local ColorManager = require("src/player/gui/color/ColorManager")
local PreviewArea = require("src/player/preview/PreviewArea")
local Gui = require("src/player/gui/Gui")

local Player = {}

function Player:initialize()
    if not self.initialized then
        self.errorHandler = ErrorHandler.new()
        self.colorManager = ColorManager.new(self.errorHandler)
        self.previewArea = PreviewArea.new(self.name, self.colorManager)
        self.gui = Gui.new(self.factorioPlayer, self.colorManager, self.previewArea, self.errorHandler)

        local technology = self.factorioPlayer.force.technologies[RPName("technology")]
        if technology and technology.researched then
            self:enableGuiButton()
        end

        log("Player " .. self.name .. " has been initialized")
        self.initialized = true
    end
end

function Player:enableGuiButton()
    self.gui.guiButton.style.visible = true
end

function Player.new(factorioPlayer)
    local self = Object.new(Player)
    self.factorioPlayer = factorioPlayer
    self.name = factorioPlayer.name
    self.force = factorioPlayer.force
    return self
end

return Player