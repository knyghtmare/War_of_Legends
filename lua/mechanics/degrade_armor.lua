
local _ = wesnoth.textdomain "wesnoth-War_of_Legends"
local old_unit_status = wesnoth.interface.game_display.unit_status

function wesnoth.interface.game_display.unit_status()
    local u = wesnoth.interface.get_displayed_unit()
    if not u then return {} end
    local s = old_unit_status()

    if u.status.degraded then
        table.insert(s, wml.tag.element{
            image = "misc/degraded-status-icon.png",
            tooltip = _"degraded: This unit is degraded. It cannot enforce its Zone of Control."
        })
    end

    return s
end

local function on_hit(weapon, opponent)
    local text
    if opponent.gender == "female" then
        text = _ "female^degraded"
    else
        text = _ "degraded"
    end
    local color = stringx.join(',', {'250', '160', '160'})
    if not wesnoth.interface.is_skipping_messages() then
        wesnoth.interface.float_label(opponent.x, opponent.y, text, color)
    end
    opponent:add_modification('object', {
        duration = 'turn end',
        wml.tag.effect{
            apply_to = 'image_mod',
            replace = 'CS(0,50,30)'
        },
        wml.tag.effect{
            apply_to = 'resistance',
            replace = false
            wml.tag.resistance({
                blade = 10,
                pierce = 10,
                impact = 10
            })
        },
        wml.tag.effect{
            apply_to = 'status',
            add = 'degraded'
        }
    })
end

local weapon_filter = {special_type_active = 'degrade'}

wesnoth.game_events.add{
    name = 'attacker_hits',
    first_time_only = false,
    filter = {
        attack = weapon_filter
    },
    action = function()
        local ctx = wesnoth.current.event_context
        local weapon = wesnoth.units.create_weapon(wml.get_child(ctx, 'weapon'))
        local opponent = wesnoth.units.get(ctx.x2, ctx.y2)
        on_hit(weapon, opponent)
    end
}

wesnoth.game_events.add_repeating("side turn end", function(ctx)
    local all_my_units = wesnoth.units.find{side = wesnoth.current.side}
    for i = 1, #all_my_units do
        all_my_units[i].status.degraded = false
    end
end)