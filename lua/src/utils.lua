
-- By 8680.

lp8.require 'butils'
lp8.require 'type'

lp8.reopenLib 'utils'

local type, tostring = type, tostring
local bdbgstr, typeof = lp8.dbgstr, lp8.Type.of

local function dbgstr(x)
	return bdbgstr(x, typeof)
end
lp8.export(dbgstr, 'dbgstr')

return lp8.export()
