-- Full credits for this code goes to the one and only
-- Iris Morelle
--
-- Lua core utilities library
--
-- codename Naia - Project Ethea phase 1 campaigns shared library
-- Copyright (C) 2006 - 2020 by Iris Morelle <shadowm@wesnoth.org>
--
-- See COPYING for usage terms.
--

---
-- Returns a pseudorandom value from a set without syncing replays/MP.
--
-- This will use the same format as WML [set_variable] in the future, maybe,
-- but for now it's just a trivial wrapper around math.random with the added
-- requirement of providing both arguments.
--
-- Do NOT use this for gamestate-altering actions. You've been warned.
---
function unsynced_random(a, b)
	return math.random(a, b)
end

---
-- Log levels for wput and wprintf.
---

W_ERR  = 1 -- Error.
W_WARN = 2 -- Warning (default maximum log level).
W_INFO = 3 -- Info.
W_DBG  = 4 -- Debug.

local loglvl_map = { "error", "warning", "info", "debug" }

local logprefix = "[War of Legends] "

local logdepth = 0

function _wsetlogprefix(str)
	logprefix = "[" .. str .. "] "
end

function _windentprefix()
	return string.rep(" ", logdepth * 4)
end

---
-- Prints a text line using the engine log facilities.
--
-- lvl: One of W_ERR, W_WARN, W_INFO, or W_DBG.
-- msg: Line contents.
---
function wput(lvl, msg)
	wesnoth.wml_actions.wml_message {
		logger = loglvl_map[math.max(1, math.min(lvl, #loglvl_map))],
		message = logprefix .. _windentprefix() .. tostring(msg)
	}
end

---
-- Prints a formatted (printf-style) line using the engine log facilities.
--
-- lvl: One of W_ERR, W_WARN, W_INFO, or W_DBG.
-- fmt: Line format specification.
-- ...: Parameters for line formatting.
---
function wprintf(lvl, fmt, ...)
	wput(lvl, tostring(fmt):format(...))
end

---
-- Increases the log indentation level.
---
function windent()
	logdepth = logdepth + 1
end

---
-- Decreases the log indentation level.
---
function wunindent()
	logdepth = math.max(0, logdepth - 1)
end

---
-- Returns a textdomain-specific string translated to the current locale
--
-- Note that this is only intended to be used with mainline textdomains. For
-- add-on textdomains the _ hack including comments with fake WML is still
-- needed so that wmlxgettext can catch and add the new strings.
---
function wgettext(str, domain)
	if domain == nil then
		domain = "wesnoth"
	end

	return wesnoth.textdomain(domain)(str)
end

---
-- Returns a value restricted to a range [minval, maxval].
---
function in_range(value, minval, maxval)
	return math.max(minval, math.min(value, maxval))
end

---
-- Returns the size of a table.
---
function table_size(table_v, include_nil)
	local n = 0
	for val in pairs(table_v) do
		if val ~= nil or include_nil == true then
			n = n + 1
		end
	end
	return n
end

---
-- Returns whether a table is empty or not.
---
function table_empty(table_v, include_nil)
	for val in pairs(table_v) do
		if val ~= nil or include_nil == true then
			return false
		end
	end

	return true
end

---
-- Returns a sorted list of keys for a table.
---
function table_keys(table_v)
	local keys = {}
	for key, v in pairs(table_v) do
		table.insert(keys, key)
	end
	table.sort(keys)
	return keys
end

---
-- Returns a table that contains the elements of both tables.
--
-- If table_b has items with the same keys as those of table_a then they will
-- overwrite the latter's items in the result table.
---
function table_merge(table_a, table_b)
	local keys_a, keys_b = table_keys(table_a), table_keys(table_b)
	local result = {}

	for _, key in ipairs(keys_a) do
		result[key] = table_a[key]
	end

	for _, key in ipairs(keys_b) do
		result[key] = table_b[key]
	end

	return result
end

---
-- Dumps a table in string form.
---
function table_dump(obj, level)
	if level == nil then
		level = 0
	end

	local str = ""

	local function write_base(text, newline, indent)
		if newline == nil then
			newline = true
		end

		if indent == nil then
			indent = true
		end

		if indent then
			str = str .. string.rep(" ", level * 4)
		end

		str = str .. text

		if newline then
			str = str .. "\n"
		end
	end

	local function put(text)
		write_base(text, true, true)
	end

	local function add(text)
		write_base(text, false, false)
	end

	local function finalize(text)
		write_base(text, true, false)
	end

	local function start(text)
		write_base(text, false, true)
	end

	finalize("{")
	level = level + 1

	for k, v in pairs(obj) do
		if type(k) == "number" then
			start(("[%d] = "):format(k))
		elseif type(k) == "string" then
			start(("\"%s\" = "):format(k))
		else
			start(("<%s key> = "):format(type(k)))
		end

		if type(v) == "number" then
			finalize(("%d"):format(v))
		elseif type(v) == "string" then
			finalize(("\"%s\""):format(v))
		elseif type(v) == "table" then
			finalize(("table: %s"):format(table_dump(v, level)))
		else
			finalize(("data: %s"):format(tostring(v)))
		end
	end

	level = level - 1
	put("}")

	return str
end

---
-- Returns to the titlescreen ASAP.
---
function die()
	local endlevel_config = {
		result           = "defeat",
		linger_mode      = false,
		carryover_report = false
	}

	-- Because of some stupid 1.14 behaviour change/bug, firing endlevel
	-- before prestart results in the player's victory and instant
	-- completion of the whole campaign. Injecting a preload event to run
	-- endlevel after the storyscreen works.
	if wesnoth.current.event_context.name == "_from_lua" then
		wput(W_DBG, "deferred die() on global [lua] context")
		on_event("preload", function()
			wesnoth.wml_actions.endlevel(endlevel_config)
		end)
	else
		wput(W_DBG, "die() on event context")
		wesnoth.wml_actions.endlevel(endlevel_config)
	end
end

---
-- Helper used for injecting global events (see /core/events.cfg).
---

function global_run_wml(cfg)
	local evtcount = wml.child_count(cfg, "event")
	local wmicount = wml.child_count(cfg, "set_menu_item")

	wprintf(W_INFO, "Running global events block (%d events, %d menu items)", evtcount, wmicount)

	utils.handle_event_commands(cfg)
end

---
-- Version number object.
--

--version_number = {}
--version_number.__index = version_number

--function version_number:new(value)
--	local o = {}

--	setmetatable(o, version_number)

--	o.value = tostring(value) or '0.0.0'
--	o._str = o.value

	-- 1.2.x is a glob match on 1.2.*
--	if o.value:match('^[0-9]+%.([0-9]+%.)x$') ~= nil then
--		o.value = o.value:gsub('x$', '9999')
--	end

--	return o
--end

--function version_number:__tostring()
--	return self._str
--end

--function version_number:compare(op, b)
--	return wesnoth.compare_versions(self.value, op, b.value)
--end

--function version_number.__lt(a, b)
--	return a:compare('<', b)
--end
--function version_number.__le(a, b)
--	return a:compare('<=', b)
--end

--function version_number.__eq(a, b)
--	return a:compare('==', b)
--end

--WESNOTH_VERSION = version_number:new(wesnoth.game_config.version)

--wprintf(W_INFO, "codename Naia version %s initializing", PROJECT_ETHEA_NAIA_VERSION)
--turn wesnoth.textdomain(domain)(str)
--end