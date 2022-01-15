item_types = {
  Helmet = {
    Cloth = {
      level = 1,
      armor = {
        impact = 10,
      },
      image = "icons/cloak_leather_brown.png",
      ground_icon = "items/fur_hat.png",
      category = "cloth",
      type = "armor",
      value = 6,
    },
    Leather = {
      level = 1,
      armor = {
        impact = 5,
        pierce = 10,
        blade = 10,
      },
      image = "icons/helmet_leather-cap.png",
      ground_icon = "items/coif.png",
      category = "light",
      type = "armor",
      value = 8,
    },
    Bronze = {
      level = 1,
      armor = {
        pierce = 15,
        blade = 15,
      },
      image = "icons/helmet_conical.png",
      ground_icon = "items/helmet_rusty.png",
      category = "heavy",
      type = "armor",
      value = 10,
    },
  },
  Armor = {
    Cloth = {
      level = 1,
      armor = {
        impact = 5,
        pierce = 10,
        blade = 10,
      },
      image = "icons/dress_silk_green.png",
      ground_icon = "items/brigandine_vest.png",
      category = "cloth",
      type = "armor",
      value = 15,
    },
    Leather = {
      level = 1,
      armor = {
        impact = 10,
        pierce = 10,
        blade = 10,
      },
      image = "icons/armor_leather.png",
      ground_icon = "items/leather_vest.png",
      category = "light",
      type = "armor",
      value = 18,
    },
    Bronze = {
      level = 1,
      armor = {
        pierce = 20,
        blade = 20,
      },
      image = "icons/cuirass_muscled.png",
      ground_icon = "items/breastplate.png",
      category = "heavy",
      type = "armor",
      value = 20,
    },
    Studded = {
      level = 5,
      armor = {
        impact = 15,
        pierce = 15,
        blade = 15,
      },
      image = "icons/cuirass_leather_studded.png",
      ground_icon = "items/armor-leather.png",
      category = "light",
      type = "armor",
      value = 32,
    },
  },
  Sword = {
    Bronze = {
      image = "attacks/sword-human-short.png",
      ground_icon = "items/sword-short.png",
      level = 1,
      melee_damage = "20%",
      category = "blade",
      type = "melee_weapon",
      value = 11,
    },
  },
  Bow = {
    Short = {
      image = "attacks/bow.png",
      ground_icon = "items/bow.png",
      level = 1,
      ranged_damage = "25%",
      category = "bow",
      type = "ranged_weapon",
      value = 14,
    },
  },
  Crossbow = {
    Crude = {
      image = "attacks/crossbow-undead.png",
      ground_icon = "items/crossbow.png",
      level = 3,
      ranged_damage = "33%",
      category = "crossbow",
      type = "ranged_weapon",
      value = 22,
    },
  },
  Dagger = {
    Crude = {
      image = "attacks/dagger-undead.png",
      ground_icon = "items/dagger.png",
      level = 1,
      melee_damage = "15%",
      category = "dagger",
      type = "melee_weapon",
      value = 15,
    },
  },
  Staff = {
    Novice = {
      image = "attacks/staff-green.png",
      ground_icon = "items/staff-plain.png",
      level = 3,
      melee_damage = "1",
      magic_damage = "15%",
      category = "staff",
      type = "melee_weapon",
      value = 18,
    },
  },
}

modifiers = {
  armor = {
    Healthy = {
      name = "Healthy",
      hitpoints = 6,
    },
  },
}

item_cache = {}