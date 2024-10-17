-- original code credits to fluffbeast
-- modified by Lord-Knightmare to accomodate lvl 1 and lvl 0 units

function wesnoth.wml_actions.adjust_recall_costs(cfg)
    -- currently revised recall costs
    -- | Unit Level | Recall Cost |
    -- | ---------- | ----------- |
    -- |     0      |     10      |
    -- |     1      |     15      |
    -- |     2      |     20      |
    -- |     3      |     30      |
    -- |     4      |     40      |
    -- |     5+     |     50      |
    -- | ---------- | ----------- |
    for _, unit in ipairs(wesnoth.units.find_on_recall {}) do
        if unit.level == 0 then
            unit.recall_cost = 10
        elseif unit.level == 1 then
            unit.recall_cost = 15
        elseif unit.level == 2 then
            unit.recall_cost = 20
        elseif unit.level == 3 then
            unit.recall_cost = 30
        elseif unit.level == 4 then
            unit.recall_cost = 40
        else 
            unit.recall_cost = 50
        end
    end
end

function wesnoth.wml_actions.recall_gold_cost(cfg)
    local percentage = tonumber( cfg.percentage ) or wml.error( "Missing or wrong percentage= value in [recall_gold_cost]" )
    for _, unit in pairs(wesnoth.units.find_on_recall {}) do
        unit.recall_cost = math.floor(unit.cost * (percentage/100))
    end
end