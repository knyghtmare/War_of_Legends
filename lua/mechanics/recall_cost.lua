-- original code credits to fluffbeast
-- modified by Lord-Knightmare to accomodate lvl 1 and lvl 0 units

local cost_lvl_zero = 10 
local cost_lvl_one = 15

for _, unit in ipairs(wesnoth.get_recall_units {}) do
    if unit.level == 0 then
        unit.recall_cost = cost_lvl_zero
    end

    if unit.level == 1 then
        unit.recall_cost = cost_lvl_one
    end
end

function wesnoth.wml_actions.recall_gold_cost(cfg)
    local percentage = tonumber( cfg.percentage ) or wml.error( "Missing or wrong percentage= value in [recall_gold_cost]" )
    for _, unit in pairs(wesnoth.units.find_on_recall {}) do
        unit.recall_cost = unit.cost * (percentage/100)
    end
end