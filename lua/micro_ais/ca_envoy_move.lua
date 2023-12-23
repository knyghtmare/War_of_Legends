local M = wesnoth.map
local AH = wesnoth.require "ai/lua/ai_helper"
local BC = wesnoth.require "ai/lua/battle_calcs"

local messenger_next_waypoint = wesnoth.require "./ca_envoy_next_waypoint"

local ca_messenger_move = {}

function ca_messenger_move:evaluation(cfg, data)
    -- Move the messenger toward goal, potentially attack adjacent unit
    
    local messenger, x, y = messenger_next_waypoint(cfg)
    if (not messenger) then return 0 end
    
    if (messenger.x ~= x) or (messenger.y ~= y) then
        local wp = AH.get_closest_location(
            { x, y },
            { { "not", { { "filter", { { "not", { side = wesnoth.current.side } } } } } } },
            messenger
        )
        x, y = wp[1], wp[2]
    end
    
    -- Try to take the "ideal path"
    local path = AH.find_path_with_shroud(messenger, x, y, { ignore_units = 'yes' })
    local optimum_hop, optimum_cost = { messenger.x, messenger.y }, 0
    for _,step in ipairs(path) do
        local sub_path, sub_cost = AH.find_path_with_shroud(messenger, step[1], step[2])
        if sub_cost > messenger.moves then
            break
        else
            local unit_in_way = wesnoth.units.get(step[1], step[2])
            if (not AH.is_visible_unit(wesnoth.current.side, unit_in_way)) then
                unit_in_way = nil
            end
            
            if unit_in_way and (unit_in_way.side == messenger.side) then
                local reach = AH.get_reachable_unocc(unit_in_way)
                if (reach:size() > 1) then unit_in_way = nil end
            end
            
            if not unit_in_way then
                optimum_hop, nh_cost = step, sub_cost
            end
        end
    end
    
    local next_hop = optimum_hop
    
    data.messenger = messenger
    data.next_hop = next_hop
    data.goal = { x, y }
    
    if messenger then
        if (next_hop[1] == x) and (next_hop[2] == y) then
            return cfg.ca_score
        else
            return cfg.ca_score - 10
        end
    end
    return 0
end

function ca_messenger_move:execution(cfg, data)
    local messenger = data.messenger
    local next_hop = data.next_hop
    local goal = data.goal
    
    local go_to
    if (goal[1] == next_hop[1]) and (goal[2] == next_hop[2]) then
        go_to = next_hop
    else
        local enemies = AH.get_attackable_enemies()
        local enemy_attack_map = BC.get_attack_map(enemies)
        
        go_to = AH.find_best_move(messenger, function(x, y)
            -- Main rating is distance from goal
            local rating = -M.distance_between(x, y, goal)
            
            -- Minor contribution from terrain, as a tie breaker
            local hit_chance = messenger:chance_to_be_hit(wesnoth.current.map[{x, y}])
            rating = rating - hit_chance / 100
            
            -- Finally, take enemy threat into account. This is pretty ad hoc so far.
            local enemy_hp = enemy_attack_map.hitpoints:get(x,y)
            if enemy_hp then
               rating = rating - 4 * enemy_hp / messenger.hitpoints
            end
            return rating
        end, { no_random = true })
    end
    
    if ((go_to[1] ~= messenger.x) or (go_to[2] ~= messenger.y)) then
        AH.robust_move_and_attack(ai, messenger, go_to)
    else
        AH.checked_stopunit_moves(ai, messenger)
    end
    data.next_hop = nil
    data.goal = nil
    
    -- Test whether an attack without retaliation or with little damage is possible
    if (messenger.attacks_left <= 0) or (#messenger.attacks == 0) then
        data.messenger = nil
        return
    end
    
    local targets = AH.get_attackable_enemies { { "filter_adjacent", { id = messenger.id } } }
    
    local max_rating, best_target, best_weapon = -9e99, nil, nil
    for _,target in ipairs(targets) do
        for n_weapon,weapon in ipairs(messenger.attacks) do
            local att_stats, def_stats = wesnoth.simulate_combat(messenger, n_weapon, target)
            
            local rating = -9e99
            -- This is an acceptable attack if:
            -- 1. There is no counter attack
            -- 2. Probability of death is >=67% for enemy, 0% for attacker (default values)
            
            local enemy_death_chance = cfg.enemy_death_chance or 0.67
            local messenger_death_chance = cfg.messenger_death_chance or 0
            
            if (att_stats.hp_chance[messenger.hitpoints] == 1)
                or (def_stats.hp_chance[0] >= tonumber(enemy_death_chance)) and (att_stats.hp_chance[0] <= tonumber(messenger_death_chance))
            then
                rating = target.max_hitpoints + def_stats.hp_chance[0]*100 + att_stats.average_hp - def_stats.average_hp
            end
            
            if (rating > max_rating) then
                max_rating, best_target, best_weapon = rating, target, n_weapon
            end
        end
    end
    
    if best_target then
        AH.checked_attack(ai, messenger, best_target, best_weapon)
    else
        -- Always attack enemy on last waypoint
        local waypoint = wesnoth.current.map.special_locations[cfg.waypoint]
        local waypoint_x, waypoint_y = waypoint[1], waypoint[2]
        local target = AH.get_attackable_enemies {
            x = tonumber(waypoint_x),
            y = tonumber(waypoint_y),
            { "filter_adjacent", { id = messenger.id } }
        }[1]
        
        if target then
            AH.checked_attack(ai, messenger, target)
        end
    end
    if (not messenger) or (not messenger.valid) then
        data.messenger = nil
        return
    end
    
    AH.checked_stopunit_attacks(ai, messenger)
end

return ca_messenger_move
