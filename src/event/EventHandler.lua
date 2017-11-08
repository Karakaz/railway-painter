
local Players = require("src/player/Players")
local TriggerHandler = require("src/event/trigger/TriggerHandler")
local train_util = require("src/util/train_util")

local EventHandler = {}

function EventHandler.on_init()
    Rules:initialize()
    Players:initialize()
    EventHandler.registerDependencyEvents()
end

function EventHandler.on_load()
    Rules:loadRulesFromGlobal()
    Players:loadPlayersFromGlobal()
    EventHandler.registerDependencyEvents()
end

function EventHandler.registerDependencyEvents()
    if remote.interfaces["color-picker"] then
        script.on_event(remote.call("color-picker", "on_color_updated"), EventHandler.color_picker_on_color_updated)
    end
end

function EventHandler.on_configuration_changed(data)
    Players:updateColorController()
end

function EventHandler.on_player_joined_game(event)
    Players:fetch(event.player_index):initialize()
end

function EventHandler.on_research_finished(event)
    if event.research.name == RPName("technology") then
       Players:unlockRailwayPainter(event.research.force)
    end
end

function EventHandler.on_gui_click(event)
    local player = Players:fetch(event.player_index)
    local elementName = event.element.name

    if elementName == RPName("open_gui_button") then
        player.gui:toggle()
    elseif elementName == RPName("load_button") then
        player.gui:loadRule()
    elseif elementName == RPName("delete_button") then
        player.gui:deleteRule()
        TriggerHandler:refreshAllStations()
    elseif elementName == RPName("new_button") then
        player.gui:newRule()
    elseif elementName == RPName("save_button") then
        local rule = player.gui:saveRule()
        TriggerHandler:ruleChanged(rule)
    elseif elementName == RPName("cancel_button") then
        player.gui:cancelRule()
    end
end

function EventHandler.on_gui_selection_state_changed(event)
    if event.element.name == RPName("selection_dropdown") then
        Players:fetch(event.player_index).gui.selection:updateSelection()
    end
end

function EventHandler.on_gui_checked_state_changed(event)
    local player = Players:fetch(event.player_index)
    local elementName = event.element.name
    if elementName == RPName("train_checkbox") then
        player.gui:trainCheckboxUpdated()
    elseif elementName == RPName("wagon_checkbox") then
        player.gui:wagonCheckboxUpdated()
    end
end

function EventHandler.on_gui_text_changed(event)
    local player = Players:fetch(event.player_index)
    local elementName = event.element.name

    if elementName == RPName("rule_field") then
        player.gui.settings:ruleUpdated()
    else
        player.gui:colorFieldUpdated(event.element)
    end
end

function EventHandler.on_entity_renamed(event)
    if event.entity.type == "train-stop" then
        TriggerHandler:renamedStation(event.entity)
    end
end

function EventHandler.on_entity_settings_pasted(event)
    if event.destination.type == "train-stop" then
        TriggerHandler:renamedStation(event.destination)
    end
end

function EventHandler.on_built_entity(event)
    if event.created_entity.type == "locomotive" then
        local station = train_util.findStationForManualTrain(event.created_entity.train)
        if station then
            TriggerHandler:trainOnStation(event.created_entity.train, station)
        end
    end
end

function EventHandler.on_train_changed_state(event)
    if event.train.state == defines.train_state.manual_control or
       event.train.state == defines.train_state.wait_station then
        local station = event.train.station or train_util.findStationForManualTrain(event.train)
        if station then
            TriggerHandler:trainOnStation(event.train, station)
        end
    end
end

function EventHandler.color_picker_on_color_updated(event)
    if event.container.name == RPName("color_picker") then
        Players:fetch(event.player_index).gui:pickerColorUpdated(event.color)
    end
end

return EventHandler
