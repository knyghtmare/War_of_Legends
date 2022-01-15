quest_list = {
  mainquest1 = {
    name = "Reach Mortimer", 
    text = "We were stopped on the docks south of Mortimer by a group who calls themselves the Mortimer Wood Bandits. They seem to have a tight control over the region. We have to find out more about them from the townsfolk in Mortimer, if that town still exists...",
    text_completed = "We were stopped on the docks south of Mortimer by a group who calls themselves the Mortimer Wood Bandits. After pushing through them we reached Mortimer, where we met with the remaining townsfolk.",
    image = "units/human-outlaws/rogue.png",
    objectives = {
      start = "Get to Mortimer",
    },
  },
}

function wesnoth.wml_actions.show_quest_list(cfg) 
  local out = {speaker = "narrator", message = "Quest: ", variable = "chosen_quest"}

  local active_quests = {}
  local completed_quests = {}

  table.insert(out, T["option"] {label = "Close quest list.", value = "exit"})

  for k,v in pairs(quest_list) do
    if vars[k] == "completed" then
      completed_quests[k] = v
    elseif vars[k] ~= nil then
      active_quests[k] = v
    end
  end

  for k,v in pairs(active_quests) do
    local option = T["option"] {label = v.name, value = k, image = v.image, description = "Current objective: " .. v.objectives[vars[k]]}
    table.insert(out, option)
  end

  for i,v in ipairs(completed_quests) do
    local option = T["option"] {label = v.name .. " (COMPLETED)", value = k, image = v.image}
    table.insert(out, option)
  end

  wesnoth.wml_actions.message(out)

  if vars["chosen_quest"] ~= "exit" then
    local quest = quest_list[vars["chosen_quest"]]

    local wml_values = {speaker = "narrator", caption = quest.name}
    if vars[vars["chosen_quest"]] == "completed" then
      wml_values.caption = wml_values.caption .. " (COMPLETED)"
      wml_values.message = quest.text_completed
    else
      wml_values.message = quest.text
    end

    wesnoth.wml_actions.message(wml_values)
  end
end