-- This file is to patch over breaking changes in 1.15
-- 1.  wesnoth.units.modify replaces helper.modify_unit, but does not work



bmr_helper = {}

local wml_actions = wesnoth.wml_actions



--! Modifies all the units satisfying the given @a filter.
--! @param vars key/value pairs that need changing.
--! @note Usable only during WML actions.
function bmr_helper.modify_unit(filter, vars)
        wml_actions.store_unit({
                [1] = { "filter", filter },
                variable = "LUA_modify_unit",
                kill = true
        })
        for i = 0, wml.variables["LUA_modify_unit.length"] - 1 do
                local u = string.format("LUA_modify_unit[%d]", i)
                for k, v in pairs(vars) do
                        wml.variables[u .. '.' .. k] = v
                end
                wml_actions.unstore_unit({
                        variable = u,
                        find_vacant = false
                })
        end
        wml.variables["LUA_modify_unit"] = nil
end

return bmr_helper
