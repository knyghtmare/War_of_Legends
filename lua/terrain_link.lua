-- Nightmare faction specific ability
-- Units with this ability will adapt a new
-- variation based on the terrain they are on
-- Current List:
-- Base - flat/castle/keeps/village
-- Bramble - Forests
-- Rock - Mountains/Hills/Caves
-- SandStorm - Desert/Sand/Dunes
-- Frost - Snow/Ice
-- Whirlpool - Water/Deepwater/Fords
-- Swamp-whirlpool - Swampwater/Quagmire

local helper = wesnoth.require("helper")
local _ = wesnoth.textdomain 'wesnoth-War_of_Legends'
local T = wml.tag
local on_event = wesnoth.require("on_event")

function wesnoth.wml_actions.activate_terrain_link(cfg)
    local units = wesnoth.units.find_on_map(cfg)
    for _,u in pairs(units) do
        local x_loc = 16 --wesnoth.get_variable("$x1")
        local y_loc = 10 --wesnoth.get_variable("$y1")
        local current_terrain = wesnoth.get_terrain(x_loc, y_loc)
        wesnoth.message("Jahin", current_terrain)
    end
end

on_event("new turn", function()
    -- filter for unit with terrain link
    local terrain_linked_units = wesnoth.units.get { ability = "WOL_terrain_link", side = wesnoth.current.side }

    -- set up a for loop
    for i, terrain_linked_unit in ipairs(terrain_linked_units) do
        local x_var = wesnoth.get_variable["$x1"]
        local y_var = wesnoth.get_variable["$y1"]
        local current_hex_terrain = wesnoth.get_terrain()
    end
end)
