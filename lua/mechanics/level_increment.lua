function wesnoth.effects.level(unit, cfg)
	if cfg.set then
		unit.level = cfg.set
	elseif cfg.increase then
		unit.level = unit.level + cfg.increase
	elseif cfg.new_level then
		unit.level = cfg.new_level
	elseif cfg.value then
		unit.level = cfg.value
	else
		wml.error("Invalid or Missing key in [effect] apply_to=level")
	end
end