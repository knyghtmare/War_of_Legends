-- #textdomain wesnoth-NX-RPG

---
-- Displays an error message on a popup dialog.
--
-- This is intended to be used as an exit mechanism when the WML detects an
-- inconsistency (see the BUG and BUG_ON macros in macros/debug-utils.cfg
--
-- [bug]
--     message= <...>
--     # Optional conditional statement
--     [condition]
--         ...
--     [/condition]
-- [/bug]
---

local dialogs = nxrequire "gui/dialogs/bug"

function wml_actions.bug(cfg)
	local cond = helper.get_child(cfg, "condition")

	if cond and not wesnoth.eval_conditional(cond) then
		return
	end

	local notice = cfg.message
	local log_notice = notice

	if log_notice == nil or log_notice == "" then
		log_notice = "inconsistency detected"
	end

	wesnoth.fire("wml_message", {
		logger = "error",
		message = "[NX] BUG: " .. log_notice
	})

	local function show_details()
		local cap = _ "Details"
		local msg = _ "The following WML condition was unexpectedly reached:"

		-- #textdomain wesnoth
		_ = wesnoth.textdomain "wesnoth"
		local ok = _ "Close"

		wesnoth.show_dialog(dialogs.dialog, function()
			wesnoth.set_dialog_canvas(1, {
				T.rectangle {
					x = 0,
					y = 0,
					w = "(width)",
					h = "(height)",
					fill_color = "0,0,0,64"
				} }, "wml")
			wesnoth.set_dialog_value(cap, "title")
			wesnoth.set_dialog_value(msg, "message")
			wesnoth.set_dialog_value(wesnoth.debug(cond), "wml")
			wesnoth.set_dialog_value(ok, "ok")
		end)
	end

	local function preshow()
		-- #textdomain wesnoth-NX-RPG
		local _ = wesnoth.textdomain "wesnoth-NX-RPG"
		local msg = _ "An inconsistency has been detected, and the scenario might not continue working as originally intended."
		msg = msg .. "\n\n" .. _ "Please report this to the campaign maintainer!"

		if notice ~= nil and notice ~= "" then
			msg = msg .. "\n\n" .. _ "Message:"
			msg = msg .. "\n\t" .. cfg.message
		end

		msg = msg .. "\n"

		local cap = _ "Error"
		local det = _ "Details"

		-- #textdomain wesnoth
		_ = wesnoth.textdomain "wesnoth"
		local ok = _ "Continue"
		local quit = _ "Quit"

		wesnoth.set_dialog_value(cap, "title")
		wesnoth.set_dialog_value(msg, "message")
		wesnoth.set_dialog_value(det, "details")
		wesnoth.set_dialog_value(ok , "ok")
		wesnoth.set_dialog_value(quit , "quit")

		wesnoth.set_dialog_callback(show_details, "details")
	end

	if wesnoth.show_dialog(dialogs.alert_dialog, preshow, nil) == 2 then
		wesnoth.fire("endlevel", {
			result = "defeat",
			linger_mode = false
		})
	end
end
