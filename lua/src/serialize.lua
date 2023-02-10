
-- By 8680.

lp8.newLib 'serialize'

local load = loadstring or load

local function serialize(x, t)
	local ty = type(x)
	if ty == 'table' then
		if t then
			for i = 1, #t do
				assert(t[i] ~= x,
					"serialization of recursive tables not yet implemented")
			end
			table.insert(t, x)
		else
			t = {x}
		end
		local r = '{'
		for k, v in pairs(x) do
			if type(k) == 'table' or type(k) == 'function' then
				error(type(k) .. "s as keys not yet implemented")
			end
			r = ("%s[%q]=%q;"): format(r, serialize(k, t), serialize(v, t))
		end
		table.remove(t)
		return r .. '}'
	elseif ty == 'string' then
		return 'S' .. x
	elseif ty == 'number' then
		return 'N' .. tostring(x)
	elseif ty == 'boolean' then
		return x and 'B' or 'b'
	elseif ty == 'function' then
		return 'F' .. string.dump(x)
	elseif x == nil then
		return 'n'
	else
		error("serializing " .. ty .. "s not supported")
	end
end
lp8.export(serialize, 'serialize')

local function deserialize(x)
	local ty = x.sub(1,1)
	if ty == '{' then
		local t = {}
		for k, v in pairs(
				assert(load("return " .. x), "corrupt serialized table")()) do
			t[deserialize(k)] = deserialize(v)
		end
		return t
	elseif ty == 'S' then
		return x.sub(2)
	elseif ty == 'N' then
		return assert(tonumber(x.sub(2)), "corrupt serialized number")
	elseif ty == 'B' then
		return true
	elseif ty == 'b' then
		return false
	elseif ty == 'F' then
		return assert(load(x), "corrupt serialized function")
	elseif ty ~= 'n' then
		error(("unrecognized data type code %q"): format(ty))
	end
end
lp8.export(deserialize, 'deserialize')

return lp8.export()
