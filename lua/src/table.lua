
-- By 8680.

lp8.require 'butils'

lp8.newLib 'table'

local function newTable()
	return {}
end
lp8.export(newTable, 'new', 'new_table')

local function copyTable(table, target, noOverwrite)
	if type(table) ~= 'table' then
		error("copyTable(table, target, noOverwrite): expected argument `table` to be a table, but it is a " .. lp8.dbgstr(table))
	end
	if not target and noOverwrite then
		error(("copyTable(table, target, noOverwrite): optional argument `noOverwrite` is truthy (%s), but optional argument `target` is falsy (%s), and defaults to an empty table, so passing `noOverwrite` does not make sense (there is nothing to overwrite!)"):
			format(lp8.dbgstr(noOverwrite), lp8.dbgstr(target)))
	end
	target = target or {}
	if type(target) ~= 'table' then
		error("copyTable(table, target, noOverwrite): expected optional argument `target` to be a table if given, but it is a " .. lp8.dbgstr(target))
	end
	if noOverwrite then
		for k, v in pairs(table) do
			if target[k] == nil then
				target[k] = v
			end
		end
	else
		for k, v in pairs(table) do
			target[k] = v
		end
	end
	return target
end
lp8.export(copyTable, 'copy', 'copyTable')

return lp8.export()
