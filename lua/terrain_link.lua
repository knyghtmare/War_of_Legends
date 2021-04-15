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
        -- take the x and y coordinates of the unit
        local x_var = wml.variables["$x1"]
        local y_var = wml.variables["$y1"]
        -- check for the terrain
        if wesnoth.map.matches(x_var, y_var, { terrain = "A*^*,Ha*^*,Ms*^*" }) then
            -- if true, then change variation to appropriate type
            terrain_linked_unit:add_modification("object", {
                id="WOL_terrain_link_frost",
                T.effect{
                    apply_to = "variation",
                    name = "frost"
                }
            })
        elseif wesnoth.map.matches(x_var, y_var, { terrain = "S*^*,Chs*^*" }) then
            -- if true, then change variation to appropriate type
            terrain_linked_unit:add_modification("object", {
                id="WOL_terrain_link_swamp",
                T.effect{
                    apply_to = "variation",
                    name = "swamp"
                }
            })
        elseif wesnoth.map.matches(x_var, y_var, { terrain = "W*^*,Chw*^*,Cm*^*,Km*^*" }) then
            -- if true, then change variation to appropriate type
            terrain_linked_unit:add_modification("object", {
                id="WOL_terrain_link_whirlpool",
                T.effect{
                    apply_to = "variation",
                    name = "whirlpool"
                }
            })
        elseif wesnoth.map.matches(x_var, y_var, { terrain = "Ql*^*,Mv*^*,D*^*,Hd*^*,Mdd*^*" }) then
            -- if true, then change variation to appropriate type
            terrain_linked_unit:add_modification("object", {
                id="WOL_terrain_link_sandstorm",
                T.effect{
                    apply_to = "variation",
                    name = "sandstorm"
                }
            })
        elseif wesnoth.map.matches(x_var, y_var, { terrain = "M*^*,H*^*,Uh*^*,*^Dr" }) then
            -- if true, then change variation to appropriate type
            terrain_linked_unit:add_modification("object", {
                id="WOL_terrain_link_quake",
                T.effect{
                    apply_to = "variation",
                    name = "quake"
                }
            })
        elseif wesnoth.map.matches(x_var, y_var, { terrain = "*^F*,*^Uf*,*^Gvs, *^Efm" }) then
            -- if true, then change variation to appropriate type
            terrain_linked_unit:add_modification("object", {
                id="WOL_terrain_link_bramble",
                T.effect{
                    apply_to = "variation",
                    name = "bramble"
                }
            })
        elseif wesnoth.map.matches(x_var, y_var, { terrain = "G*,C*,K*,V*" }) then
            -- if true, then change variation to appropriate type
            terrain_linked_unit:add_modification("object", {
                id="WOL_terrain_link_base",
                T.effect{
                    apply_to = "variation",
                    name = "none"
                }
            })
        else
            wesnoth.message("This does not work")
        end
    end
end)
