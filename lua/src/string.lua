
-- By 8680.

lp8.require "utils"

lp8.newLib 'string'

local tn, ts, tb = tonumber, tostring, lp8.to_boolean
local tblrm, unpack = table.remove, table.unpack or unpack
local vcfg = type(wesnoth) == 'table' and wesnoth.tovconfig or nil
local load = lp8.load

local function trim(s)
	-- trim5 from <http://Lua-Users.org/wiki/StringTrim>.
	return ts(s): match "^%s*(.*%S)" or ""
end
lp8.export(trim, 'trim')

local function gtrim(s)
	return ts(s): gsub("%s+", "")
end
lp8.export(gtrim, 'gtrim')

local function eval(s, e, cerr, rerr)
	s = ts(s)
	local fs = 'return ' .. s
	local f, ce = load(fs, e)
	if f then
		if rerr == nil then
			return f()
		end
		local r = {pcall(f)}
		if r[1] then
			tblrm(r, 1)
			return unpack(r)
		end
		if type(rerr) == 'function' then
			rerr(r[2], s)
		elseif type(rerr) == 'string' then
			error(rerr)
		end
	else
		if type(cerr) == 'function' then
			cerr(ce, s)
		elseif type(err) == 'string' then
			error(cerr)
		else
			error(("can’t compile %q — %s"):format(s, ce:gsub(
				('^%%[string %q%%]:(%%d+): (.+)$'):format(fs),
				'%2 (line %1)')))
		end
	end
end
lp8.export(eval, 'eval')

local function subst(s)
	return vcfg {s = ts(s)}.s
end
lp8.export(subst, 'subst')

local function interp(s, e)
	return ts(s): gsub("%?%b{}",
		function(x) return ts(eval(x: sub(2, -1), e)) end)
end
lp8.export(interp, 'interp')

local function strtod(s)
	s = trim(s)
	local sign = s:sub(1,1)
	if sign == '-' or sign == '+' then
		s = s:sub(2)
		sign = sign == '-' and -1 or 1
	else
		sign = 1
	end
	s = s:upper()
	if s == 'INF' or s == 'INFINITY' then
		return (1/0) * sign
	elseif s == 'NAN' or s:match 'NAN%(%w*%)' then
		return 0/0
	end
	s = tn(s)
	return s and s * sign or s
end
lp8.export(strtod, 'strtod')

local function parseWMLBoolean(s)
	s = ts(s)
	if s == 'yes' or s == 'true' then
		return true
	elseif s == 'no' or s == 'false' then
		return false
	end
end
lp8.export(parseWMLBoolean, 'parse_wml_boolean')

local function parseWMLValue(s)
	s = ts(s)
	local v = parseWMLBoolean(s)
	if v ~= nil then
		return v
	end
	v = strtod(s)
	if v and (ts(v):lower() == s:lower() or v == 1/0) then
		-- `or v == 1/0` — An input of `infinity` would re-stringify
		-- to `inf`, but I permit that because no information is lost.
		return v
	end
	return s
end
lp8.export(parseWMLValue, 'parse_wml_value')

local function patternEscape(s)
	return ts(s):gsub('([%^%$%(%)%%%.%[%]%*%+%-%?])', '%%%1')
end
lp8.export(patternEscape, 'pattern_escape')

local function isIdentifier(s)
	return tb(ts(s):match '^[%a_][%w_]*$')
end
lp8.export(isIdentifier, 'is_identifier')

return lp8.export()
