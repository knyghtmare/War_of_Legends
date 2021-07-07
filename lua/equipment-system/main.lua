-- started with the add-on Scenario_with_robots as an example of how to do this stuff

helper = wesnoth.require "lua/helper.lua"
-- T = helper.set_wml_tag_metatable {}
T = wml.tag
items = wesnoth.require "lua/wml/items.lua"
_ = wesnoth.textdomain "wesnoth"
                


function z_require(script)
        -- I use dofile instead of , require because it allows me to reload
        -- the whole lua logics (for my scenarios that means nearly all of
        -- the logic)
        -- without having to quit the game and press F5 or close Wesnoth.
        -- thats pretty cool feature for debugging compared to wml
        -- debugging.
        -- maybe i'll change that for release but i don't see a good reason
        -- to do so, bause the time it needs is not really noticeable i
        -- think.
        return wesnoth.dofile('~add-ons/Bad_Moon_Rising/lua/' .. script .. '.lua')
end

Gui_recall2 = z_require("Recall_Menu")
Status_test2 = z_require("Status_Test")
--Debug_test2 = z_require("debug_utils")
equipment_list = z_require("equipment_list")
equipment_write = z_require("equipment_write")
Trader_Menus = z_require("Trader_Menus")
Trader_Menus2 = z_require("Trader_Menus2")
bmr_wml_tags = z_require("bmr_wml_tags")
bmr_helper = z_require("bmr_helper")
