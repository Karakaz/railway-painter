

-- Global variables ---------------------------------------------------------------------

hex_util = require("src/util/hex_util")

Rules = require("src/rules/Rules")
RailwayPainterConstants = require("src/RailwayPainterConstants")
RPName = RailwayPainterConstants.name


-- Event registration -------------------------------------------------------------------

local EventHandler = require("src/event/EventHandler")

script.on_init(EventHandler.on_init)
script.on_load(EventHandler.on_load)
script.on_configuration_changed(EventHandler.on_configuration_changed)
script.on_event(defines.events.on_player_joined_game, EventHandler.on_player_joined_game)

script.on_event(defines.events.on_research_finished, EventHandler.on_research_finished)

script.on_event(defines.events.on_gui_click, EventHandler.on_gui_click)
script.on_event(defines.events.on_gui_selection_state_changed, EventHandler.on_gui_selection_state_changed)
script.on_event(defines.events.on_gui_checked_state_changed, EventHandler.on_gui_checked_state_changed)
script.on_event(defines.events.on_gui_text_changed, EventHandler.on_gui_text_changed)

script.on_event(defines.events.on_entity_renamed, EventHandler.on_entity_renamed)
script.on_event(defines.events.on_entity_settings_pasted, EventHandler.on_entity_settings_pasted)

script.on_event(defines.events.on_built_entity, EventHandler.on_built_entity)
script.on_event(defines.events.on_train_changed_state, EventHandler.on_train_changed_state)
