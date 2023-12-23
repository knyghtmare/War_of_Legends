local _ = wesnoth.textdomain "wesnoth-War_of_Legends"

local haste_total = wml.variables.haste_potion
local healing_total = wml.variables.healing_potion
local haste_new = haste_total - (wml.variables.haste_potion_old or haste_total)
local healing_new = healing_total - (wml.variables.healing_potion_old or healing_total)

local haste_detail = _("another haste potion","$potions more haste potions",haste_new):vformat{potions = haste_new}
local healing_detail = _("another healing potion","$potions more healing potions",healing_new):vformat{potions = healing_new}

haste_total = _("just one haste potion", "$potions haste potions", haste_total):vformat{potions = haste_total}
healing_total = _("just one healing potion", "$potions healing potions", healing_total):vformat{potions = healing_total}

local open_green = "<span color='darkgreen' font_weight='bold'>"
local open_orange = "<span color='orange' font_weight='bold'>"
local close = "</span>"

haste_detail = open_orange .. haste_detail .. close
haste_total = open_orange .. haste_total .. close
healing_detail = open_green .. healing_detail .. close
healing_total = open_green .. healing_total .. close

local new_list = {}
if haste_new > 0 then table.insert(new_list, haste_detail) end
if healing_new > 0 then table.insert(new_list, healing_detail) end

wml.variables.potion_details = stringx.format_conjunct_list(_'no more potions', new_list)
wml.variables.potion_totals = stringx.format_conjunct_list('', {haste_total, healing_total})
