local helper = wesnoth.require "lua/helper.lua"
local utils = wesnoth.require "~add-ons/War_of_Legends/artificial-intelligence/lua/utils.lua"

local jinx = { }

local ai_stdlib = wesnoth.require('ai/lua/stdlib.lua');
ai_stdlib.init(ai)
ai.say_hello()

local function get_jinx_attack_parameters(unit, attack)
    index = 0
    for att in helper.child_range(unit.__cfg, "attack") do
        index = index + 1
        if index == attack then
            for spec in helper.child_range(att, "specials") do
                local spec_type = helper.get_child(spec, "dummy")
                if spec_type ~= nil then
                    if tostring(spec_type["name"]) == "jinx" then
                        return spec_type["value"], spec_type["max_value"]
                    end
                end
            end
        end
    end
    return 0, 0
end

local function get_jinx_weapon(unit)
    index = 0
    for att in helper.child_range(unit.__cfg, "attack") do
        index = index + 1
        for spec in helper.child_range(att, "specials") do
            local spec_type = helper.get_child(spec, "dummy")
            if spec_type ~= nil then
                if tostring(spec_type["name"]) == "jinx" then
--!                    wesnoth.fire("label", {x= unit.x, y = unit.y, text = "me"})
                    return index
                end
            end
        end
    end
    return 0
end
    
local function get_target_value(target, unit)
    --! #define AI_CA_COMBAT_SCORE 100000
    val = 100000 + 1000
    --! ## units next to curers are bad targets ##
    local adjacent = utils.get_adjacent_tiles(target.x, target.y)
    for iter = 1,table.maxn(adjacent) do
--!        wesnoth.fire("label", {x= adjacent[iter][1], y = adjacent[iter][2], text = iter})
        local support = wesnoth.get_unit(adjacent[iter][1], adjacent[iter][2])
        if support ~= nil then
            if wesnoth.unit_ability(support, "curing") then
                if wesnoth.is_enemy(support.side, target.side) == false then
                    val = val - 500
                end
            end
        end
    end
    --! ## leader is always a good target! ##
    if target.canrecruit == true then val = val + 500 end
    --! ## consider target abilities if needed ##
    if wesnoth.unit_ability(target, "healing") then val = val + 100 end
    if wesnoth.unit_ability(target, "curing") then val = val + 100 end
    if wesnoth.unit_ability(target, "leadership") then val = val + 150 end
    local jinx_weapon = get_jinx_weapon(unit)
    local target_defense = wesnoth.unit_defense(target, wesnoth.get_terrain(target.x, target.y))
    --! ## hit the units on high defense first ##
    val = val + 100 - target_defense
    --! ## taking into account the potential retaliation. ##
    --! ## Factor 4 is to counter the weigth of defense bonus and abilities ##
    local att_stats, def_stats = wesnoth.simulate_combat(unit, jinx_weapon, target)
    val = val - 4 * (unit.hitpoints - att_stats.average_hp)
    --! ## Avoid target which current defense is so low that jinx is wasted ##
    local jinx_change, jinx_max_defense = get_jinx_attack_parameters(unit, jinx_weapon)
    if target_defense > jinx_max_defense - jinx_change then
        val = val - 15 * ((target_defense + jinx_change) - jinx_max_defense)
    end
    if utils.location_provide_healing(target.x,target.y) == true then
        val = val - 100
    end
    return val
end

local function get_healing_value(unit, nb_villages)
    --! #define AI_CA_HEALING_SCORE 80000
    val = 80000 + 10
    --! # Make sure units get healed from poison before curse.
    local status = helper.get_child(unit.__cfg, "status")
    if status["poisoned"] ~= nil then
        if unit.hitpoints > 6 then val = val + 100 end
    end
    if status["cursed"] ~= nil then
        val = val + 50
        if unit.hitpoints > unit.max_hitpoints-8 then val = val - 20 end
        val = val + 60 / nb_villages
    end
    return val
end

function jinx_special_select(unit)
    if unit.side ~= wesnoth.current.side then return false end
    if unit.moves == 0 then return false end
    if unit.hitpoints <= unit.max_hitpoints/3 then return false end
    if get_jinx_weapon(unit) == 0 then return false else return true end
end

function jinx_target_select(unit)
    if wesnoth.is_enemy(unit.side, wesnoth.current.side) == false then return false end
    if unit.hitpoints <= 5 then return false end
    local status = helper.get_child(unit.__cfg, "status")
    if status["not_living"] ~= nil then return false end
    if status["cursed"] ~= nil then return false end
--!    wesnoth.fire("label", {x= unit.x, y = unit.y, text = "target"})
    return true
end

function curse_status_select(unit)
    if unit.side ~= wesnoth.current.side then return false end
    if unit.moves == 0 then return false end
    if string.find(wesnoth.get_terrain(unit.x,unit.y), 'V') ~= nil then
        return false
    end
    local status = helper.get_child(unit.__cfg, "status")
    if status["poisoned"] ~= nil then return true end
    if status["cursed"] ~= nil then return true end
    return false
end

function curing_units_select(unit)
    if wesnoth.is_enemy(unit.side, wesnoth.current.side) == true then return false end
    if wesnoth.unit_ability(unit, "curing") then return true end
    return false
end

result = {}

function jinx:jinx_evaluation()
    local attackers = wesnoth.get_units({lua_function="jinx_special_select"})
    if attackers == nil then return 0 end
    local defenders = wesnoth.get_units({lua_function="jinx_target_select"})
    if defenders == nil then return 0 end
    local result = {}
    for a, me in ipairs(attackers) do
        local reachable = wesnoth.find_reach(me)
        local elligible_targets = {}
        for d, target in ipairs(defenders) do
            for r, tile in ipairs(reachable) do
                if (me.x == tile[1] and me.y == tile[2]) or wesnoth.get_unit(tile[1], tile[2]) == nil then
                    if helper.distance_between(target.x, target.y, tile[1], tile[2]) == 1 then
                        local value = get_target_value(target, me)
--!                        wesnoth.fire("label", {x= target.x, y = target.y, text = value})
                        table.insert(elligible_targets, {target, get_target_value(target, me)})
                        break
                    end
                end
            end
        end
        if table.maxn(elligible_targets) ~= 0 then
            table.sort(elligible_targets, utils.sort_by_value)
            table.insert(result, {me, elligible_targets[1][2], elligible_targets[1][1]})
        end
    end
    if table.maxn(result) ~= 0 then
        table.sort(result, utils.sort_by_value)
    end
    if table.maxn(result) == 0 then
        return 0, {}
    else
        return result[1][2], {me_x=result[1][1].x, me_y=result[1][1].y, target_x=result[1][3].x,target_y=result[1][3].y}
    end
end

function jinx:jinx_execution(cfg)
    local me = wesnoth.get_unit(cfg.me_x, cfg.me_y)
    local target = wesnoth.get_unit(cfg.target_x, cfg.target_y)
    local reachable = wesnoth.find_reach(me)
    local adjacent = utils.get_adjacent_tiles(target.x, target.y)
    local candidate_locations = {}
    for i = 1,table.maxn(adjacent) do
        for j, tile in ipairs(reachable) do
            if (me.x == tile[1] and me.y == tile[2]) or wesnoth.get_unit(tile[1], tile[2]) == nil then
                if helper.distance_between(tile[1], tile[2], adjacent[i][1], adjacent[i][2]) == 0 then
                    table.insert(candidate_locations, {tile=adjacent[i], def=wesnoth.unit_defense(target, wesnoth.get_terrain(adjacent[i][1], adjacent[i][2]))})
                    break
                end
            end
        end
    end
    if table.maxn(candidate_locations) > 0 then
        table.sort(candidate_locations, utils.sort_by_defense)
        if me.x ~= candidate_locations[1].tile[1] or me.y ~= candidate_locations[1].tile[2] then
--!            wesnoth.message(tostring(candidate_locations[1].tile[1]) .. " " .. tostring(candidate_locations[1].tile[2]))
            ai.move_full(me, candidate_locations[1].tile[1], candidate_locations[1].tile[2])
        end
        ai.attack(candidate_locations[1].tile[1], candidate_locations[1].tile[2], target.x, target.y, get_jinx_weapon(me) - 1)
    end
end

function jinx:curse_evaluation()
    local cursed = wesnoth.get_units({lua_function="curse_status_select"})
    local curers = wesnoth.get_units({lua_function="curing_units_select"})
    if cursed == nil then return -1,{} end
    local result = {}
    for a, me in ipairs(cursed) do
        local reachable = wesnoth.find_reach(me)
        local possible_healing = {}
        for r, tile in ipairs(reachable) do
            if table.maxn(curers) > 0 then
                for c, cure in ipairs(curers) do
                    if helper.distance_between(tile[1], tile[2], cure.x, cure.y) == 1 then
                        table.insert(possible_healing, tile)
                    end
                end
            end
            if utils.location_provide_healing(tile[1],tile[2]) == true then
                table.insert(possible_healing, tile)
            end
        end
        if table.maxn(possible_healing) > 0 then
            local valued_healing = get_healing_value(me, table.maxn(possible_healing))
            table.insert(result, {me, valued_healing, possible_healing[1]})
        end
    end
    if table.maxn(result) ~= 0 then
        table.sort(result, utils.sort_by_value)
    end
    if table.maxn(result) == 0 then
        return 0, {}
    else
        wesnoth.message(tostring(result[1][1].x) .. " " .. tostring(result[1][1].y))
        return result[1][2], {me_x=result[1][1].x, me_y=result[1][1].y, target_x=result[1][3][1],target_y=result[1][3][2]}
    end
end

function jinx:curse_execution(cfg)
    local me = wesnoth.get_unit(cfg.me_x, cfg.me_y)
    ai.move_full(me, cfg.target_x, cfg.target_y)
end

return jinx
