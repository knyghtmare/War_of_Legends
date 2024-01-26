local T = wml.tag

function wesnoth.wml_actions.WOL_add_cold_status(cfg)	
	local units = wesnoth.units.find_on_map(cfg)
	for _,u in pairs(units) do
		u:add_modification("object",{
			id = "WOL_cold_status_object",
            duration = "turn",
            -- add overlay
			T.effect{
				apply_to="overlay",
				add="misc/cold-overlay.png"
			}
		})
		u.status.cold_status = true
	end
end