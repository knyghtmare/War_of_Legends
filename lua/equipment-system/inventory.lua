-- Placeholder inventory. TODO: custom UI
inventory = {}

function wesnoth.wml_actions.show_inventory(cfg)
  local out = {speaker = "narrator", message = "Items: ", variable = "chosen_item"}

  table.insert(out, T["option"] {label = "Close the inventory.", value = "exit"})

  for k,v in ipairs(inventory) do
    local item = get_item(v)

    local option = T["option"] {label = item.name, value = item.id, image = item.image, description = generate_description(item)}
    table.insert(out, option)
  end

  wesnoth.wml_actions.message(out)

  if vars["chosen_item"] ~= "exit" then
    local unit = wesnoth.units.find_on_map(cfg)[1]
    local item = get_item(vars["chosen_item"])

    if not can_equip(unit, item) then
      wesnoth.wml_actions.message{speaker = "narrator", message = "This item cannot be equipped. Either this unit does not have the necessary skill, or this unit already has an item equipped in this slot."}
      return
    end

    apply_item(item, {x = unit.x, y = unit.y})
    for i,v in ipairs(inventory) do
      if v == vars["chosen_item"] then
        table.remove(inventory, i, 1)
        break
      end
    end
  end
end

function can_equip(unit, item)
  local type_parts = mysplit(unit.type, " ")
  local unit_race = unit.race
  local categories = deepcopy(armor_criteria[unit_race].categories)
  for i,category in ipairs(race_specifics[unit.race].allow_categories) do
    table.insert(categories, category)
  end
  for i,category in ipairs(race_specifics[unit.race].disallow_categories) do
    for j,allowed in ipairs(categories) do
      if allowed == category then
        table.remove(categories, j)
        j = j - 1
      end
    end
  end

  local can_equip = false

  for j,allowed in ipairs(categories) do
    if allowed == item.category then
      can_equip = true
      break
    end
  end

  if not can_equip then
    return false
  end

  local equipped = get_equipped(unit)

  local type = mysplit(item.id, "_")[2]

  for k,v in ipairs(equipped) do
    if type == mysplit(v, "_")[2] then
      return false
    end
  end

  return true
end

function get_equipped(unit)
  local items = {}

  for obj in wml.child_range(wml.get_child(unit.__cfg, "modifications"), "object") do
    table.insert(items, obj.id)
  end

  return items
end

function wesnoth.wml_actions.show_equipped(cfg)
  local unit = wesnoth.units.find_on_map(cfg)[1]

  local out = {speaker = unit.id, message = "Equipped. Select an item to unequip and return it to the inventory: ", variable = "chosen_item"}

  for k,v in ipairs(get_equipped(unit)) do
    local item = get_item(v)

    local option = T["option"] {label = item.name, value = item.id, image = item.image, description = generate_description(item)}
    table.insert(out, option)
  end

  table.insert(out, T["option"] {label = "Close this screen.", value = "exit"})

  wesnoth.wml_actions.message(out)

  if vars["chosen_item"] ~= "exit" then
    local unit = wesnoth.units.find_on_map(cfg)[1]
    local item = get_item(vars["chosen_item"])

    wesnoth.wml_actions.remove_object{x = unit.x, y = unit.y, object_id = vars["chosen_item"]}
    table.insert(inventory, vars["chosen_item"])
    wesnoth.wml_actions.message{speaker = "narrator", message = "Item unequipped"}
  end
end

function wesnoth.wml_actions.show_pickup_dialog(cfg)
  local item = get_item(cfg.id)
  local unit = wesnoth.units.find_on_map{x = cfg.x, y = cfg.y}[1]
  local caption = "On the ground you find: " .. item.name

  if not can_equip(unit, item) then
    caption = caption .. "<span color=\"red\">" .. " (This unit cannot use: " .. item.category .. ")" .. "</span>"
  end

  local out = {speaker = "narrator", caption = "On the ground you find a " .. item.name, message = generate_description(item), image = item.image, variable = "choice_taken"}

  if can_equip(unit, item) then
    table.insert(out, T["option"] {label = "Equip the item.", value = "equip"})
  end

  table.insert(out, T["option"] {label = "Store the item.", value = "store"})
  table.insert(out, T["option"] {label = "Leave it on the ground.", value = "exit"})

  wesnoth.wml_actions.message(out)

  if vars["choice_taken"] ~= "exit" then
    if vars["choice_taken"] == "equip" then
      if not can_equip(unit, item) then
        wesnoth.wml_actions.message{speaker = "narrator", message = "This item can't be equipped"}
        return
      end
  
      print(unit.x, unit.y, item.id)
      apply_item(item, {x = unit.x, y = unit.y})
    else
      table.insert(inventory, item.id)
    end

    wesnoth.wml_actions.remove_item{x = unit.x, y = unit.y}

    wesnoth.wml_actions.remove_event{id = "itemdrop" .. unit.x .. unit.y .. item.id}
  end
end