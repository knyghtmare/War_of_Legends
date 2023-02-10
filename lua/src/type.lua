
-- By 8680.

lp8.require 'butils'
lp8.require 'table'

lp8.newLib 'type'

local function getType(x)
	x = getmetatable(x)
	if x then
		x = x._lp8_type
		if x then
			return x
		end
	end
end

-- `mt` = metatable.
local Type, Type_mt, Type_objmt = {of = getType}, {}, {}
lp8.export(setmetatable(Type, Type_mt), 'Type')

function Type_mt:__call(name)
	if type(name) ~= 'string' then
		error("Type(name): expected argument `name` to be a string, but it is a " .. lp8.dbgstr(name))
	end
	local newType = {}
	local mt, objmt = {_lp8_type = Type}, {_lp8_type = newType}
	function mt:__call(...)
		local obj, init = setmetatable({}, objmt), self.init
		return init and init(obj, ...) or obj
	end
	function mt.__tostring() return name end
	return setmetatable(newType, mt)
end

function Type_mt.__tostring() return 'Type' end

local Typetag = Type 'Typetag'
lp8.export(Typetag, 'Typetag')

function Typetag:init(name)
	if type(name) ~= 'string' then
		error("Type(name): expected argument `name` to be a string, but it is a " .. lp8.dbgstr(name))
	end
	local newType, mt = self, getmetatable(self)
	function mt:__call(objectBase)
		if type(objectBase) ~= 'table' then
			error(name .. "(objectBase): expected argument `objectBase` to be a table, but it is a " .. lp8.dbgstr(objectBase))
		end
		local objmt = getmetatable(objectBase)
		objmt = objmt and lp8.copyTable(objmt) or {}
		objmt._lp8_type = newType
		return setmetatable(objectBase, objmt)
	end
	function mt.__tostring() return name end
end

return lp8.export()
