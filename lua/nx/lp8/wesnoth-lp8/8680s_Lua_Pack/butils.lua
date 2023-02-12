
-- By 8680.
-- Utilities that do not use type.lua.
-- As far as other add-ons should be concerned, this is part of utils.lua.
-- This is separate from utils.lua so that type.lua can depend on this even
--  if utils.lua depends on type.lua.

lp8.newLib 'utils'

local type, next, load, loadstring, setfenv =
	type, next, load, loadstring, nil
local h = lp8.helper

lp8.export({}, 'AND')
lp8.export({}, 'OR')

local function noop()
end
lp8.export(noop, 'noop')

local function idem(...)
	return ...
end
lp8.export(idem, 'idem')

function lp8.nyil(f)
	error("Not yet implemented: " .. f, 2)
end

function lp8.nyiw(f)
	h.wml_error("Not yet implemented: " .. f)
end

function lp8.tblorudt(x)
	return type(x) == 'table' or type(x) == 'userdata'
end

local function dbgstr(x, typeof)
	local ty = typeof and typeof(x) or type(x)
	if ty == 'table' or ty == 'function' or ty == 'userdata'
			or x == nil then
		return tostring(x)
	elseif ty == 'string' then
		return ("string: %q"):format(x)
	else
		return tostring(ty) .. ': ' .. tostring(x)
	end
end
lp8.export(dbgstr, 'dbgstr')

local function toBoolean(x)
	if x then
		return true
	else
		return false
	end
end
lp8.export(toBoolean, 'to_boolean')

local function keys(t, k)
	return function(s)
		local k = s.k
		s.k = next(t, k)
		return k
	end, {k = k or next(t)}
end
lp8.export(keys, 'keys')

local function values(t, k)
	return function(s)
		local v
		v, s.k = t[s.k], next(t, s.k)
		return v
	end, {k = k or next(t)}
end
lp8.export(values, 'values')

local function ivalues(t, i)
	return function(s)
		s.i = s.i+1
		return t[s.i-1]
	end, {i = i or 1}
end
lp8.export(ivalues, 'ivalues')

local function lp8load(ld, env, name)
	if not setfenv then
		return load(ld, name, nil, env)
	else
		local ld, e = (type(ld) == 'string' and loadstring or
			type(ld) == 'function' and load or
			error("expected string or function as first argument; received "
				.. ty))(ld, name)
		if ld then
			return setfenv(ld, env)
		else
			return nil, e
		end
	end
end
lp8.export(lp8load, 'load')

local function flip(x, b)
	if b == false then
		return x
	end
	local ty = type(x)
	if ty == 'table' then
		local r = {}
		for i = #x, 1, -1 do
			r[#r+1] = x[i]
		end
		return r
	elseif ty == 'boolean' then
		return not x
	elseif ty == 'string' then
		return x: reverse()
	elseif ty == 'number' then
		return -x
	end
	error("don’t know how to flip a " .. ty)
end
lp8.export(flip, 'flip')

if wesnoth then
	lp8.export(h.set_wml_var_metatable {}, 'wml_vars')
end

return lp8.export()
