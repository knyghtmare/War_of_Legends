local T = wml.tag

local function sign(x)
	if x > 0 then return 1 end
	return -1
end

local abs=math.abs

function wesnoth.wml_actions.WOL_add_curse(cfg)
	local max_cth = 90
	local def_redu = 15
	local function map_def(defense)
		if not defense then return 100 end
		if abs(defense) > max_cth then return defense end
		if abs(defense) > (max_cth-def_redu) then return sign(defense)*max_cth end
		return sign(defense)*(abs(defense)+def_redu)
	end
	
	local units = wesnoth.get_units(cfg)
	for _,u in pairs(units) do
		local def = wml.get_child(u.__cfg, "defense")
		
		u:add_modification("object",{
			id="WOL_curse_object",
			T.effect{
				apply_to="defense",
				replace=true,
				T.defense{
					deep_water=map_def(def["deep_water"]),
					shallow_water=map_def(def["shallow_water"]),
					reef=map_def(def["reef"]),
					swamp_water=map_def(def["swamp_water"]),
					flat=map_def(def["flat"]),
					sand=map_def(def["sand"]),
					forest=map_def(def["forest"]),
					hills=map_def(def["hills"]),
					mountains=map_def(def["mountains"]),
					village=map_def(def["village"]),
					castle=map_def(def["castle"]),
					cave=map_def(def["cave"]),
					frozen=map_def(def["frozen"]),
					unwalkable=map_def(def["unwalkable"]),
					impassable=map_def(def["impassable"]),
					fungus=map_def(def["fungus"])
				}
			},
			T.effect{
				apply_to="overlay",
				add="misc/curse.png"
			}
		})
		u.status.WOL_curse = true
	end
end

function wesnoth.wml_actions.WOL_remove_curse(cfg)
	local units = wesnoth.get_units(cfg)
	for i,u in ipairs(units) do
		u:remove_modifications({id="WOL_curse_object"})
		wesnoth.wml_actions.remove_unit_overlay{id=u.id, image="misc/curse.png"}
		u.status.WOL_curse = false
	end
end

-->>