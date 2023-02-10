-- NX global configuration for Lua.

_ = wesnoth.textdomain 'wesnoth-NX-RPG'
wml_actions = wesnoth.wml_actions
wml_conditionals = wesnoth.wml_conditionals
helper = wesnoth.require 'lua/helper.lua'
items = wesnoth.require 'lua/wml/items.lua'
T = helper.set_wml_tag_metatable {}
--debug_utils = wesnoth.require '~add-ons/Wesnoth_Lua_Pack/debug_utils.lua'

nxconfig = lp8.new_table()

-- nxconfig.name = '{NX_NAME}'

-- #ifdef NX_IS_GIT
-- nxconfig.git = lp8.new_table()
-- nxconfig.git.head = '{NX_GIT_HEAD}'
-- nxconfig.git.branch = nxconfig.git.head:match '^ref: refs/heads/(.+)'
-- #endif

function nxrequire(script)
	return wesnoth.require('~add-ons/NX-RPG/lua/' .. script .. '.lua')
end

for _, script in ipairs {
	'debug';
	'theme';
	'hex';
	'spawner';
	'wml_tags';
	'gui/bug';
	'gui/help';
	'gui/inventory';
	'gui/item_pickup';
	'gui/spellcasting';
	'gui/transient_message';
} do
	nxrequire(script)
end
