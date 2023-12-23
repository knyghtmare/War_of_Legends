local items = wesnoth.require "wml/items"

function wesnoth.wml_actions.highlight_image(cfg)
	local img = cfg.image or wml.error("[highlight_image] missing required image= key")
	local bg = cfg.background or ""
	local where = wesnoth.map.find(cfg)[1]
	if not where then return end
	
	wesnoth.interface.scroll_to_hex(where, false, false, true)
	if cfg.outline then
		wesnoth.interface.highlight_hex(where)
	end
	
	for i = 1, 3 do
		wesnoth.interface.add_item_halo(where.x, where.y, img)
		wesnoth.wml_actions.redraw{}
		wesnoth.interface.delay(300)
		wesnoth.interface.remove_item(where.x, where.y)
		wesnoth.interface.add_item_image(where.x, where.y, bg)
		wesnoth.wml_actions.redraw{}
		wesnoth.interface.delay(300)
	end
	
	if cfg.leave ~= false then
		wesnoth.interface.add_item_image(where.x, where.y, img)
	end
	wesnoth.wml_actions.redraw{}
end

-- Places a unit at a random location matching the filter
-- Automatically excludes locations that already have a unit
-- If all matching locations already have a unit, it does nothing
function wesnoth.wml_actions.random_unit(cfg)
	local filter = wml.get_child(cfg, "filter_location") or wml.error "Missing [filter_location] in [random_unit]"
	if cfg.require_vacant ~= false then
		filter = {
			wml.tag["and"](filter),
			wml.tag["not"]{ wml.tag.filter{} }
		}
	end
	local possible_locations = wesnoth.map.find(filter)
	if #possible_locations == 0 then
		std_print("Error: No matching locations!")
		return
	end
	cfg = wml.shallow_parsed(cfg)
	wml.remove_child(cfg, "filter_location")
	local which_loc = #possible_locations == 1 and 1 or mathx.random(1, #possible_locations)
	cfg.x = possible_locations[which_loc][1]
	cfg.y = possible_locations[which_loc][2]
	wesnoth.wml_actions.unit(cfg)
end

function wesnoth.wml_actions.popup_message(cfg)
	gui.show_popup(cfg.title or "", cfg.message, cfg.image)
end
