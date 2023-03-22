-- Lua code to filter and replace for leadership and inspires
-- in RPG modes, leadership has a very poor value
-- either you dont have followers or no way to use this
-- ability or it simply loses importance once all are
-- level 3 or level 4
-- thus we replace them with the war of legend variants

-- Replace Leadership with Allied Leadership
wesnoth.game_events.add_repeating("unit placed", function()
    -- define the effects in a local variable
    local effects = {
        id = "WOL_add_allied_leadership",
        wml.tag.effect {
            apply_to = "remove_ability",
            wml.tag.abilities {
                -- I am confused here
                -- please clarify if this would
                -- work or not
                wml.tag.leadership {
                    id = "leadership",
                },
            },
        },
        -- I am not sure about this part
        -- not sure if any other way to add
        -- a new ability
        -- wml.tag.effect {
        --     apply_to = "new_ability",
        --     wml.tag.abilities {
        --         wml.tag.leadership {
        --             id = "allied_leadership",
        --         }
        --     }
        -- },
    }
    -- take the unit as local variable
    local ecx = wesnoth.current.event_context
    local u = wesnoth.units.get(ecx.x1, ecx.y1) or wml.error("[XP balance] No unit found at (x1, y1) to add XP in incrementor")

    if u:ability("leadership") and not u.variables.rpg_adjusted then
        -- perform the operation
        u:add_modification("object", effects)
        -- debug message to check it worked or not
        print("%s at (%d,%d) has been adjusted", u.id, u.x, u.y)
    end

    u.variables.rpg_adjusted = true
end)

-- Replace Inspires with Allied Inspires
wesnoth.game_events.add_repeating("unit placed", function()
    -- define the effects in a local variable
    local effects = {
        id = "WOL_add_allied_leadership",
        wml.tag.effect {
            apply_to = "remove_ability",
            wml.tag.abilities {
                -- I am confused here
                -- please clarify if this would
                -- work or not
                wml.tag.leadership {
                    id = "inspire",
                },
            },
        },
        -- I am not sure about this part
        -- not sure if any other way to add
        -- a new ability
        -- wml.tag.effect {
        --     apply_to = "new_ability",
        --     wml.tag.abilities {
        --         wml.tag.leadership {
        --             id = "allied_inspires",
        --         }
        --     }
        -- },
    }
    -- take the unit as local variable
    local ecx = wesnoth.current.event_context
    local u = wesnoth.units.get(ecx.x1, ecx.y1) or wml.error("[XP balance] No unit found at (x1, y1) to add XP in incrementor")

    if u:ability("inspire") and not u.variables.rpg_adjusted then
        -- perform the operation
        u:add_modification("object", effects)
        -- debug message to check it worked or not
        print("%s at (%d,%d) has been adjusted", u.id, u.x, u.y)
    end

    u.variables.rpg_adjusted = true
end)