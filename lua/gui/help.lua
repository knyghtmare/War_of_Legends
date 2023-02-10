--#textdomain wesnoth-NX-RPG

local dialog, data, page_count =
	nxrequire 'gui/dialogs/help', nxrequire 'data/help'

local function select_topic()
	local i = wesnoth.get_dialog_value("topic_list")

	if i > page_count then
		wesnoth.fire("wml_message", {
			logger = "error",
			message = "[NX] BUG: invalid topic_list row number"
		})

		return
	end

	wesnoth.set_dialog_value(i, "help_text_pages")
end

local function preshow()
	page_count = #data

	for i, h in ipairs(data) do
		wesnoth.set_dialog_value(h.name, "topic_list", i, "topic_list_name")
		wesnoth.set_dialog_markup(true,  "topic_list", i, "topic_list_name")

		wesnoth.set_dialog_value(h.text, "help_text_pages", i, "topic_text")
		wesnoth.set_dialog_markup(true,  "help_text_pages", i, "topic_text")
	end

	wesnoth.set_dialog_callback(select_topic, "topic_list")

	select_topic()
end

function wml_actions.show_nx_help()
	wesnoth.show_dialog(dialog, preshow)
end

