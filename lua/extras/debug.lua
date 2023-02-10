--#textdomain wesnoth-NX-RPG

---
-- Used to see if a character has been found and developed
--
-- [check_for_character]
--     [character]
--         ... Unit stats ...
--     [/character]
-- [/check_for_character]
---
function wml_actions.check_for_character(cfg)
	for entry in helper.child_range(cfg, "character") do
		if not wesnoth.eval_conditional { { "have_unit", { side = 1, id = entry.id } } } then
			local unit_def = {}
			for k,v in pairs(entry.__parsed) do unit_def[k] = v end
			unit_def.placement = 'leader'
			wml_actions.unit(unit_def)
		end
	end
end
