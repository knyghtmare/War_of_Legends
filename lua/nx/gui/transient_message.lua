
---
-- Displays a transparent message box that's dimissed when clicked.
--
-- [transient_message]
--     caption=(tstring)
--     message=(tstring)
--     transparent=(boolean, default true)
--     image=(image path)
--     sound=(string)
-- [/transient_message]
---

local dialog = nxrequire "gui/dialogs/transient_msg"

function wml_actions.transient_message(cfg)
	local dd = dialog(cfg.image)

	if cfg.transparent ~= false then
		dd.definition = "message"
	end

	local function preshow()
		wesnoth.set_dialog_value(cfg.caption or "", "caption")
		wesnoth.set_dialog_value(cfg.message or "", "message")

		if cfg.image then
			wesnoth.set_dialog_value(cfg.image, "image")
		end
	end

	if cfg.sound then
		wesnoth.play_sound(cfg.sound)
	end

	wesnoth.show_dialog(dd, preshow)
end
