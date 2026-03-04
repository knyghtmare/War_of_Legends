function wesnoth.wml_actions.give_experience(cfg)
    -- get the XP amount
    local amount = tonumber(cfg.amount) or wml.error("Missing or wrong percentage= value in [give_experience]")

    -- get the receiving unit(s)
    for index, unit in ipairs(wesnoth.units.find_on_map(cfg)) do
        if unit.valid then
            wesnoth.interface.float_label( unit.x, unit.y, string.format("<span color='cyan'>+%s XP</span>", tostring(amount) ) )
            unit.experience = unit.experience + amount
            -- if the experience you get is equal to or exceeds the maximum experience amount
            -- advance the unit
            if unit.experience >= unit.max_experience then
                unit:advance(true, true)
            end
        end
    end    
end


function wesnoth.wml_actions.set_experience(cfg)
    -- get the XP amount
    local amount = tonumber(cfg.amount) or wml.error("Missing or wrong percentage= value in [set_experience]")

    -- get the receiving unit(s)
    for index, unit in ipairs(wesnoth.units.find_on_map(cfg)) do
        if unit.valid then
            wesnoth.interface.float_label( unit.x, unit.y, string.format("<span color='cyan'>%s XP</span>", tostring(amount) ) )
            unit.experience = amount
        end
    end    
end