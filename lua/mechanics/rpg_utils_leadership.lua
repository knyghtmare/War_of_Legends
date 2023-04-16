-- Lua code to filter and replace for leadership
-- in RPG modes, leadership has a very poor value
-- either you dont have followers or no way to use this
-- ability or it simply loses importance once all are
-- level 3 or level 4
-- thus we replace them with the war of legend variants

-- this works in conjunction with WMl
local leadership = wml.get_nth_child(..., "leadership", 1)
local allied_leadership = wml.get_nth_child(..., "leadership", 2)
    
local effects = {
    id = "WOL_add_allied_leadership",
    wml.tag.effect {
        apply_to = "remove_ability",
        wml.tag.abilities {
            wml.tag.leadership(leadership)
        }
    },
    wml.tag.effect {
        apply_to = "new_ability",
        wml.tag.abilities {
            wml.tag.allied_leadership(allied_leadership)
        }
    }
}

-- get target unit
local ecx = wesnoth.current.event_context
local unit = wesnoth.units.get(ecx.x1, ecx.y1)

-- the leadership check is handled by WML side
-- check if unit has been modified, if not, then execute
if not unit.variables.rpg_adjusted then
    unit:add_modification("object", effects)
    -- do not allow it to stack
    unit.variables.rpg_adjusted = true
    -- debug message to check it worked or not
    print("%s at (%d,%d) has been adjusted", unit.id, unit.x, unit.y)
end
