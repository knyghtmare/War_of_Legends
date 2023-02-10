
-- By 8680.

-- Pre-declare variables to satify Wesnoth strict mode
lp8 = nil
namespace_of_8680s_Lua_Pack = {}

lp8 = lp8 == nil and namespace_of_8680s_Lua_Pack or error(
	"8680s_Lua_Pack initialization aborted: global variable lp8 already taken!", 0)
lp8.helper = wesnoth.require "lua/helper.lua"
lp8.lp8dir = dir_of_8680s_Lua_Pack
function lp8.require(lib)
	assert(lp8 == namespace_of_8680s_Lua_Pack)
	local alreadyLoaded = lp8[lib]
	if not alreadyLoaded then
		lp8[lib] = wesnoth.require(lp8.lp8dir .. lib .. ".lua")
	end
	return lp8[lib], alreadyLoaded
end
lp8.require 'load'

return lp8.require
