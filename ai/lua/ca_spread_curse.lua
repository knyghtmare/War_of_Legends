------- Spread Poison CA --------------

local AH = wesnoth.require "ai/lua/ai_helper.lua"
local BC = wesnoth.require "ai/lua/battle_calcs.lua"
local LS = wesnoth.require "location_set"

local SP_attack

local ca_spread_curse = {}

function ca_spread_curse:evaluation(cfg, data, filter_own)
    local start_time, ca_name = wesnoth.ms_since_init() / 1000., 'spread_curse'
    if AH.print_eval() then AH.print_ts('     - Evaluating spread_curse CA:') end

    local attacks_aspect = ai.aspects.attacks

    local jinx_attackers = {}
    for _,unit in ipairs(attacks_aspect.own) do
        if (unit.attacks_left > 0) and (#unit.attacks > 0) and unit:find_attack { special_id = "weapon_special_jinx" }
            and (not unit.canrecruit) and unit:matches(filter_own)
        then
            table.insert(jinx_attackers, unit)
        end
    end

    if (not jinx_attackers[1]) then
        if AH.print_eval() then AH.done_eval_messages(start_time, ca_name) end
        return 0
    end

    local target_map = LS.create()
    for _,enemy in ipairs(attacks_aspect.enemy) do
        target_map:insert(enemy.x, enemy.y)
    end

    local attacks = AH.get_attacks(jinx_attackers)
    if (not attacks[1]) then
        if AH.print_eval() then AH.done_eval_messages(start_time, ca_name) end
        return 0
    end

    local aggression = ai.aspects.aggression
    if (aggression > 1) then aggression = 1 end
    local avoid_map = LS.of_pairs(ai.aspects.avoid)

    -- Go through all possible attacks with jinx_attackers
    local max_rating, best_attack = - math.huge, nil
    for i,a in ipairs(attacks) do
        if target_map:get(a.target.x, a.target.y) and (not avoid_map:get(a.dst.x, a.dst.y)) then
            local attacker = wesnoth.units.get(a.src.x, a.src.y)
            local defender = wesnoth.units.get(a.target.x, a.target.y)

            -- Don't try to curse a unit that cannot be cursed
            local cant_curse = defender.status.WOL_curse or defender.canrecruit

            -- For now, we also simply don't curse units on healing locations (unless standard combat CA does it)
            local defender_terrain = wesnoth.current.map[defender]
            local healing = wesnoth.terrain_types[defender_terrain].healing

            -- Also, cursed units that would level up through the attack or could level on their turn as a result is very bad
            local about_to_level = defender.max_experience - defender.experience <= (attacker.level * 2 * wesnoth.game_config.combat_experience)

            if (not cant_curse) and (healing == 0) and (not about_to_level) then
                local _, curse_weapon = attacker:find_attack { special_id = "weapon_special_jinx" }
                local dst = { a.dst.x, a.dst.y }
                wesnoth.interface.handle_user_interact()
                local att_stats, def_stats = BC.simulate_combat_loc(attacker, dst, defender, curse_weapon)
                local _, defender_rating, attacker_rating = BC.attack_rating(attacker, defender, dst, { att_stats = att_stats, def_stats = def_stats })

                -- More priority to enemies on strong terrain
                local defense_rating = defender:defense_on(defender_terrain) / 100

                attacker_rating = attacker_rating * (1 - aggression)
                local combat_rating = attacker_rating + defender_rating --+ additional_curse_rating
                local total_rating = combat_rating + defense_rating

                -- Only do the attack if combat_rating is positive. As there is a sizable
                -- bonus for cursing, this will be the case for most attacks.
                if (combat_rating > 0) and (total_rating > max_rating) then
                    max_rating, best_attack = total_rating, a
                end
            end
        end
    end

    if best_attack then
        SP_attack = best_attack
        if AH.print_eval() then AH.done_eval_messages(start_time, ca_name) end
        return 190000
    end
    if AH.print_eval() then AH.done_eval_messages(start_time, ca_name) end
    return 0
end

function ca_spread_curse:execution(cfg, data)
    local attacker = wesnoth.units.get(SP_attack.src.x, SP_attack.src.y)
    -- If several attacks have curse, this will always find the last one
    local is_curser, curse_weapon = attacker:find_attack { special_id = "weapon_special_jinx" }

    if AH.print_exec() then AH.print_ts('   Executing spread_curse CA') end
    if AH.show_messages() then wesnoth.wml_actions.message { speaker = attacker.id, message = 'Curse attack' } end

    AH.robust_move_and_attack(ai, attacker, SP_attack.dst, SP_attack.target, { weapon = curse_weapon })

    SP_attack = nil
end

return ca_spread_curse