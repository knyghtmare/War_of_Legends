
-- By 8680.

lp8.require "utils"

lp8.newLib 'wml'

local type, getmetatable, pcall, pairs, ipairs =
	type, getmetatable, pcall, pairs, ipairs
local flip, tblorudt = lp8.flip, lp8.tblorudt
local at, et, match = {lp8.AND}, {}

local function isCfg(x)
	return getmetatable(x) == 'wml object'
end
lp8.export(isCfg, 'is_cfg')

local function isTag(x)
	if not tblorudt(x) then
		return false
	end
	local s, c = pcall(function()
		return #x == 2 and type(x[1]) == 'string' and x[2]
	end)
	return s and c and tblorudt(c)
end
lp8.export(isTag, 'is_tag')

local function toCfg(x, f)
	return isTag(x) and (match(x, f) and x[2] or error(
		("expected tag input to match filter %q"): format(tostring(f)))) or x
end
lp8.export(toCfg, 'to_cfg')

local function toTag(x, name)
	return isTag(x) and x or {name or "dummy", x}
end
lp8.export(toTag, 'to_tag')

local function isSubtag(p, c)
	p = toCfg(p)
	for i = 1, #p do
		if p[i] == c then
			return true
		end
	end
end
lp8.export(isSubtag, 'is_subtag')

local function isChild(p, c)
	p = toCfg(p)
	for i = 1, #p do
		if p[i][2] == c then
			return true
		end
	end
end
lp8.export(isChild, 'is_child')

local function tagsEqual(x, y)
	return x[1] == y[1] and match(x, y) and match(y, x)
end
lp8.export(tagsEqual, 'tags_equal')

local function cfgsEqual(x, y)
	return tagsEqual(toTag(x), toTag(y))
end
lp8.export(cfgsEqual, 'cfgs_equal')

local function getSubtag(p, f, n, i)
	p = toCfg(p)
	n = n or 1
	for i = i or 1, #p do
		if match(p[i], f) then
			n = n-1
			if n <= 0 then
				return p[i], i
			end
		end
	end
end
lp8.export(getSubtag, 'get_subtag')

local function subtags(p, f, i)
	return function(s)
		local t, i = getSubtag(p, f, 1, s.i + 1)
		s.i = i
		return t, i
	end, {i = i or 0}
end
lp8.export(subtags, 'subtags')

local function children(p, f, i)
	return function(s)
		local c, i = getSubtag(p, f, 1, s.i + 1)
		s.i = i
		return (c or et)[2], i
	end, {i = i or 0}
end
lp8.export(children, 'children')

local function getSubtags(p, f, b)
	local r = {}
	for t in lp8.subtags(p, f) do
		r[#r+1] = t
	end
	return b and flip(r) or r
end
lp8.export(getSubtags, 'get_subtags')

local function getChild(p, f, n, i)
	p, i = getSubtag(p, f, n, i)
	return (p or et)[2], i
end
lp8.export(getChild, 'get_child')

local function getChildren(p, f, b)
	local r = {}
	for c in lp8.children(p, f) do
		r[#r+1] = c
	end
	return b and flip(r) or r
end
lp8.export(getChildren, 'get_children')

local tr = table.remove

local function removeSubtag(p, f, n, i)
	p = toCfg(p)
	n = n or 1
	for i = i or 1, #p do
		if match(p[i], f) then
			n = n-1
			if n <= 0 then
				return tr(p, i), i
			end
		end
	end
end
lp8.export(removeSubtag, 'remove_subtag')

local function removeChild(p, f, n, i)
	p, i = removeSubtag(p, f, n, i)
	return (p or et)[2], i
end
lp8.export(removeChild, 'remove_child')

local function removeSubtags(p, f, b)
	p = toCfg(p)
	local r = {}
	for i = #p, 1, -1 do
		if match(p[i], f) then
			r[#r+1] = tr(p, i)
			i = i-1
		end
	end
	return b and r or flip(r)
end
lp8.export(removeSubtags, 'remove_subtags')

local function removeChildren(p, f, b)
	p = toCfg(p)
	local r = {}
	for i = #p, 1, -1 do
		if match(p[i], f) then
			r[#r+1] = tr(p, i)
			i = i-1
		end
	end
	return b and r or flip(r)
end
lp8.export(removeChildren, 'remove_children')

local function eraseSubtags(p, f)
	p = toCfg(p)
	for i = #p, 1, -1 do
		if match(p[i], f) then
			tr(p, i)
			i = i-1
		end
	end
end
lp8.export(eraseSubtags, 'erase_subtags')

local function mergeAttributes(targetCfg, sourceCfg)
	assert(targetCfg ~= sourceCfg)
	for k, v in sourceCfg do
		if type(k) == 'string' then
			if k:sub(1, 7) == 'add_to_' then
				k = k:sub(8)
				targetCfg[k] = tonumber(targetCfg[k]) + tonumber(v)
			else
				targetCfg[k] = v
			end
		end
	end
end
lp8.export(mergeAttributes, 'merge_attributes')

local function isUnitProxy(x)
	return getmetatable(x) == 'unit'
end
lp8.export(isUnitProxy, 'is_unit_proxy')

function match(t, f)
	local ty = type(f)
	if ty == 'string' then
		return t[1] == f
	elseif ty == 'function' then
		return f(t)
	elseif isTag(f) then
		t, f = t[2], f[2]
		if t == f then
			return true
		end
		for k, v in pairs(f) do
			if type(k) == 'string' and t[k] ~= v then
				return false
			end
		end
		local i = {}
		for k, v in ipairs(f) do
			if isTag(v) then
				k = v[1]; at[2], at[3] = k, v
				v, i[k] = getSubtag(t, at, 1, i[k])
				if not v then
					return false
				end
			end
		end
		return true
	elseif ty == 'table' then
		ty = f[1]
		if ty ~= lp8.AND and ty ~= lp8.OR then
			error "expected Boolean operation constant as first element of tag filter list"
		end
		for i = 2, #f do
			if flip(match(t, f[i]), ty ~= lp8.OR) then
				return ty == lp8.OR
			end
		end
		return ty ~= lp8.OR
	elseif ty == 'boolean' then
		return f
	end
	return f == nil or error(ty .. "s as filters not supported", 2)
end
lp8.export(match, 'match_tag')

local function toUnitCfg(u)
	local p = isUnitProxy(u); return p and u.__cfg
		or tblorudt(u) and u or error(
			("expected unit proxy or unit cfg; received %s with metatable %q"):
				format(type(u), tostring(getmetatable(u)))), p
end
lp8.export(toUnitCfg, 'to_unit_cfg')

return lp8.export()
