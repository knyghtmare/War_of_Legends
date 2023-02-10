--#textdomain wesnoth-NX-RPG

---
-- Adds a gui indicator like those for slow and poison to the displayed unit.
--
-- [add_status_icon]
--     image=image
--     tooltip= _ "text"
--     status=status_name
-- [/add_status_icon]
---
function wml_actions.add_status_icon(cfg)
	local old_unit_status = wesnoth.theme_items.unit_status

	function wesnoth.theme_items.unit_status()
		local u = wesnoth.get_displayed_unit()
		if not u then return {} end

		local s = old_unit_status()
		local status = cfg.status
		if u.status.status then
			table.insert(s, { "element", {
				image = cfg.image,
				tooltip = cfg.tooltip
			} })
		end
	end
	return s
end

