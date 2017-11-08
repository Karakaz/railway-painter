
local PreviewAreaBuilder = require("src/player/preview/PreviewAreaBuilder")

local PreviewArea = {}

function PreviewArea:newRule()
    self:addLocomotive()
    self:removeWagons()
    self:updateColor()
    self:show()
end

function PreviewArea:loadRule(rule)
    if rule.trains then
        self:addLocomotive()
    else
        self:removeLocomotive()
    end
    if rule.wagons then
        self:addWagons()
    else
        self:removeWagons()
    end
    self:updateColor()
    self:show()
end

function PreviewArea:addLocomotive()
    if not self.locomotive then
        self.locomotive = self.surface.find_entity("locomotive", {1, 6})
        if not self.locomotive then
            self.locomotive = self.surface.create_entity{
                name = "locomotive",
                position = {x = 1, y = 6},
                direction = defines.direction.south
            }
            if not self.locomotive then
                log("Could not create locomotive in preview area")
                self:logEntitiesOnSurface()
            end
        end
        if self.cargoWagon then
            self.locomotive.connect_rolling_stock(defines.rail_direction.back)
        end
        self.locomotive.color = self.colorManager:getColor()
    end
end

function PreviewArea:addWagons()
    if not self.cargoWagon then
        self:addFirstCargoWagon()
        self:addSecondCargoWagon()
        self.cargoWagon.color = self.colorManager:getColor()
        self.fluidWagon.color = self.colorManager:getColor()
    end
end

function PreviewArea:addFirstCargoWagon()
    self.cargoWagon = self.surface.find_entity("cargo-wagon", {1, 0})
    if not self.cargoWagon then
        self.cargoWagon = self.surface.create_entity{
            name = "cargo-wagon",
            position = {x = 1, y = 0}
        }
        if not self.cargoWagon then
            log("Could not create cargo-wagon in preview area")
            self:logEntitiesOnSurface()
        end
    end
    if self.locomotive then
        self.cargoWagon.connect_rolling_stock(defines.rail_direction.front)
    end
end

function PreviewArea:addSecondCargoWagon()
    local secondWagonType = "cargo-wagon"
    if remote.interfaces["color-picker"] then
        secondWagonType = "fluid-wagon"
    end

    self.fluidWagon = self.surface.find_entity("cargo-wagon", {1, -6})
    if self.fluidWagon and self.fluidWagon.type ~= secondWagonType then
        self.fluidWagon.destroy()
        self.fluidWagon = nil
    end

    if not self.fluidWagon then
        self.fluidWagon = self.surface.find_entity("fluid-wagon", {1, -6})
        if self.fluidWagon and self.fluidWagon.type ~= secondWagonType then
            self.fluidWagon.destroy()
            self.fluidWagon = nil
        end
    end

    if not self.fluidWagon then
        self.fluidWagon = self.surface.create_entity{
            name = secondWagonType,
            position = {x = 1, y = -6}
        }
        if not self.fluidWagon then
            log("Could not create " .. secondWagonType .. " in preview area")
            self:logEntitiesOnSurface()
        end
    end
    self.fluidWagon.connect_rolling_stock(defines.rail_direction.front)
end

function PreviewArea:removeLocomotive()
    if self.locomotive then
        if self.cargoWagon then
            self.locomotive.disconnect_rolling_stock(defines.rail_direction.back)
        end
        self.locomotive.destroy()
        self.locomotive = nil
    end
end

function PreviewArea:removeWagons()
    if self.cargoWagon then
        if self.locomotive then
            self.cargoWagon.disconnect_rolling_stock(defines.rail_direction.front)
        end
        self.cargoWagon.disconnect_rolling_stock(defines.rail_direction.back)
        self.cargoWagon.destroy()
        self.fluidWagon.destroy()
        self.cargoWagon = nil
        self.fluidWagon = nil
    end
end

function PreviewArea:updateColor()
    local color = self.colorManager:getColor()
    self.trainStop.color = color
    if self.locomotive then
        self.locomotive.color = color
    end
    if self.cargoWagon then
        self.cargoWagon.color = color
        self.fluidWagon.color = color
    end
end

function PreviewArea:show()
    self.previewFrame.style.visible = true
end

function PreviewArea:hide()
    self.previewFrame.style.visible = false
end

function PreviewArea:logEntitiesOnSurface()
    log("Existing entities in previewArea (surface: " .. self.surface.name .. ")")
    local entities = self.surface.find_entities()
    for _,entity in pairs(entities) do
        log("   " .. entity.type .. " {" .. entity.position.x .. ", " .. entity.position.y .. "}")
    end
end

function PreviewArea.new(playerName, colorManager)
    local self = Object.new(PreviewArea)
    self.colorManager = colorManager
    self.builder = PreviewAreaBuilder.new(self, playerName)
    self.builder:createPreviewArea()
    return self
end

return PreviewArea