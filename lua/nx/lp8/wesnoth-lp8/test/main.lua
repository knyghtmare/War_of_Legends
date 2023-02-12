#!/usr/bin/env lua

-- Some scripts trying to be a proper test suite for 8680’s Lua Pack.
-- To be run from the `test` directory of the repository working tree.

assert(_VERSION:match '^Lua 5%.[12]$')

dir_of_8680s_Lua_Pack = '../8680s_Lua_Pack/'
dofile '../8680s_Lua_Pack/load.lua'

dofile 'string.lua'
dofile 'type.lua'

-- vim: tabstop=4:
