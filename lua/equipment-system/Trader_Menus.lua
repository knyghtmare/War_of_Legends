--[[  

This is for the dialog when selling equipment to the merchant 

]]

Trader_Menus  = {}
Trader_Menus.seller = function(side_number)
local function item_list_content()
      return T.list_definition { T.row { T.column { horizontal_grow = true, T.toggle_panel { T.grid {
      			T.row { 
      				T.column { T.image { id = "item_image" }}, 
      				T.column { T.label { id = "item_cost" }} 
      				},
      			T.row { 
      				T.column { horizontal_grow = true, T.label { id = "item_id" }}, 
      				T.column { T.spacer { id = "item_spacer" }} 
      				}
				}}}}}
end

local blank_icon ="misc/blank-hex.png~SCALE(40,40)"
local pool_list = {}
local sell_list = {}
local pool_value = 0
local sell_value = 0
local li = 0
local sli = 0
local sell_dialog = {
  T.tooltip { id = "tooltip_large" },
  T.helptip { id = "helptip_large" },
  maximum_height = 800, maximum_width = 800,                                               
  --automatic_placement = false,                                             
  --height = 850, width = 700, 
  T.grid { 
  	   T.row { T.column { T.label { id = "the_title"}}},
  	   T.row { T.column { T.image { id = "the_image"}}},
  	   T.row { T.column { T.drawing { id = "top_line", width = 540, height = 30, T.draw {    
  	                      T.line { x1 = 40, y1 = 15, x2 = 500, y2 = 15, color = "255,255,255,255", thickness = 3}, T.text { font_size = 1 }
  	                      }}}},
  	   T.row { T.column { T.grid {
  	                           T.row {
  	                                        T.column { horizontal_alignment = "left", T.spacer { height = 120 }},
  	                                        T.column { horizontal_alignment = "center", vertical_alignment = "top", T.label { wrap = true, characters_per_line = 66, id = "the_pool_description"}}
  	                                  },
  	                             }}},
  	   T.row { T.column { T.drawing { id = "bottom_line", width = 540, height = 30, T.draw {    
  	                      T.line { x1 = 40, y1 = 15, x2 = 500, y2 = 15, color = "255,255,255,155", thickness = 3}, T.text { font_size = 1 }
  	                      }}}},
           T.row { T.column { T.grid {
			           T.row { 
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.label { id = "the_sell_title"}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_ti"}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.label { id = "the_pool_title"}}
	           			  },
			           T.row { 
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "left" , T.label { id = "the_sell_total"}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_to"}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "left" , T.label { id = "the_pool_total"}}
	           			  },
			           T.row { 
			           	        T.column { border = "all", border_size = 5, T.button { tooltip = "Clear purchases, no transaction", id = "reset_button", label = _"Reset", return_value = 4 } },
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_bt"}},
			           	        T.column { border = "all", border_size = 5, T.button { tooltip = _ "Select item to sell", id = "select_button", label = _"Select", return_value = 3 } }
	           			  },
			           T.row { 
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "left" , T.listbox { --[[vertical_scrollbar_mode = "always",]] id = "the_sell_list", item_list_content()}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_it"}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "left" , T.listbox { --[[vertical_scrollbar_mode = "always",]] id = "the_pool_list", item_list_content()}}
	           			  },
			           T.row { 
			           	        T.column { border = "all", border_size = 5, T.button { tooltip = _"Commit exchange of gold for purchases", id = "sell_button", label = _"Sell", return_value = 2} },
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_bt2"}},
			           	        T.column { border = "all", border_size = 5, T.button { tooltip = _"Exit this dialog, no transactions", id = "cancel", label = _"Cancel"} }
	           			  }
	          		     }}}
--  	   T.row { T.column {  T.button { id = "ok", label = _"Done" }}},
	   }
}
-- local last_selected_sell_index = 1
-- local last_selected_pool_index = 1

local function preshow(dialog)
    wesnoth.set_dialog_active(false, "sell_button")
    wesnoth.set_dialog_active(false, "reset_button")
    wesnoth.set_dialog_markup(true, "the_title")
    wesnoth.set_dialog_value("<span size='xx-large' color='#eeffb7'> Selling Inventory </span>" , "the_title")
    wesnoth.set_dialog_value("portraits/merchant-female.png~SCALE(250,250)~CROP(0,0,250,200)" , "the_image")
    wesnoth.set_dialog_markup(true, "the_sell_title")
    wesnoth.set_dialog_value("<span size='large' color='#eeffb7' underline='single'> Offering to Merchant </span>" , "the_sell_title")
    wesnoth.set_dialog_markup(true, "the_pool_title")
    wesnoth.set_dialog_value("<span size='large' color='#ddeea6' underline='single'> Inventory </span>" , "the_pool_title")
    local gear_text = {}
--    sell_value = 0
-- if there is no list, build it
    if pool_list[1] == nil and sell_list[1] == nil then
      for j in ipairs(equipment_list.the_list) do
	local pool_id = equipment_list.the_list[j].id
	local pool_name = equipment_list.the_list[j].name
	local pool_text = equipment_list.the_list[j].text
	local pool_cost = equipment_list.the_list[j].cost
	local pool_image = equipment_list.the_list[j].image
	local sell_cost = equipment_list.the_list[j].cost * 0.5 -- is this fair?
	sell_cost = math.floor(sell_cost)
	local pool_number = wesnoth.get_variable("gear_pool[0]."..pool_id)
	if pool_number == nil then pool_number = 0 end
	if pool_number > 0 then
		table.insert(pool_list,{id=pool_id, name=pool_name, cost=pool_cost, number=pool_number, image=pool_image, text=pool_text})
    	        table.insert(sell_list,{id=pool_id, name=pool_name, cost=sell_cost, number=0, image=pool_image})
		local pc2 = pool_cost * pool_number
	        pool_value = pool_value + pc2
	end
      end

    end
-- if there is still no list, set to empty -- moved outside the above if
      if pool_list[1] == nil then table.insert(pool_list,{ id= "empty" , name= "Empty", cost= 0 , number= 0, image=blank_icon, text="Nothing available."}) end
      if sell_list[1] == nil then 
        table.insert(sell_list,{ id= "empty" , name= "Empty", cost= 0 , number= 0, image=blank_icon}) 
      end
-- for the pool_list and sell_list, fill in dialog widgets values
    local p_i = 1
    local s_i = 1
    for i in ipairs(pool_list) do
	if pool_list[i].number > 0 then
	     wesnoth.set_dialog_value(pool_list[i].image.."~SCALE(30,30)", "the_pool_list", p_i, "item_image")
	     wesnoth.set_dialog_value(string.format("<span size='x-small'> %s ( %d ) </span>", pool_list[i].name, pool_list[i].number), "the_pool_list", p_i, "item_id")
	     wesnoth.set_dialog_markup(true, "the_pool_list", p_i, "item_id")
	     wesnoth.set_dialog_value(string.format("<span size='x-small' color='#f1ff54'>%d g </span>", pool_list[i].cost), "the_pool_list", p_i, "item_cost")
	     wesnoth.set_dialog_markup(true, "the_pool_list", p_i, "item_cost")
	     gear_text[p_i] = string.format("<span size='small'> %s </span>", pool_list[i].text)
	     p_i = p_i + 1
--	     pool_value = pool_value + pool_list[i].cost
	end
    end
    for i in ipairs(sell_list) do
	if sell_list[i].number > 0 then
	     wesnoth.set_dialog_value(sell_list[i].image.."~SCALE(30,30)", "the_sell_list", s_i, "item_image")
	     wesnoth.set_dialog_value(string.format("<span size='x-small'> %s ( %d ) </span>", sell_list[i].name, sell_list[i].number), "the_sell_list", s_i, "item_id")
	     wesnoth.set_dialog_markup(true, "the_sell_list", s_i, "item_id")
	     wesnoth.set_dialog_value(string.format("<span size='x-small' color='#f1ff54'> %d g </span>", sell_list[i].cost), "the_sell_list", s_i, "item_cost")
--	     testy = wesnoth.get_dialog_value("the_sell_list", s_i, "item_cost")
--             wesnoth.message(string.format("testy = %s", testy))
	     wesnoth.set_dialog_markup(true, "the_sell_list", s_i, "item_cost")
	     s_i = s_i + 1
--	     sell_value = sell_value + sell_list[i].cost
	end
    end
    if li > 0 then
        wesnoth.set_dialog_value(li,"the_pool_list")
    else
        wesnoth.set_dialog_value(1, "the_pool_list")
    end
    wesnoth.set_dialog_markup(true, "the_sell_total")
    wesnoth.set_dialog_value(string.format("<span size='large' color='#ccccaa'> %d gold</span>", sell_value), "the_sell_total")
    wesnoth.set_dialog_markup(true, "the_pool_total")
    wesnoth.set_dialog_value(string.format("<span size='large' color='#ccccaa'> %d gold</span>", pool_value), "the_pool_total")

   -- end
    if pool_list[1].id == "empty" then
	    wesnoth.set_dialog_active(false, "select_button")
    end                                    
--    wesnoth.message(string.format("sell value = %d, for button eval", sell_value))
    if sell_value >= 1 then
	    wesnoth.set_dialog_active(true, "reset_button")
	    wesnoth.set_dialog_active(true, "sell_button")
    end                                    

    local function select()
        -- so, index [i] is refering to the item selected
    	local i = wesnoth.get_dialog_value "the_pool_list"
        wesnoth.set_dialog_markup(true, "the_pool_description")
        if gear_text[i] then
        else
        	gear_text[i] = "Nothing available."
        end
        wesnoth.set_dialog_value(gear_text[i], "the_pool_description")
    end
    wesnoth.set_dialog_callback(select, "the_pool_list")
    select()                                                                                   

end

local function postshow(dialog)
    li = wesnoth.get_dialog_value "the_pool_list"
--[[ this does not work, and I can't find examples
--    local tpl_id = wesnoth.get_dialog_value("the_pool_list", li, "item_id") 
    if #sell_list > 0 then
--        local i = 1        
        for i = 1,#sell_list,1 do
            local tsl_id = wesnoth.get_dialog_value("the_sell_list", i, "item_id") 
            if tsli == tpli then
                sli = wesnoth.get_dialog_value "the_sell_list"
                break
            end
        end
    end]]
end

local function selected(i)
--    local cost_sell = pool_list[i].cost * 0.5
    for j in ipairs(sell_list) do
	if pool_list[i].id == sell_list[j].id then
--    wesnoth.message(string.format("sell value = %d", sell_value))
--	  if sell_list[j].number == 0 then 
--	    sell_list[j].number = 1
--	  else
	    sell_list[j].number = sell_list[j].number + 1
	    sell_value = sell_value + sell_list[j].cost
	    pool_value = pool_value - pool_list[i].cost
--    wesnoth.message(string.format("sell value = %d", sell_value))
--	  end
--	  sell_list[j].cost = cost_sell
	    break
	end
    end
    if sell_list[1].id == "empty" then table.remove(sell_list,1) end
    pool_list[i].number = pool_list[i].number - 1
    if pool_list[i].number == 0 then 
--      wesnoth.message(string.format("Now %s is gone", pool_list[i].name))
      table.remove(pool_list,i) 
    end
    
end

local function reset_list()
    pool_list = {}
    sell_list = {}
    pool_value = 0
    sell_value = 0
end

local function sell()
    for i in ipairs(sell_list) do
	while sell_list[i].number > 0 do
           bmr_equipment.pool_remove(sell_list[i].id)
	   sell_list[i].number = sell_list[i].number - 1
	end
    end
    wesnoth.fire("gold", { amount=sell_value, side = side_number})    
--    wesnoth.message(string.format("sell value = %d", sell_value))
--    wesnoth.message(string.format("side number = %d", side_number))
    pool_list = {}
    sell_list = {}
end

local rv = gui.show_dialog(sell_dialog, preshow, postshow)
-- local rv = wesnoth.show_dialog(dialog, preshow, postshow)
  while rv >= 3 do
--select or reset, update lists, redraw 
	  if rv == 3 then
	    selected(li) 
	  elseif rv == 4 then
	    reset_list()
	  end
  	  rv = wesnoth.show_dialog(sell_dialog, preshow, postshow)
  end
  if rv == 2 then
-- sell
  sell()
  end
end
return Trader_Menus
