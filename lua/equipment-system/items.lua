local object = wesnoth.wml_actions.object

ground_items = {}

function get_generic_item(material, item, mod)
  local id = to_id(material, item, mod)

  return get_item(id)
end

function get_item(id)
  local entry

  if item_cache[id] ~= nil then
    entry = item_cache[id]
  else
    local split = mysplit(id, "_")
    entry = deepcopy(item_types[split[2]][split[1]])
    item_cache[id] = entry

    entry.id = id
    entry.name = split[1] .. " " .. split[2]

    if split[3] then
      apply_modifier(entry, deepcopy(modifiers[entry.type][split[3]]))
    end
  end

  return entry
end

function generate_generic_item(level, rare_modifier)
  local items = {}

  for category,v in pairs(item_types) do
    for material,item in pairs(v) do
      if item.level > level - 5 and item.level < level + 5 then
        local id = to_id(material, category)
        table.insert(items, id)
      end
    end
  end

  local type = mathx.random_choice(items)
  local item = get_item(type)

  local mod = 1
  if rare_modifier then
    mod = rare_modifier
  end

  if modifiers[item.type] and mathx.random() < (0.2 * mod) then
    local mods = {}
    for modid,_ in pairs(modifiers[item.type]) do
      table.insert(mods, modid)
    end
    type = type .. "_" .. mathx.random_choice(mods)
    item = get_item(type)
  end

  return item
end

function apply_modifier(item, mod)
  for k,v in pairs(mod) do
    if k ~= "name" then
      item[k] = mod[k]
    end
  end

  item.name = mod.name .. " " .. item.name
end

function generate_description(item)
  local parts = {}

  -- Damage
  if item.melee_damage then
    table.insert(parts, item.melee_damage .. " melee damage")
  end
  if item.ranged_damage then
    table.insert(parts, item.ranged_damage .. " ranged damage")
  end
  if item.magic_damage then
    table.insert(parts, item.magic_damage .. " magic damage")
  end

  -- Armor
  if item.armor then
    for k,v in pairs(item.armor) do
      table.insert(parts, v .. "% " .. k .. " resist")
    end
  end

  -- HP
  if item.hitpoints then
    table.insert(parts, item.hitpoints .. " hitpoints")
  end

  return "(" .. table.concat(parts, ", ") .. ") Value: " .. item.value
end

function generate_effects(item)
  local effects = {}

  -- Damage
  if item.melee_damage then
    table.insert(effects, T["effect"] {apply_to = "attack", range = "melee", increase_damage = item.melee_damage})
  end
  if item.ranged_damage then
    table.insert(effects, T["effect"] {apply_to = "attack", T["not"] {special_id = "magical"}, range = "ranged", increase_damage = item.ranged_damage})
  end
  if item.magic_damage then
    table.insert(effects, T["effect"] {apply_to = "attack", special_id = "magical", range = "ranged", increase_damage = item.magic_damage})
  end

  -- Armor
  if item.armor then
    local armor = {}
    for k,v in pairs(item.armor) do
      armor[k] = tostring(-1 * v)
    end
    table.insert(effects, T["effect"] {apply_to = "resistance", replace = "no", T["resistance"] (armor)})
  end

  -- HP
  if item.hitpoints then
    table.insert(effects, T["effect"] {apply_to = "hitpoints", increase_total = item.hitpoints, heal_full = "yes"})
  end

  -- Name and description if it's a weapon
  if item.type == "melee_weapon" then
    table.insert(effects, T["effect"] {apply_to = "attack", range = "melee", set_description = item.name, set_icon = item.image})
  end
  if item.type == "ranged_weapon" then
    table.insert(effects, T["effect"] {apply_to = "attack", range = "ranged", T["not"] {special_id = "magical"}, set_description = item.name, set_icon = item.image})
  end
  
  return effects
end

function apply_item(item, filter)
  local effects = generate_effects(item)

  if filter.x == nil then
    x = table.insert(nil, nil)
  end

  local wml_obj = {T["filter"] { x = filter.x, y = filter.y }, silent = "no", id = item.id, name = item.name, image = item.image, duration = "forever", description = item.description}
  
  for k,v in ipairs(effects) do
    table.insert(wml_obj, v)
 end 

  object(wml_obj)
end

function drop_item(item, x, y)
  wesnoth.wml_actions.item({
    x = x,
    y = y,
    image = item.ground_icon,
  })

  add_event({
    name = "moveto",
    first_time_only = "no",
    id = "itemdrop" .. x .. y .. item.id,
    T["filter"] {
      x = x, y = y, side = 1,
    },
    T["show_pickup_dialog"] {
      x = x, y = y, id = item.id,
    },
  })
end

function wesnoth.wml_actions.random_drop(cfg)
  local unit = wesnoth.units.find_on_map(cfg)[1]
  local level, x, y
  local rare_modifier = 1

  if unit then
    level = unit.level
    x = unit.x
    y = unit.y

    if unit.role == "elite" then
      rare_modifier = 5
    end
  else
    level = cfg.level
    x = cfg.x
    y = cfg.y
  end

  drop_item(generate_generic_item(level, rare_modifier), x, y)
end