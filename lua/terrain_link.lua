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

local T = wml.tag

function wesnoth.wml_actions.activate_terrain_link(cfg)
    local terrain_link_units = wesnoth.get_units { ability_id = "terrain_link" }
end
