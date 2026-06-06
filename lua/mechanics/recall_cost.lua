-- original code credits to fluffbeast
-- modified by Lord-Knightmare to accomodate lvl 1 and lvl 0 units

function wesnoth.wml_actions.adjust_recall_costs(cfg)
    -- currently revised recall costs
    -- | Unit Level | Recall Cost |
    -- | ---------- | ----------- |
    -- |     0      |     10      |
    -- |     1      |     15      |
    -- |     2      |     20      |
    -- |     3      |     25      |
    -- |     4      |     30      |
    -- |     5+     |     35      |
    -- | ---------- | ----------- |
    for _, unit in ipairs(wesnoth.units.find_on_recall {}) do
        if unit.level == 0 then
            unit.recall_cost = 10
        elseif unit.level == 1 then
            unit.recall_cost = 15
        elseif unit.level == 2 then
            unit.recall_cost = 20
        elseif unit.level == 3 then
            unit.recall_cost = 25
        elseif unit.level == 4 then
            unit.recall_cost = 30
        else 
            unit.recall_cost = 35
        end
    end
end

function wesnoth.wml_actions.adjust_recall_costs_mp(cfg)
    -- currently revised recall costs
    -- | Unit Level | Recall Cost |
    -- | ---------- | ----------- |
    -- |     0      |     10      |
    -- |     1      |     15      |
    -- |     2      |     20      |
    -- |     3      |     20      |
    -- |     4      |     20      |
    -- |     5+     |     20      |
    -- | ---------- | ----------- |
    for _, unit in ipairs(wesnoth.units.find_on_recall {}) do
        if unit.level == 0 then
            unit.recall_cost = 10
        elseif unit.level == 1 then
            unit.recall_cost = 15
        else 
            unit.recall_cost = 20
        end
    end
end

function wesnoth.wml_actions.recall_gold_cost(cfg)
    local percentage = tonumber( cfg.percentage ) or wml.error( "Missing or wrong percentage= value in [recall_gold_cost]" )
    for _, unit in pairs(wesnoth.units.find_on_recall {}) do
        unit.recall_cost = math.floor(unit.cost * (percentage/100))
    end
end