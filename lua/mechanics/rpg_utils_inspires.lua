-- Lua code to filter and replace for inspires
-- in RPG modes, inspires has a very poor value
-- either you dont have followers or no way to use this
-- ability or it simply loses importance once all are
-- level 3 or level 4
-- thus we replace them with the war of legend variants

-- this works in conjunction with WMl
local inspires = wml.get_nth_child(..., "leadership", 1)
local allied_inspires = wml.get_nth_child(..., "leadership", 2)
    
local effects = {
    id = "WOL_add_allied_inspires",
    wml.tag.effect {
        apply_to = "remove_ability",
        wml.tag.abilities {
            wml.tag.inspires(inspires)
        }
    },
    wml.tag.effect {
        apply_to = "new_ability",
        wml.tag.abilities {
            wml.tag.allied_inspires(allied_inspires)
        }
    }
}
    
local unit = wesnoth.unit.get "my_unit"
if unit:ability("inspires") and not unit.variables.rpg_adjusted then
    unit:add_modification("object", effects)
    -- do not allow it to stack
    unit.variables.rpg_adjusted = true
    -- debug message to check it worked or not
    print("%s at (%d,%d) has been adjusted", u.id, u.x, u.y)
end
