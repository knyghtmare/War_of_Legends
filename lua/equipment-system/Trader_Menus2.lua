--[[

This is for the dialog when buying equipment from the merchant
It is derived from the seller menu, so there may be some backwards naming instances

]]

Trader_Menus.buyer = function(side_number,list_id)
local function item_list_content()
      return T.list_definition { T.row { T.column { horizontal_grow = true, T.toggle_panel { T.grid {
      			T.row { 
      				T.column { grow_factor = 0, T.label { id = "item_number" }}
      				}, 
      			T.row { 
      				T.column { T.image { id = "item_image" }}
      				}, 
      			T.row { 
      				T.column { horizontal_grow = true, T.label { id = "item_id" }}
      				}, 
      			T.row {	
      				T.column { T.label { id = "item_cost" }}
      				} 
				}}}}}
end
local function inventory_content()
      return T.grid { linked_group = "inventory",
-- failed attempts to control layout and scrollbar usage   linked_group has an effect, but places no limits
--   			T.row { T.column { growth_factor = 1, border = "all", border_size = 1, T.spacer { id = "i_t_spacer"}}},
--      			T.row { T.column { border = "all", border_size = 3, T.scroll_label {wrap = true, id = "the_pool_list"}}}
      			T.row { T.column { border = "all", border_size = 3, T.label { id = "the_pool_title"}}},
      			T.row { T.column { border = "all", border_size = 3, T.scroll_label {vertical_scrollbar_mode = "always", wrap = true, id = "the_pool_list"}}}
		}
end
local function gold_content()
      return T.grid { linked_group = "inventory",
      			T.row { T.column { border = "all", border_size = 3, T.label { id = "the_sell_total"}}},
      			T.row { T.column { border = "all", border_size = 3, T.label { id = "the_pool_total"}}}
		}
end
--[[
local function image_list_content() -- tried to use T.tree_view to make an image that looked like the listbox (I don't want it to look clickable/selectable)
--      return T.node { id = "pl_node", T.node_definition { T.row { T.column { horizontal_grow = true, T.toggle_panel { T.grid {
      return T.definition { T.row { T.column { T.grid { -- then tried to use scollbar_panel, but it caused crash
      			T.row { 
      				T.column { T.image { id = "item_image" }}, 
      				T.column { T.label { id = "item_number" }} 
      				},
      			T.row { 
      				T.column { horizontal_grow = true, T.label { id = "item_id" }}, 
      				T.column { T.label { id = "item_cost" }} 
      				}
				}}}}
end]]

local blank_icon ="misc/blank-hex.png~SCALE(40,40)"
local pool_list = {}
local sell_list = {} 
local sell_list_short = {}
-- had to make the lists smaller for sizing issues at smaller resolutions
if list_id == 1 then
  sell_list_short = {"cap_helmet", "wooden_shield", "kidney_belt", "stone_ring", "leather_armor", "elven_tunic", "boot_cleat", "small_dagger"}
-- for testing
--  sell_list_short = {"fur_hat", "cap_helmet", "steel_greaves", "wooden_shield", "fur_cloak", "stone_ring", "leather_armor", "elven_tunic", "boot_cleat", "small_dagger", "steel_blade", "holy_charm", "orc_dagger"}
elseif list_id == 2 then
  sell_list_short = {"chain_helmet", "light_helmet", "leather_gloves", "steel_ring", "leather_vambrace", "scale_armor", "leather_boots", "steel_spear"}
--  sell_list_short = {"chain_helmet", "light_helmet", "wooden_shield", "fur_cloak", "steel_ring", "leather_armor", "scale_armor", "leather_boots", "steel_spear"}
elseif list_id == 21 then
  sell_list_short = {"light_helmet", "white_gloves", "steel_ring", "elf_cloak", "scale_armor", "miner_boots", "leather_boots", "steel_arrows"}
--  sell_list_short = {"chain_helmet", "light_helmet", "wooden_shield", "fur_cloak", "steel_ring", "leather_armor", "scale_armor", "leather_boots", "steel_spear"}
elseif list_id == 3 then
  sell_list_short = {"steel_helmet", "iron_shield", "iron_vambrace", "chain_armor", "scale_armor", "steel_arrows", "steel_axe", "steel_blade"}
--  sell_list_short = {"steel_helmet", "iron_shield", "fur_cloak", "steel_ring", "chain_armor", "scale_armor", "steel_arrows", "steel_axe", "steel_blade"}
elseif list_id == 4 then
  sell_list_short = {"crested_helmet", "atlas_belt", "iron_shield", "steel_greaves", "gold_ring", "breastplate", "steel_arrows", "silver_dagger", "steel_blade"}
--  sell_list_short = {"crested_helmet", "iron_shield", "steel_greaves", "steel_ring", "gold_ring", "breastplate", "scale_armor", "steel_arrows", "silver_dagger", "steel_blade"}
elseif list_id == 5 then
  sell_list_short = {"bascinet_helmet", "door_shield", "atlas_belt", "elf_cloak", "gold_ring", "chain_armor", "silver_dagger", "steel_axe", "steel_spear"}
--  sell_list_short = {"bascinet_helmet", "door_shield", "elf_cloak", "gold_ring", "breastplate", "chain_armor", "steel_arrows", "silver_dagger", "steel_blade", "steel_axe", "steel_spear"}
else
  sell_list_short = {"fur_hat", "cap_helmet", "wooden_shield", "fur_cloak", "stone_ring", "leather_armor", "small_dagger"}
end
local li = 0
local pool_value = 0
local sell_value = 0
local dialog = {
  T.tooltip { id = "tooltip_large" },
  T.helptip { id = "helptip_large" },
  maximum_height = 800, maximum_width = 800,                                               
  --automatic_placement = false,
  --height = 850, width = 700,                                               
  T.linked_group { id = "inventory", fixed_width = false, fixed_height = true }, -- not useful
  T.linked_group { id = "item_list_group", fixed_width = false, fixed_height = true }, -- not useful
  T.grid { 
  	   T.row { T.column { T.label { id = "the_title"}}},
  	   T.row { T.column { T.image { id = "the_image"}}},
  	   T.row { T.column { T.drawing { id = "top_line", width = 540, height = 30, T.draw {    
  	                      T.line { x1 = 40, y1 = 15, x2 = 500, y2 = 15, color = "255,255,255,255", thickness = 3}, T.text { font_size = 1 }
  	                      }}}},
  	   T.row { T.column { T.grid {
  	                           T.row {      
  	                                        T.column { horizontal_alignment = "left", T.spacer { height = 84 }},
  	                                        T.column { horizontal_alignment = "left", vertical_alignment = "top", T.label { wrap = true, characters_per_line = 66, id = "the_pool_description"}}
  	                                  }
  	                    }}},
  	   T.row { T.column { T.drawing { id = "bottom_line", width = 540, height = 30, T.draw {    
  	                      T.line { x1 = 40, y1 = 15, x2 = 500, y2 = 15, color = "255,255,255,155", thickness = 3}, T.text { font_size = 1 }
  	                      }}}},
 	   T.row { T.column { border = "all", border_size = 5, horizontal_alignment = "center" , T.label { id = "the_sell_title"}}},
	   T.row { T.column { T.grid {
	   			   T.row { 
	   			   		T.column { border = "top", border_size = 20, T.spacer { id = "spacer_itemlistcontent", linked_group = "item_list_group"}}, --not useful
	   			   		T.column { border = "all", border_size = 5, horizontal_alignment = "center" , 
	   			   				T.horizontal_listbox { horizontal_scrollbar_mode = "never", vertical_scrollbar_mode = "never", id = "the_sell_list", linked_group = "item_list_group", item_list_content()}
	   			   				}
	   			   	}
				}}},
           T.row { T.column { T.grid {
--[[			           T.row { 
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_ti"}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.label { id = "the_sell_title"}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_ti"}}
	           			  },]]
--[[			           T.row { 
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_itl"}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.horizontal_listbox { id = "the_sell_list", item_list_content()}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_itr"}}
	           			  },]]
			           T.row {
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_btl"}},
			           	        T.column {  border = "all", border_size = 5, T.button { id = "select_button", label = _"Select", return_value = 3 }},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_btr"}}
	           			  },
--[[			           T.row { 
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "left" , T.label { id = "the_sell_total"}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_to"}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "left" , T.label { id = "the_pool_total"}}
	           			  },]]
			           T.row {
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , gold_content()},
			           		T.column {  border = "top", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_co", linked_group = "inventory"}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , inventory_content()}
	           			  },
--[[			           T.row { 
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.label { id = "the_sell_title"}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.spacer { id = "spacer_ti"}},
			           		T.column {  border = "all", border_size = 5, horizontal_alignment = "center" , T.label { id = "the_pool_title"}}
	           			  },]]
			           T.row { 
			           	        T.column { border = "all", border_size = 5, T.button { id = "sell_button", label = _"Buy", return_value = 2} },
			           	        T.column { border = "all", border_size = 5, T.button { id = "reset_button", label = _"Reset", return_value = 4 } },
			           	        T.column { border = "all", border_size = 5, T.button { id = "cancel", label = _"Cancel"} }
	           			  }
	          		     }}}
--  	   T.row { T.column {  T.button { id = "ok", label = _"Done" }}},
	   }
}

local function preshow()
    local team_gold = wesnoth.sides[side_number].gold
    pool_value = team_gold
    wesnoth.set_dialog_active(false, "sell_button")
    wesnoth.set_dialog_active(false, "reset_button")
    wesnoth.set_dialog_markup(true, "the_title")
    wesnoth.set_dialog_value("<span size='xx-large' color='#eeffb7'> Merchant </span>" , "the_title")
    wesnoth.set_dialog_value("portraits/merchant-male.png~SCALE(250,250)~CROP(0,0,250,180)" , "the_image")
    wesnoth.set_dialog_markup(true, "the_sell_title")
    wesnoth.set_dialog_value("<span size='large' color='#eeffb7' underline='single'> Merchandise for Sale </span>" , "the_sell_title")
    wesnoth.set_dialog_markup(true, "the_pool_title")
    wesnoth.set_dialog_value("<span size='large' color='#ddeea6' underline='single'> Inventory </span>" , "the_pool_title")
    local gear_text = {}
    local pool_text = ""
    -- sell_list does not change, but number does need to be updated
--    wesnoth.message(string.format("sell_list[1].id is %s, before", sell_list[1].id))
    if sell_list[1] == nil then
      for i in ipairs(sell_list_short) do
        for j in ipairs(equipment_list.the_list) do
            if equipment_list.the_list[j].id == sell_list_short[i] then
                local sell_id = equipment_list.the_list[j].id
                local sell_name = equipment_list.the_list[j].name
                local sell_text = equipment_list.the_list[j].text
                local sell_image = equipment_list.the_list[j].image
                local sell_cost = equipment_list.the_list[j].cost
    	        table.insert(sell_list,{id=sell_id, name=sell_name, cost=sell_cost, image=sell_image, text=sell_text, number=0})
	    end
	end
      end
    end
--    wesnoth.message(string.format("sell_list_[1].id is %s, after", sell_list[1].id)) --this was successful
-- pool list also does not change, until reshow
    if #pool_list < 2 then
      for j in ipairs(equipment_list.the_list) do
	local pool_id = equipment_list.the_list[j].id
	local pool_number = wesnoth.get_variable("gear_pool[0]."..pool_id)
	if pool_number == nil then pool_number = 0 end
	if pool_number > 0 then	
	  local pool_name = equipment_list.the_list[j].name
	  local pool_image = equipment_list.the_list[j].image
	  table.insert(pool_list,{id=pool_id, name=pool_name, number=pool_number, image=pool_image})
	end
      end
    end

    local p_i = 1
    local s_i = 1
-- moving p_i and pool_list below sell_list
    for i in ipairs(sell_list) do
--	if sell_list[i].number > 0 then
	     wesnoth.set_dialog_value(sell_list[i].image, "the_sell_list", s_i, "item_image")
	     wesnoth.set_dialog_value(string.format("<span size='x-small'> %s </span>", sell_list[i].name), "the_sell_list", s_i, "item_id")
	     wesnoth.set_dialog_markup(true, "the_sell_list", s_i, "item_id")
	     wesnoth.set_dialog_value(string.format("<span weight='bold'>  %d  </span>", sell_list[i].number), "the_sell_list", s_i, "item_number")
	     wesnoth.set_dialog_markup(true, "the_sell_list", s_i, "item_number")
	     wesnoth.set_dialog_value(string.format("<span size='x-small' color='#f1ff54'> %d g </span>", sell_list[i].cost), "the_sell_list", s_i, "item_cost")
	     wesnoth.set_dialog_markup(true, "the_sell_list", s_i, "item_cost")
	     gear_text[s_i] = string.format("<span size='small'> %s </span>", sell_list[i].text)
	     s_i = s_i + 1
--	     sell_value = sell_value + sell_list[i].cost
--	end
    end
    if li > 0 then
        wesnoth.set_dialog_value(li,"the_sell_list")
    else
        wesnoth.set_dialog_value(1, "the_sell_list")
    end
    for i in ipairs(pool_list) do
	if pool_list[i].number > 0 then
--	     wesnoth.set_dialog_value(pool_list[i].image, "the_pool_list", p_i, "item_image")
	     pool_text = pool_text..string.format("<span size='small'>\n  %s ( %d ) </span>", pool_list[i].name, pool_list[i].number)
--[[	     wesnoth.set_dialog_value(string.format("<span size='x-small'> %s </span>", pool_list[i].name), "the_pool_list", p_i, "item_id")
	     wesnoth.set_dialog_markup(true, "the_pool_list", p_i, "item_id")
	     wesnoth.set_dialog_value(string.format("<span weight='bold'> %d  </span>", pool_list[i].number), "the_pool_list", p_i, "item_number")
	     wesnoth.set_dialog_markup(true, "the_pool_list", p_i, "item_number")]]
	     --wesnoth.set_dialog_value(string.format("<span size='x-small' color='#f1ff54'>%d g </span>", pool_list[i].cost), "the_pool_list", p_i, "item_cost")
	     --wesnoth.set_dialog_markup(true, "the_pool_list", p_i, "item_cost")
	     p_i = p_i + 1
	end
    end
    wesnoth.set_dialog_value(pool_text, "the_pool_list")
    wesnoth.set_dialog_markup(true, "the_pool_list")
-- end move
    wesnoth.set_dialog_markup(true, "the_sell_total")
    wesnoth.set_dialog_value(string.format("<span size='large' color='#ccccaa'>Order Total: %d gold</span>", sell_value), "the_sell_total")
    wesnoth.set_dialog_markup(true, "the_pool_total")
    wesnoth.set_dialog_value(string.format("<span size='large' color='#ccccaa'>Gold Available: %d gold</span>", pool_value), "the_pool_total")

   -- end
--    wesnoth.message(string.format("sell value = %d, for button eval", sell_value))
    if sell_value >= 1 then
	    wesnoth.set_dialog_active(true, "reset_button")
	    wesnoth.set_dialog_active(true, "sell_button")
    end                                    
--trying to disable the selection, so pool_list box is image only    wesnoth.set_dialog_value(0, "the_pool_list")

    local function select()
        -- so, index [i] is refering to the item selected
    	local i = wesnoth.get_dialog_value "the_sell_list"
        wesnoth.set_dialog_markup(true, "the_pool_description")
        if gear_text[i] then
        else
        	gear_text[i] = "Nothing available."
        end
        wesnoth.set_dialog_value(gear_text[i], "the_pool_description")
        return
    end
    wesnoth.set_dialog_callback(select, "the_sell_list")
    select()                                                                                   

end

local function postshow()
    li = wesnoth.get_dialog_value "the_sell_list"
end

local function selected(i)

    sell_list[i].number = sell_list[i].number + 1
--[[    local sell_value_temp  = sell_list[i].number * sell_list[i].cost
    sell_value = sell_value + sell_value_temp ]]-- was I just a moron, or was there some reason for this?
    sell_value = sell_value + sell_list[i].cost
    
end

local function reset_list()
    pool_list = {}
    sell_list = {}
    sell_value = 0
end

local function sell()
    if sell_value <= pool_value then
      for i in ipairs(sell_list) do
	while sell_list[i].number > 0 do
           bmr_equipment.pool_add(sell_list[i].id)
	   sell_list[i].number = sell_list[i].number - 1
	end
      end
      sell_value = -1 * sell_value
      wesnoth.fire("gold", { amount=sell_value, side = side_number})    
    else
      wesnoth.fire("message", { speaker="Seller", message = _"What are you trying to pull?  You don't have the money for that!"})    
    end
--    wesnoth.message(string.format("sell value = %d", sell_value))
--    wesnoth.message(string.format("side number = %d", side_number))
    pool_list = {}
    sell_list = {}
    sell_value = 0
end

local rv = wesnoth.show_dialog(dialog, preshow, postshow)
  while rv >= 3 do
--select or reset, update lists, redraw 
	  if rv == 3 then
	    selected(li) 
	  elseif rv == 4 then
	    reset_list()
	  end
  	  rv = wesnoth.show_dialog(dialog, preshow, postshow)
  end
  if rv == 2 then
-- sell
  sell()
  end
end
return Trader_Menus
