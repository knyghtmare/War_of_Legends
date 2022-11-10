T = wml.tag
items = wesnoth.require "lua/wml/items.lua"
_ = wesnoth.textdomain "wesnoth"
                


function wol_require(script)
        return wesnoth.dofile('~add-ons/War_of_Legends/lua/inv-sys2/' .. script .. '.lua')
end

Status_test2 = wol_require("Status_Test")

equipment_list = wol_require("equipment_list")
equipment_write = wol_require("equipment_write")

war_of_legends_wml_tags = wol_require("wol_wml_tags")
war_of_legends_helper = wol_require("wol_helper")
wol_wml_tags = wol_require("wol_wml_tags")