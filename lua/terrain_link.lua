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

helper = wesnoth.require "lua/helper.lua"
local T = wml.tag

function wesnoth.wml_actions.activate_terrain_link(cfg)
    local units = wesnoth.get_units(cfg)
    for _,u in pairs(units) do
        local x_loc = 16 --wesnoth.get_variable("$x1")
        local y_loc = 10 --wesnoth.get_variable("$y1")
        local current_terrain = wesnoth.get_terrain(x_loc, y_loc)
        wesnoth.message("Jahin", current_terrain)
    end
end
