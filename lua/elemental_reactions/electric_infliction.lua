local T = wml.tag

function wesnoth.wml_actions.WOL_add_electric_status(cfg)	
	local units = wesnoth.units.find_on_map(cfg)
	for _,u in pairs(units) do
		u:add_modification("object",{
			id = "WOL_electric_status_object",
            duration = "turn",
            -- add overlay
			T.effect{
				apply_to="overlay",
				add="misc/electric-overlay.png"
			}
		})
		u.status.electric_status = true
	end
end