
-- By 8680, with help from battlestar (testing), Elvish_Hunter (suggestion for
-- $this_attack), pydsigner (filed GitHub issue #2, which was fixed in commit
-- aa8113bbe0509dadf985910f4c1225d1ba00779e).

lp8.require "utils"
lp8.require "string"
lp8.require "match_attack"

lp8.newLib 'modify_unit_attacks'

local ts, h, stringAttackKeys, numericAttackKeys =
	tostring, lp8.helper,
	{	name = true, description = true, range = true, type = true,
		icon = true	},
	{	damage = true, number = true, movement_used = true,
		attack_weight = true, defense_weight = true }

local function computeAttrDiff(key, oldval, newval)
	local function attrErr(msg)
		h.wml_error(("%s: [modify_unit_attacks]%s=%q"):format(
			msg or "Invalid expression", ts(key), ts(oldval)))
	end
	if stringAttackKeys[key] then
		return newval
	elseif numericAttackKeys[key] then
		return h.round(tonumber(newval)
			or tonumber(lp8.eval(newval, nil, attrErr, attrErr))
			or attrErr())
	elseif lp8.tblorudt(oldval) then
		local t = oldval[1]
		if t == "specials" then
			lp8.nyiw "[modify_unit_attacks][specials]"
		elseif t ~= "filter" and t ~= "filter_attack" then
			h.wml_error(
				"Unrecognized subtag: [modify_unit_attacks]["
					.. ts(t) .. "]")
		end
	else
		attrErr "Unrecognized key"
	end
end

local function computeDiff(original, changes)
	local diff = {}
	for k, v in pairs(changes) do
		diff[k] = computeAttrDiff(k, v,
			lp8.subst(v):gsub("%?", ts(original[k])))
	end
	return diff
end

function wesnoth.wml_actions.modify_unit_attacks(cfg)
	local units, attackFilter =
		wesnoth.get_units(h.get_child(cfg, "filter")),
		h.parsed(h.get_child(cfg, "filter_attack"))
	for i = 1, #units do
		local u, diffs = units[i].__cfg, {}
		-- Compute modifications.
		for attack in h.child_range(u, "attack") do
			if lp8.matchAttack(attack, attackFilter) then
				wesnoth.set_variable("this_attack", attack)
				diffs[attack] = computeDiff(attack, cfg)
			end
		end
		-- Commit changes.
		for attack, diff in pairs(diffs) do
			for k, v in pairs(diff) do
				attack[k] = v
			end
		end
		wesnoth.put_unit(u)
	end
end

return lp8.export()
