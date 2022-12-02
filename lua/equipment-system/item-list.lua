item_types = {
  Helmet = {
    Cloth = {
      level = 1,
      armor = {
        impact = 10,
      },
      image = "icons/cloak_leather_brown.png",
      ground_icon = "items/fur_hat.png",
      category = "light",
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
      category = "medium",
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
      category = "light",
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
      category = "medium",
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
      category = "medium",
      type = "armor",
      value = 32,
    },
  },
  Ring = {
    Gold = {
      image = "icons/ring_gold.png",
      ground_icon = "items/ring-gold.png",
      level = 2,
      ranged_damage = "10%",
      category = "ring",
      type = "ranged_buff",
      value = 22,
    },
    Uncommon = {
      image = "icons/skull_ring.png",
      ground_icon = "items/ring-brown.png",
      level = 2,
      melee_damage = "10%",
      category = "ring",
      type = "melee_buff",
      value = 22,
    },
  },
  Amulet = {
    Ankh = {
      image = "icons/ankh_necklace.png",
      ground_icon = "items/ankh-necklace.png",
      level = 2,
      ranged_damage = "10%",
      category = "amulet",
      type = "ranged_buff",
      value = 22,
    },
    Jade = {
      image = "icons/jewelry_butterfly_pin.png",
      ground_icon = "items/rock.png",
      level = 2,
      melee_damage = "10%",
      category = "amulet",
      type = "melee_buff",
      value = 22,
    },
  },
}

modifiers = {
  armor = {
    Refined = {
      name = "Refined",
      hitpoints = 6,
    },
    Augmented = {
      name = "Augmented",
      hitpoints = 12,
    },
    Ascended = {
      name = "Ascended",
      hitpoints = 18,
    },
    Legendary = {
      name = "Legendary",
      hitpoints = 24,
    },
  },
}

item_cache = {}