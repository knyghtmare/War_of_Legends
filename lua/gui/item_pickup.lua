--#textdomain wesnoth-NX-RPG

---
-- This brings up a dialog when a unit moves to pick up an item.
-- There are 3 choices:
-- * USE:   Apply the item's effect, and add to inventory if effect_type = continuous
-- * TAKE:  Add item to inventory. No effect is applied
-- * LEAVE: Do nothing
--
-- [take_item]
--     id=must be unique
--     name= _ "string"
--     image=path/to/image.png
--     description= _ "translatable string"
--     effect_type=use either "single" or "continuous"
--     event=the name of the event to fire if you USE or TAKE the item
--     [usuable_by]
--         ... SUF: The item will only be able to be used or taken if the primary
--             unit matches this filter
--     [/usuable_by]
--     [usable_if]
--         ... The item will only be usable if this condition is matched ...
--     [/usable_if]
--     [command]
--         ... Code to execute when item is used
--     [/command]
--     [removal_command]
--         ... Code to be executed if item is being unequiped.
--             Only applies if effect_type = continuous
--     [/removal_command]
-- [/take_item]
---

local dialog = nxrequire "gui/dialogs/item_pickup"
local buttons = dialog.buttons
dialog = dialog.dialog

function wml_actions.take_item(cfg)
	cfg = helper.shallow_parsed(cfg)

	local unit = wesnoth.get_units({x = wesnoth.current.event_context.x1, y = wesnoth.current.event_context.y1})[1].__cfg
	local vars = helper.get_child(unit, "variables")

	local function item_preshow()
		-- Set all widget starting values
		wesnoth.set_dialog_value ( cfg.name, "item_name" )
		wesnoth.set_dialog_value ( cfg.image or "", "image_name" )
		wesnoth.set_dialog_value ( cfg.description, "item_description" )

		if cfg.effect_type == "continuous" then
			wesnoth.set_dialog_value(_"Equip", "use_button")
		end

		-- Disable the use button if necessary (the item cannot be uses on the specific loc or the wrong unit has it)
		wesnoth.set_dialog_active(wesnoth.eval_conditional (helper.get_child(cfg, "usable_if") or {}), "use_button")

		local filter_block = helper.get_child(cfg, "usable_by")

		if not wesnoth.eval_conditional { { "have_unit", filter_block } } then
			wesnoth.set_dialog_value(filter_block.cannot_use_message, "cannot_use_warning")

			wesnoth.set_dialog_active(false, "use_button")
			wesnoth.set_dialog_active(false, "take_button")
		end
	end

	local button = wesnoth.show_dialog(dialog, item_preshow)

	local function set_item_vars(activate)
		local item = helper.get_child(vars, "item", cfg.id)

		if item then
			item.quantity = (item.quantity or 0) + 1
		else
			if activate then
				cfg.active = true
			end
			table.insert(vars, {"item", cfg})
		end

		wesnoth.put_unit(unit)
	end

	local function clean_up_item()
		local event = cfg.event or cfg.id .. "_taken"
		local loc_x = wesnoth.current.event_context.x1
		local loc_y = wesnoth.current.event_context.y1

		wesnoth.fire_event(event, loc_x, loc_y)

		items.remove(loc_x, loc_y)
	end

	if button == buttons.use or button == -1 then
		if cfg.effect_type == "continuous" then
			set_item_vars('and activate item')
		end
		wml_actions.command(helper.get_child(cfg, "command"))
		clean_up_item()
	end

	if button == buttons.take then
		set_item_vars()
		clean_up_item()
	end
end

-- Compatibility layer for save games. Remove in 0.5.5
wml_actions.pick_up_item = wml_actions.take_item
