
local items = wesnoth.require "wml/items"

function wesnoth.wml_actions.give_item(cfg)
	local object = wml.get_child(cfg, "object") or wml.error "Missing required [object] tag in [give_item]"
	object = wml.shallow_parsed(object)
	object.item_id = cfg.id
	local recipient_filter = wml.get_child(cfg, "filter_recipient") or {x = cfg.x, y = cfg.y}
	local to_whom = wesnoth.units.find_on_map(recipient_filter)[1]
	to_whom:add_modification('object', object)
	wesnoth.wml_actions.unit_overlay{
		id = to_whom.id,
		image = cfg.overlay
	}
	local unit_cfg = to_whom.__cfg
	local drop_cfg = wml.literal(cfg)
	drop_cfg.x = '$|unit.x'
	drop_cfg.y = '$|unit.y'
	wml.remove_child(drop_cfg, "filter_recipient")
	drop_cfg = wml.tovconfig(drop_cfg)
	table.insert(unit_cfg, wml.tag.event{
		name = 'die',
		id = 'drop_' .. cfg.id,
		wml.tag.filter(wml.tovconfig{id = to_whom.id}),
		wml.tag.place_item(drop_cfg)
	})
	wesnoth.units.to_map(unit_cfg)
	if to_whom.side == 1 then
		if object.description or not object.silent then
			gui.show_popup(object.name, object.description, object.image)
		end
	end
end

function wesnoth.wml_actions.place_item(cfg)
	local x, y = cfg.x, cfg.y
	if not x or not y then
		local at = wesnoth.current.map.special_locations[cfg.location_id]
		x, y = at[1], at[2]
	end
	local give_cfg = wml.literal(cfg)
	give_cfg.location_id = nil
	give_cfg.x, give_cfg.y = x, y
	give_cfg = wml.tovconfig(give_cfg)
	wesnoth.interface.add_item_image(x, y, cfg.image)
	-- Now build up the event code.
	local evt = {name = 'moveto', first_time_only = false, id = cfg.id .. '_pickup'}
	local condition, success, failure, take, leave = {}, {}, {}, {}, {}
	local lcfg = wml.literal(cfg)
	table.insert(condition, wml.tag.have_unit{x = x, y = y, wml.tag["and"](wml.get_child(lcfg, "filter") or wml.error "Missing required [filter] tag in [place_item]")})
	table.insert(take, wml.tag.give_item(give_cfg))
	table.insert(take, wml.tag.remove_item{x = x, y = y, image = cfg.image})
	table.insert(take, wml.tag.remove_event{id = evt.id})
	if wml.child_count(cfg, 'on_take') == 1 then
		table.insert(take, wml.tag.command(wml.get_child(cfg, 'on_take')))
	end
	table.insert(leave, wml.tag.allow_undo{})
	table.insert(success, wml.tag.message{
		speaker = 'narrator',
		message = lcfg.text,
		image = cfg.portrait or cfg.image,
		wml.tag.option{
			label = lcfg.take_prompt,
			wml.tag.command(take)
		},
		wml.tag.option{
			label = lcfg.leave_prompt,
			wml.tag.command(leave)
		}
	})
	table.insert(failure, wml.tag.message{
		speaker = 'narrator',
		message = lcfg.cannot_use_text,
		image = cfg.portrait or cfg.image,
		side_for = wesnoth.current.side -- To prevent an AI side from accidentally triggering the dialog
	})
	table.insert(evt, wml.tag.filter{x = x, y = y})
	local if_block = wml.tag["if"](condition)
	table.insert(if_block[2], wml.tag["then"](success))
	table.insert(if_block[2], wml.tag["else"](failure))
	table.insert(evt, if_block)
	wesnoth.wml_actions.event(evt)
end