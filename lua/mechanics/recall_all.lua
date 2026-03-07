function wesnoth.wml_actions.recall_all(cfg)
	local units = wesnoth.units.find_on_recall(cfg)

	for i, u in ipairs(units) do
		wesnoth.wml_actions.recall({ id = u.id })
	end
end


function wesnoth.wml_actions.recall_highest(cfg)
    -- recall highest level unit on x, y
    local x = cfg.x or wml.error( "Missing or wrong x= value in [recall_highest]" )
    local y = cfg.y or wml.error( "Missing or wrong y= value in [recall_highest]" )

    for level = 5, 1, -1 do
        wesnoth.wml_actions.recall({
            level = level,
            x = x,
            y = y,
        })

        local unit = wesnoth.get_unit(x, y)
        if unit ~= nil then
            return
        end
    end
end