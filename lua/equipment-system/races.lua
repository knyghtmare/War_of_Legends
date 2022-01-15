racial_skills = {
  Elvish = {
    allow_categories = {"bow"},
    disallow_categories = {"blunt"},
  },
  Human = {
    allow_categories = {"crossbow"},
    disallow_categories = {}, -- No weaknesses but less strengths, easiest to play
  },
  Orcish = {
    allow_categories = {"blade"}, -- Even mages can use swords
    disallow_categories = {"polearm"}, -- Spears are for goblins
  },
}

class_skills = {
  Flagbearer = {
    categories = {"cloth", "light", "heavy", "blade", "bow", "polearm", "blunt", "crossbow"},
  },
  Vagabond = {
    categories = {"cloth", "light", "blade", "dagger", "thrown"},
  },
  Ranger = {
    categories = {"cloth", "light", "dagger", "bow", "crossbow"},
  },
  Mage = {
    categories = {"cloth", "staff", "magical"},
  },
}