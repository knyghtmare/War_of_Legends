
-- By 8680.

if not namespace_of_8680s_Lua_Pack then
	namespace_of_8680s_Lua_Pack = {}
	lp8 = lp8 == nil and namespace_of_8680s_Lua_Pack or error(
		"8680s_Lua_Pack initialization aborted: global variable lp8 already taken!", 0)
end

if type(dir_of_8680s_Lua_Pack) ~= 'string' then
	error("8680s_Lua_Pack initialization aborted: `dir_of_8680s_Lua_Pack` is not a string", 0)
end
lp8.lp8dir = dir_of_8680s_Lua_Pack
if lp8.lp8dir: sub(-1) ~= '/' then
	error("8680s_Lua_Pack initialization aborted: `dir_of_8680s_Lua_Pack` must have a slash at the end", 0)
end

if not lp8.require then
	function lp8.require(lib)
		assert(lp8 == namespace_of_8680s_Lua_Pack)
		local alreadyLoaded = lp8[lib]
		if not alreadyLoaded then
			lp8[lib] = dofile(lp8.lp8dir .. lib .. '.lua')
		end
		return lp8[lib], alreadyLoaded
	end
end

function lp8.import(lib, target, overwrite)
	if type(lib) == 'string' then
		lib = lp8.require(lib)
	end
	if type(lib) ~= 'table' then
		error(("bad argument #1 to 'import' (string or table expected, got %s)"):
			format((lp8.dbgstr or type)(name)))
	end
	target = target or _G
	if overwrite then
		if overwrite == 'all' then
			for k in pairs(target) do
				target[k] = nil
			end
		end
		for k, v in pairs(lib) do
			target[k] = v
		end
	else
		for k, v in pairs(lib) do
			if target[k] == nil then
				target[k] = v
			else
				local tostring = lp8.dbgstr or tostring
				error(("cannot import [%s]=(%s) — key already present in target table"):
					format(tostring(k), tostring(v)))
			end
		end
	end
end

do
	local libSymbols, libName, nonlp8
	function lp8.openLib(name)
		if type(name) ~= 'string' then
			error(("bad argument #1 to 'openLib' (string expected, got %s)"):
				format((lp8.dbgstr or type)(name)))
		end
		if libName then
			error(("still defining module %q; cannot start defining module %q"):
				format(libName, name))
		end
		libName = name
		libSymbols = {}
	end
	function lp8.newLib(name)
		if lp8[name] then
			error(("module %q already exists"): format(name))
		end
		lp8.openLib(name)
	end
	function lp8.reopenLib(name)
		if not lp8[name] then
			error(("module %q not found"): format(name))
		end
		lp8.openLib(name)
	end
	function lp8.new_module(name)
		if type(name) ~= 'string' then
			error(("bad argument #1 to 'new_lib' (string expected, got %s)"):
				format((lp8.dbgstr or type)(name)))
		end
		nonlp8 = true
		lp8.openLib(name)
	end
	function lp8.export(symbol, name, gname)
		if symbol ~= nil then
			if type(name) ~= 'string' then
				error(("bad argument #2 to 'export' (string expected, got %s)"):
					format((lp8.dbgstr or type)(name)))
			end
			if gname ~= nil and type(gname) ~= 'string' then
				error(("bad argument #3 to 'export' (string or nil expected, got %s)"):
					format((lp8.dbgstr or type)(gname)))
			end
			if not libSymbols then
				error(("cannot export symbol %s (%s) — no module is being defined"):
					format(name, (lp8.dbgstr or type)(symbol)))
			end
			libSymbols[name] = symbol
			if nonlp8 then
				if gname then
					_G[gname] = symbol
				end
			else
				lp8[gname or name] = symbol
			end
			return symbol
		elseif symbol == nil and name == nil then
			if not libSymbols then
				error("cannot export symbol table — no module is being defined")
			end
			local symbols = libSymbols
			name, libSymbols, libName, nonlp8 = libName
			if nonlp8 then
				return symbols
			elseif type(lp8[name]) == 'table' then
				lp8.import(symbols, lp8[name], true)
				return lp8[name]
			elseif lp8[name] == nil then
				lp8[name] = symbols
				return symbols
			else
				error(("cannot export symbol table of lp8 module %q — `lp8.%s` exists and is not a table"):
					format(name, name))
			end
		elseif symbol == nil and name ~= nil then
			error(("cannot export symbol %s — its value is nil"):
				format(name))
		else
			assert()
		end
	end
end

return {
	require = lp8.require;
	import = lp8.import;
	new_module = lp8.new_module;
	export = lp8.export;
}
