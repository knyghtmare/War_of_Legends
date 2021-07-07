-- #textdomain "wesnoth-Bad_Moon_Rising"
local _ = wesnoth.textdomain "wesnoth-Bad_Moon_Rising"
local equipment_list = {}
local the_list = {}
--local the_filter = {}
local list_usage = {}
equipment_list.the_list = the_list
--equipment_list.the_filter = the_filter
equipment_list.list_by_name = {}
equipment_list.list_usage = list_usage

table.insert(list_usage, {
    types = {
    "Walking Corpse", "Soulless", "Skeleton",
    "Archaic_Goblin", "Frost Goblin", "Goblin Impaler",
    "Ukian Runner", "Ukian Courrier", "Ukian Commando", 
    "Orcish Slinger", "Orcish Hunter", "Orcish Stalker", "Orcish Drifter", "Orcish Wanderer", "Orcish Vagrant", "Orcish Vagrant2", "Orcish Traveler", "Ukian Seeress", "Ukian Witch", 
    "Ukian Regular", "Ukian Veteran", "Ukian Signalman", "Ukian Subcommander", "Ukian Commander", "Ukian Flareman", "Ukian Officer", "Belleros", "Belleros_Officer", 
    "Orcish Serf", "Orcish Foreman", 
    "Orcish Overseer", "Orcish Fireline", "Orcish Firebreather", "Orcish Grunt", "Orcish Warrior", "Orcish Warrior2", "Orcish Warrior2", "Orcish Warlord", 
    "Ukian Archer", "Ukian Hawkeye", "Ukian Deadeye", "Orcish Archer", "Orcish Crossbowman", "Orcish FlameThrower",
    "Orcish Slurbow", "Orcish Rider", "Orcish Cavalry", "Orcish Destrier", "Orcish Raider", "Orcish Terror",
    "Orcish Cleverman", "Orcish RimeRunner", "Orcish SnowWalker", "Orcish IceStalker", "Great Orc", "Orcish Juggernaught",
    "Orcish Assassin", "Orcish Slayer", "Orcish Slayer2",
    "Rat Rider", "Rat Lancer", "Rat Dragoon",
    "Spearman", "Swordsman", "Pikeman" ,"Javelineer", "Royal Guard", "Halberdier", "General", "Thug", "Sergeant","Lieutenant","General",
    "Horseman", "Lancer", "Knight", "Paladin", "Grand Knight", "Cavalryman", "Dragoon", "Cavalier",
    "Heavy Infantryman","Shock Trooper","Iron Mauler",
    "Skeleton", "Revenant", "Draug", "Death Knight",
    "Skeleton Archer", "Bone Shooter", "Banebow",
    "Walking Corpse", "Soulless",
    "Wolf Rider", "Goblin Knight", "Goblin Pillager", "Direwolf Rider", 
    "Snow Wolf Rider", "Frost Wolf Rider", "Ice Wolf Rider",
    "Elvish Fighter", "Elvish Archer", "Elvish Ranger", "Elvish Hero", "Elvish Captain", "Elvish Champion", "Elvish Marshal", "Elvish Marksman", "Elvish Sharpshooter", "Elvish Avenger",
    "Bowman", "Longbowman", "Master Bowman",
    "Fencer","Duelist","Master at Arms",
    "Scarrion_Spearman", "Therion", "Russle", "Altos",
    "Thief","Rogue","Assassin",
    "Thug","Bandit","Highwayman","Resurrectionist",
    "Red Mage", "Arch Mage", "Silver Mage", "Great Mage", 
    "Northern Soldier", "Northern Fighter", "Northern Ranger", "Northern Elite",
    "Royal Spotter", "Royal Herdsman", "Royal Rider", "Royal Thrower", "Royal FireKnight",
    "Phantom Cloak", "Phantom Shadow", "Phantom Master", "Phantom Rider", "Phantom Horseman", "Phantom Dullohan", "Phantom Slayer", "Phantom Slayer2", "Phantom Spearman",
    "Phantom Widow", "Phantom Midnight", "Phantom White", "Phantom Banshee", 
    "Phantom Soldier", "Phantom Officer", "Phantom Knight", "Phantom Queen", "Phantom King",
    "Primevalist Fighter", "Primevalist Fanatic", "Primevalist Shield", "Primevalist Shield_High", "Primevalist Leader",
    "Primevalist Follower", "Primevalist Monk", "Primevalist Celebrant", "Primevalist Prior",
    "Carusoe", "Carusoe2", "Bad Raenna", "Raenna", "Dark Messiah", "Huric", "Hrala",
    "Primeval Swiftfoot", "Primeval Striker", "Primeval Slasher", "Primeval Protector", "Primeval Highguard", "Primeval Gyrepacter",
    "Primeval Slow", "Primeval Driver", "Primeval Giant",
    "Primeval Cutter", "Primeval Ironwheel", "Primeval Aerowheel", "Primeval Firewheel", "Primeval Sunwheel",
    "Primeval Dogface", "Primeval Warrior", "Primeval Titan"
    },
    usage = "all"
})
table.insert(list_usage, {
    types = {"Orcish Serf", "Orcish Foreman", "Orcish Slinger", "Orcish Hunter", "Orcish Stalker", "Orcish Drifter", "Orcish Wanderer", "Orcish Vagrant", "Orcish Traveler",  
    "Orcish Overseer", "Orcish Fireline", "Orcish Firebreather", "Orcish Grunt", "Orcish Warrior", "Orcish Warrior2", "Orcish Warlord", "Orcish Archer", "Orcish Crossbowman", "Orcish Raider", "Orcish Terror", 
    "Orcish Cleverman", "Orcish RimeRunner", "Great Orc", "Orcish Juggernaught",
    "Orcish Slurbow", "Orcish Rider", "Orcish Cavalry", "Orcish Destrier", "Hrala"},
    usage = "orcish"
})
table.insert(list_usage, {
    types = {"Ukian Runner", "Ukian Courrier", "Ukian Commando", "Orcish Slinger", "Orcish Hunter", "Orcish Stalker", "Orcish Drifter", "Orcish Wanderer", "Orcish Vagrant", "Orcish Traveler", "Ukian Seeress", "Ukian Witch", 
    "Orcish Cleverman", "Orcish RimeRunner", "Orcish SnowWalker", "Orcish IceStalker", "Orcish Assassin", "Orcish Slayer", "Orcish Slayer2",
    "Red Mage", "Arch Mage", "Silver Mage", "Great Mage", "Dark Messiah",
    "Phantom Cloak", "Phantom Shadow", "Phantom Master","Phantom Widow","Phantom Midnight","Phantom White","Phantom Banshee",
    "Lich", "Ancient Lich",
    "Primevalist Follower", "Primevalist Monk", "Primevalist Celebrant", "Primevalist Prior",
    "Ukian Archer", "Ukian Hawkeye", "Ukian Deadeye", "Raenna", "Bad Raenna", "Orcish Archer", "Orcish Crossbowman", "Orcish Slurbow", "Hrala"},
    usage = "amulet"
})
table.insert(list_usage, {
    types = {"Ukian Regular", "Ukian Veteran", "Ukian Signalman", "Ukian Subcommander", "Ukian Commander", "Ukian Flareman", "Ukian Officer", "Belleros", "Belleros_Officer", "Orcish Serf", "Orcish Foreman", 
    "Primevalist Fighter", "Primevalist Fanatic", "Primevalist Shield", "Primevalist Shield_High", "Primevalist Leader",
    "Ukian Courrier", "Ukian Commando", "Orcish Slinger", "Orcish Hunter", "Orcish Stalker", "Orcish Traveler", "Orcish Overseer", "Orcish Fireline", "Orcish Firebreather", "Orcish Grunt", "Orcish Warrior", "Orcish Warrior2", "Orcish Warlord", 
    "Spearman", "Swordsman", "Pikeman" ,"Javelineer", "Royal Guard", "Halberdier", "General", "Sergeant","Lieutenant",
    "Horseman", "Lancer", "Knight", "Paladin", "Grand Knight", "Cavalryman", "Dragoon", "Cavalier",
    "Bowman", "Longbowman", "Master Bowman",
    "Orcish SnowWalker", "Orcish IceStalker", "Great Orc", "Orcish Raider", "Orcish Terror", "Orcish FlameThrower",
    "Rat Rider", "Rat Lancer", "Rat Dragoon",
    "Northern Soldier", "Northern Fighter", "Northern Ranger", "Northern Elite",
    "Royal Spotter", "Royal Herdsman", "Royal Rider", "Royal Thrower", "Royal FireKnight",
    "Primevalist Fighter", "Primevalist Fanatic", "Primevalist Shield", "Primevalist Shield_High", "Primevalist Leader",
    "Primeval Swiftfoot", "Primeval Striker", "Primeval Slasher", "Primeval Protector", "Primeval Highguard", "Primeval Gyrepacter",
    "Primeval Slow", "Primeval Driver", "Primeval Giant",
    "Primeval Cutter", "Primeval Ironwheel", "Primeval Aerowheel", "Primeval Firewheel", "Primeval Sunwheel",
    "Primeval Dogface", "Primeval Warrior", "Primeval Titan",
    "Ukian Hawkeye", "Ukian Deadeye", "Raenna", "Orcish Archer", "Orcish Crossbowman", "Orcish Slurbow", "Orcish Rider", "Orcish Cavalry", "Orcish Destrier",
    "Walking Corpse", "Soulless",
    "Skeleton", "Revenant", "Draug", "Death Knight",
    "Skeleton Archer", "Bone Shooter", "Banebow",
    "Thug","Bandit","Highwayman","Resurrectionist",
    "Scarrion_Spearman", "Therion", "Altos",
    "Carusoe", "Carusoe2", "Bad Raenna", "Raenna", "Dark Messiah", "Huric"
    },
    usage = "light_armor"
})
table.insert(list_usage, {
    types = {"Ukian Veteran", "Ukian Signalman", "Ukian Subcommander", "Ukian Commander", "Ukian Flareman", "Ukian Officer", "Belleros", "Belleros_Officer", "Orcish Foreman", 
    "Northern Soldier", "Northern Fighter", "Northern Ranger", "Northern Elite",
    "Horseman", "Lancer", "Knight", "Paladin", "Grand Knight", "Cavalryman", "Dragoon", "Cavalier",
    "Orcish Overseer", "Orcish Fireline", "Orcish Firebreather", "Orcish Warrior", "Orcish Warrior2", "Orcish Warlord", "Orcish Rider", "Orcish Cavalry", "Orcish Destrier",
    "Orcish SnowWalker", "Orcish IceStalker", "Great Orc", "Orcish FlameThrower",
    "Heavy Infantryman","Shock Trooper","Iron Mauler",
    "Primevalist Fanatic", "Primevalist Shield", "Primevalist Shield_High", "Primevalist Leader",
    "Revenant", "Draug", "Death Knight",
    "Scarrion_Spearman", "Altos",
    "Royal Guard", "Halberdier","Huric"},
    usage = "heavy_armor"
})
table.insert(list_usage, {
    types = {"Ukian Regular", "Ukian Veteran", "Ukian Subcommander", "Ukian Commander", "Ukian Officer", "Belleros", "Belleros_Officer", 
    "Primevalist Shield", "Primevalist Shield_High",
    "Orcish Foreman", "Orcish Overseer", "Huric", "Orcish Juggernaught", "Orcish FlameThrower",
    "Cavalryman", "Dragoon", "Cavalier",
    "Northern Soldier", "Northern Fighter", "Northern Elite",
    "Revenant", "Draug",
    "Scarrion_Spearman",
    "Spearman", "Swordsman", "Royal Guard",
    "Phantom Spearman", "Phantom Soldier", "Phantom Officer", "Phantom Master"},
    usage = "shield"
})
table.insert(list_usage, {
    types = {
    "Ukian Archer", "Ukian Hawkeye", "Ukian Deadeye", "Raenna", 
    "Orcish Archer", "Orcish Crossbowman", "Orcish Slurbow",
    "Skeleton Archer", "Bone Shooter", "Banebow",
    "Therion",
    "Bowman", "Longbowman", "Master Bowman"},
    usage = "bow"
})
table.insert(list_usage, {
    types = {"Ukian Subcommander", "Ukian Commander", "Ukian Officer", "Belleros", "Belleros_Officer", "Orcish Grunt", "Orcish Warrior", "Orcish Warlord", "Ukian Hawkeye", "Ukian Deadeye", "Raenna", "Orcish Crossbowman", 
    "Primevalist Fighter", "Primevalist Fanatic", "Primevalist Shield", "Primevalist Shield_High", "Primevalist Leader",
    "Orcish Slurbow", "Orcish Rider", "Orcish Cavalry", "Orcish Destrier", "Great Orc",
    "Northern Soldier", "Northern Fighter", "Northern Ranger", "Northern Elite",
    "Carusoe", "Carusoe2", "Bad Raenna", "Huric"},
    usage = "sword"
})
table.insert(list_usage, {
    types = {"Ukian Signalman", "Ukian Flareman", "Orcish Serf", "Orcish Foreman", 
    "Primeval Dogface", "Primeval Warrior", "Primeval Titan",
    "Skeleton", "Revenant", "Draug", "Death Knight",
    "Altos",
    "Orcish Overseer", "Orcish Fireline", "Orcish Firebreather", "Great Orc"},
    usage = "axe"
})
table.insert(list_usage, {
    types = {"Ukian Regular", "Ukian Veteran", "Ukian Runner", "Ukian Courrier", "Ukian Commando",
    "Spearman", "Javelineer", "Pikeman", "Halberdier", 
    "Carusoe", "Carusoe2", 
    "Scarrion_Spearman",
    "Archaic_Goblin", "Frost Goblin", "Goblin Impaler",
    "Rat Rider", "Rat Lancer", "Rat Dragoon",
    "Orcish SnowWalker", "Orcish IceStalker"},
    usage = "spear"
})
table.insert(list_usage, {
    types = {"Farm Dog", "Ukian Dog", "Ukian Harrier", "Ukian War Hound", "Ukian Attack Dog", 
    "Wolf Rider", "Goblin Knight", "Goblin Pillager", "Direwolf Rider", 
    "Hunting_Hound", 
    "Snow Wolf Rider", "Frost Wolf Rider", "Ice Wolf Rider"
    },
    usage = "dog"
})
table.insert(list_usage, {
    types = {"Phantom Cloak", "Phantom Shadow", "Phantom Master", "Phantom Rider", "Phantom Horseman", "Phantom Dullohan", "Phantom Slayer", "Phantom Spearman", "Phantom Soldier", "Phantom Officer", "Phantom Knight", "Phantom Queen", "Phantom King"},
    usage = "despair"
})

-- equipment weight [effect]s
-- some weight effects are handled in equiment_write.lua:  movement, unit.variables.weight
local wt_def_effect = function (wt)
    local weight_effect = {"effect", {apply_to = "defense", replace = "no", {"defense", {
                          shallow_water= wt,
                          deep_water= wt,
                          reef= wt,
                          swamp_water= wt,
                          flat= wt,
                          sand= wt,
                          forest= wt,
                          hills= wt,
                          mountains= wt,
                          cave= wt,
                          frozen= wt,
                          fungus= wt
    }}}
    }
    return weight_effect
end

local wt_effect_1 = wt_def_effect(1)
local wt_effect_2 = wt_def_effect(2)
local wt_effect_3 = wt_def_effect(3)
local wt_effect_4 = wt_def_effect(4)
local wt_effect_5 = wt_def_effect(5)

local wt_effect_n1 = wt_def_effect(-1)
local wt_effect_n2 = wt_def_effect(-2)
local wt_effect_n3 = wt_def_effect(-3)
local wt_effect_n4 = wt_def_effect(-4)
local wt_effect_n5 = wt_def_effect(-5)

-- ability effects that may be used in different items

local selfheal_effect = {"effect", { apply_to = "new_ability",  {"abilities", { { "regenerate", { value=2, id= "selfheal", name= _ "self-heals", female_name= _ "female^self-heals", description= _ "The unit will heal itself 2 HP per turn. If it is poisoned, it will neither heal nor suffer the poison, but it must seek a cure elsewhere.", affect_self="yes", poison= "slowed" }}}}}}

-- the true illuminates description has a newline, which seems to cause trouble if I don't wrap it in something I don't care about right now.  Fix this later...
local illuminates_halo = {"effect", {apply_to = "halo", halo="halo/torch-aura.png"}}
local illuminates_effect = {"effect", { apply_to = "new_ability",  {"abilities", { { "illuminates", { id= "illumination", value=25, max_value=25, name= _ "illuminates", female_name= _ "female^illuminates", description= _ "This unit illuminates the surrounding area, making lawful units fight better, and chaotic units fight worse.", affect_self="yes"}}}}}}

local regenerate_effect = {"effect", { apply_to = "new_ability",  {"abilities", { { "regenerate", { value=8, id= "regenerates", name= _ "regenerates", female_name= _ "female^regenerates", description= _ "The unit will heal itself 8 HP per turn. If it is poisoned, it will remove the poison instead of healing.", affect_self="yes", poison= "cured" }}}}}}
-- local regenerate_neg_effect = {"effect", {apply_to = "remove_ability", {"abilities", {{"regenerate", { id = "regenerates"}}}}}}

local skirmisher_effect = {"effect", { apply_to = "new_ability",  {"abilities", { { "skirmisher", { id= "skirmisher", name= _ "skirmisher", female_name= _ "female^skirmisher", description= _ "This unit is skilled in moving past enemies quickly, and ignores all enemy Zones of Control.", affect_self="yes"}}}}}}
-- local skirmisher_neg_effect = {"effect", {apply_to = "remove_ability", {"abilities", {{"skirmisher", { id = "skirmisher"}}}}}}

local unpoison_effect = {"effect", { apply_to = "new_ability",  {"abilities", { { "heals", { id= "curing", name= _ "cures", female_name= _ "female^cures", description= _ "A curer can cure a unit of poison.", affect_enemies = "yes", affect_allies = "yes", affect_self="yes", poison = "cured", {"affect_adjacent", { adjacent = "n,ne,se,s,sw,nw" }} }}}}}}
-- local unpoison_neg_effect = {"effect", {apply_to = "remove_ability", {"abilities", {{"heals", { id = "curing"}}}}}}

local unpoison_effect2 = {"effect", { apply_to = "new_ability",  {"abilities", { { "heals", { id= "lesser_curing", name= _ "self-cures", female_name= _ "female^self-cures", description= _ "A self-curer can cure a self of poison.", affect_enemies = "no", affect_allies = "no", affect_self="yes", poison = "cured"  }}}}}}
-- local unpoison_neg_effect2 = {"effect", {apply_to = "remove_ability", {"abilities", {{"heals", { id = "lesser_curing"}}}}}}

local shadow_effect = {"effect", { apply_to = "new_ability", {"abilities", { { "hides", { id="nightstalk", name= _ "nightstalk", female_name= _ "female^nightstalk", description= _ "The unit becomes invisible during night. Enemy units cannot see this unit at night, except if they have units next to it. Any enemy unit that first discovers this unit immediately loses all its remaining movement.", 
	name_inactive= _ "nightstalk", female_name_inactive= _ "female^nightstalk", description_inactive= _ "The unit becomes invisible during night.  Enemy units cannot see this unit at night, except if they have units next to it. Any enemy unit that first discovers this unit immediately loses all its remaining movement.", affect_self="yes", {"filter", {{ "filter_location", {time_of_day="chaotic"}}}} }}}}}}
-- local shadow_neg_effect = {"effect", {apply_to = "remove_ability", {"abilities", {{"hides", { id = "nightstalk"}}}}}}
	
local poison_special = {"set_specials", {mode="append", {"poison", {id="poison", name= _ "poison", 
							description= _ "This attack poisons living targets. Poisoned units lose 8 HP every turn until they are cured or are reduced to 1 HP. Poison can not, of itself, kill a unit."
							}}}}

local drains_special = {"set_specials", {mode="append", {"drains", {id="drains", name= _ "drains", 
							description= _ "This unit drains health from living units, healing itself for half the amount of damage it deals (rounded down)."
							}}}}
                                
local firststrike_special = {"set_specials", {mode="append", {"firststrike", {id="firststrike", name= _ "first strike", 
							description= _ "This unit always strikes first with this attack, even if they are defending."
							}}}}
                                
                
--[[ 
there are 8 positions (used to be nine): 1. head, 2. shield, 3. ring, 4. cloak. 5. amulet, 6. torso, 7. greaves(old) + foot-> foot, 8. weapon
(for dogs only: 1. neck)
20190803 - adding 'arms'; adding weights attribute

Note: the ID and the eq_effect.ID have to match

]]--

------------ arms --------------
table.insert(the_list, {
	eq_effect = { id = "leather_vambrace", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {blade = -2, impact = -2}}}}, 
	              {"effect", { apply_to = "hitpoints", increase_total = "1"}}, wt_effect_1 
	            },
        name = _ "Leather Vambrace",
	id = "leather_vambrace",
        tooltip = _ "protection for the forearms, can be work with gloves",
        text = _ "These boiled leather coverings for the forearm offer only minimal protection, but they are light-weight and available to all..  Bonus: + 2 each impact and blade resistance, + 1 HP",
        image = "icons/leather_vambrace.png",
        icon = "items/leather_vambrace.png",
	cost = 10,
	usage = "all",
	position = "arms",
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "iron_vambrace", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {blade = -4, impact = -4}}}}, 
	              {"effect", { apply_to = "hitpoints", increase_total = "3"}}, wt_effect_2 
	            },
        name = _ "Iron Vambrace",
	id = "iron_vambrace",
        tooltip = _ "protection for the forearms, can be work with gloves",
        text = _ "This is sturdy iron cladding for the forearms, a bit heavy for some, but useful for most fighters.  Bonus: + 4 each impact and blade resistance, + 3 HP",
        image = "icons/iron_vambrace.png",
        icon = "items/iron_vambrace.png",
	cost = 15,
	usage = "light_armor",
	position = "arms",
	weight = 2
	
})
table.insert(the_list, {
	eq_effect = { id = "obsidian_bracelet", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {arcane = -2, impact = -2}}}}, 
	              {"effect", { apply_to = "attack", range = "ranged", increase_accuracy = "5"}}, 
	              {"effect", { apply_to = "hitpoints", increase_total = "1"}}, wt_effect_1 
	            },
        name = _ "Obsidian Bracelet",
	id = "obsidian_bracelet",
        tooltip = _ "protection for the forearms, can be work with gloves",
        text = _ "A broad. stitched hide bracelet with black, glassy shards sewn into the outer surface.  Bonus: + 2 each impact and arcane resistance, increases ranged accuracy by 5, + 1 HP",
        image = "icons/obsidian_bracelet.png",
        icon = "items/obsidian_bracelet.png",
	cost = 20,
	usage = "all",
	position = "arms",
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "jade_bracelet", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {cold = -3, arcane = -3, impact = -3}}}}, 
	              {"effect", { apply_to = "attack", range = "ranged", increase_parry = "5"}}, 
	              {"effect", { apply_to = "hitpoints", increase_total = "1"}}, wt_effect_1 
	            },
        name = _ "Jade Bracelet",
	id = "jade_bracelet",
        tooltip = _ "protection for the forearms, can be work with gloves",
        text = _ "A broad bronze bracelet with foggy green gems embeded around the edges, best worn with cloth padding underneath.  Bonus: + 3 each impact, cold, and arcane resistance, increases ranged parry by 5, + 1 HP",
        image = "icons/jade_bracelet.png",
        icon = "items/jade_bracelet.png",
	cost = 35,
	usage = "all",
	position = "arms",
	weight = 1
	
})
------------ helmets--------------
-- 20161105 removing the anti-effects, changing eq_effect.name to eq_effect.id for using [remove_object]
table.insert(the_list, {
	eq_effect = { id = "black_cowl", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {cold = -2, impact = -2}}}}, 
	              {"effect", { apply_to = "alignment", set = "chaotic"}}, 
	              {"effect", { apply_to = "hitpoints", increase_total = "1"}}, wt_effect_1 
	            },
        name = _ "Black Cowl",
	id = "black_cowl",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This is a black hood that has some dark, otherworldly essence.  Anyone can wear it, but why would one want to? Bonus: + 2 each impact and cold resistance, sets alignment to chaotic, + 1 HP",
        image = "icons/black_cowl.png",
        icon = "items/black_cowl.png",
	cost = 35,
	usage = "all",
	position = "head",
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "white_ribbon", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {arcane = -5, impact = -1}}}}, 
	              {"effect", { apply_to = "alignment", set = "lawful"}},
	              selfheal_effect, 
	              {"effect", { apply_to = "hitpoints", increase_total = "1"}}, wt_effect_1 
	            },
        name = _ "White Ribbon",
	id = "white_ribbon",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This ribbon has been blessed by some benign spirits. While it offers only minimal physical protection, it is not cumbersome, and it brings the wearer into a certain frame of mind. Bonus: + 5 arcane and +1 impact resistance, sets alignment to lawful, provides a weak regeneration ability, + 1 HP",
        image = "icons/white_ribbon.png",
        icon = "items/white_ribbon.png",
	cost = 30,
	usage = "all",
	position = "head",
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "sorrow_veil", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {fire = -5, impact = -1}}}}, 
                      {"effect", { apply_to = "defense", replace = "no", {"defense", {
                                  forest = -10,
                                  hills = -10,
                                  mountains = -10,
                                  village = -10,
                                  castle = -10,
                                  cave = -10
                      }}}}, 
	              {"effect", { apply_to = "alignment", set = "neutral"}},
	              {"effect", { apply_to = "hitpoints", increase_total = "1"}}, wt_effect_n1 
	            },
        name = _ "Sorrow Veil",
	id = "sorrow_veil",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This dark shimmering veil gives the wearer a cool detachment, allowing for better defense in some terrains, and a neutral alignment. Bonus: + 5 fire and +1 impact resistance, sets alignment to neutral, +10 for some terrain , + 1 HP",
        image = "icons/sorrow_veil.png",
        icon = "items/sorrow_veil.png",
	cost = 50,
	usage = "all",
	position = "head",
	weight = -1
	
})
table.insert(the_list, {
	eq_effect = { id = "cap_helmet", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -2}}}}, 
	              {"effect", { apply_to = "hitpoints", increase_total = "1"}}, wt_effect_1 
	            },
        name = _ "Padded Cap",
	id = "cap_helmet",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This is a very basic covering for the head. While it offers only minimal protection, it is not cumbersome, and almost anyone can use it. Bonus: + 2 impact resistance, + 1 HP",
        image = "icons/helmet_leather-cap.png",
        icon = "items/leather_cap.png",
	cost = 25,
	usage = "all",
	position = "head",
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "cap_gem", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -5, fire = -5, arcane = -5}}}}, {"effect", { apply_to = "vision", increase = "-8"}}, {"effect", { apply_to = "hitpoints", increase_total = "5"}}, wt_effect_1},
        name = _ "Jewel Cap",
	id = "cap_gem",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This is an expensive and bedazzling covering for the head that is not cumbersome and almost anyone can use it. Bonus: + 5 each impact, fire, and arcane resistance, + 5 HP",
        image = "icons/helmet_gem-cap.png",
        icon = "items/gem_cap.png",
	cost = 65,
	usage = "all",
	position = "head",
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "fur_hat", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {cold = -6}}}}, wt_effect_1 
	            },
        name = _ "Fur Hat",
	id = "fur_hat",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This is a warm fur hat. While it offers only minimal protection, it is not cumbersome, and almost anyone can use it. Bonus: + 6 cold resistance",
        image = "icons/fur_hat.png",
        icon = "items/fur_hat.png",
	cost = 30,
	usage = "all",
	position = "head",
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "light_helmet", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -5}}}}, 
	              {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_1 
	            },
        name = _ "Light Helmet",
	id = "light_helmet",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This is a very basic, inexpensive helmet, but it still provides some layer of steel to cover the scalp.  Bonus: + 5 impact resistance, + 2 HP",
        image = "icons/helmet_conical.png",
        icon = "items/helmet3.png~CS(-20,-10,0)",
	cost = 45,
	usage = "light_armor",
	position = "head",
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "rusty_helmet", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -1, arcane = -5}}}}, 
	              {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_2 
	            },
        name = _ "Rusty Helmet",
	id = "rusty_helmet",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This helmet has been left out in the elements for too long.  The metal is rusted, the leather and padding are rotted.  But for the undead, it provides some mundane protection against the arcane attacks.  Bonus: + 1 impact and +5 arcane resistance, + 2 HP",
        image = "icons/helmet_rusty.png",
        icon = "items/helmet_rusty.png",
	cost = 25,
	usage = "light_armor",
	position = "head",
	weight = 2
	
})
table.insert(the_list, {
	eq_effect = { id = "steel_helmet", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -10}}}}, 
	              {"effect", { apply_to = "hitpoints", increase_total = "4"}}, wt_effect_1 },
        name = _ "Steel Helmet",
	id = "steel_helmet",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This is a well-made, open-faced helmet.  It provides no protection for the face or neck, but the scalp is well protected. Bonus: + 10 impact resistance, + 4 HP",
        image = "icons/helmet_shiny.png",
        icon = "items/helmet3.png",
	cost = 80,
	usage = "light_armor",
	position = "head",
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "chain_helmet", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -8, blade = -3}}}}, 
	              {"effect", { apply_to = "hitpoints", increase_total = "5"}}, wt_effect_2},
        name = _ "Chain Coif",
	id = "chain_helmet",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This is a chain-mail hood, it provides protection for the scalp and neck.  Bonus: + 8 impact resistance, +3 blade resistance, + 4 HP",
        image = "icons/helmet_chain-coif.png",
        icon = "items/coif.png",
	cost = 95,
	usage = "light_armor",
	position = "head",
	weight = 2
})
table.insert(the_list, {
	eq_effect = { id = "bone_helmet", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -2, pierce = -12, arcane = 5, fire = 5}}}}, 
	              {"effect", { apply_to = "hitpoints", increase_total = "5"}}, wt_effect_1 },
        name = _ "Bone Helmet",
	id = "bone_helmet",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This grisly helmet is made of bone, and has some otherworldly essence that imparts some undead characteristics to the wearer.  Penalty: -5 each fire and arcane resistance; Bonus: + 2 impact resistance, +12 pierce resistance, + 4 HP",
        image = "icons/helmet_bone.png",
        icon = "items/bone_helmet.png",
	cost = 75,
	usage = "light_armor",
	position = "head",
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "crested_helmet", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -12, blade = -5}}}}, {"effect", { apply_to = "hitpoints", increase_total = "6"}}, wt_effect_2 },
        name = _ "Crested Helmet",
	id = "crested_helmet",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This is a standard issue helmet for the professional warrior class of Weldyn.  It provides protection for the neck, and some minimal protection for the eyes.  Bonus: + 12 impact resistance, + 5 blade resistance, + 6 HP",
        image = "icons/helmet_crested.png",
        icon = "items/helmet1.png~CS(10,10,10)",
	cost = 120,
	usage = "heavy_armor",
	position = "head",
	weight = 2

})
table.insert(the_list, {
	eq_effect = { id = "bascinet_helmet", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -15, blade = -10, pierce = -5}}}}, {"effect", { apply_to = "hitpoints", increase_total = "8"}}, wt_effect_3 },
        name = _ "Bascinet",
	id = "bascinet_helmet",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This is the helmet worn by nobles and kings, as well as their trusted guards.  It provides complete protection for the head and face.  Bonus: + 15 impact resistance, + 10 blade resistance, + 5 pierce resistance, + 8 HP",
        image = "icons/helmet_bascinet.png",
        icon = "items/helmet1.png",
	cost = 155,
	usage = "heavy_armor",
	position = "head",
	weight = 3
})
table.insert(the_list, {
	eq_effect = { id = "great_helmet", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -20, blade = -15, pierce = -15}}}}, {"effect", { apply_to = "hitpoints", increase_total = "10"}}, wt_effect_3 },
        name = _ "Great Helm",
	id = "great_helmet",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This is an older design of helmet used, still used by some kings and knights.  It is sturdier, but more restricting than the bascinet, so while stronger against blunt-force trauma, it offers less protection against attacks to the neck.  Bonus: + 20 impact resistance, + 5 blade resistance, + 5 pierce resistance, + 10 HP",
        image = "icons/helmet_great2.png",
        icon = "items/helmet2.png~CS(-20,-20,0)",
	cost = 160,
	usage = "heavy_armor",
	position = "head",
	weight = 3
})
table.insert(the_list, {
	eq_effect = { id = "frog_helmet", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -30, blade = -20, pierce = -15, fire = 20}}}}, {"effect", { apply_to = "hitpoints", increase_total = "12"}}, wt_effect_4 },
        name = _ "Trooper Helmet",
	id = "frog_helmet",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This is a heavy helmet that is sometimes used by elite fighters.  It offers superior protection for the head and neck, but it is heavy, restricting, and stuffy, making the wearer more vulnerable to heat-stroke.  Effect: + 30 impact resistance, + 20 blade resistance, + 15 pierce resistance, + 10 HP; -20 fire resistance",
        image = "icons/helmet_frogmouth.png",
        icon = "items/helmet4.png",
	cost = 200,
	usage = "heavy_armor",
	position = "head",
	weight = 4
})
table.insert(the_list, {
	eq_effect = { id = "ancient_helmet", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -25, blade = -10, arcane = -5, fire = -5}}}}, {"effect", { apply_to = "hitpoints", increase_total = "12"}}, wt_effect_2 },
        name = _ "Ancient Helmet",
	id = "ancient_helmet",
        tooltip = _ "all helmets offer impact resistance",
        text = _ "This heavy, ancient helmet is not for everyone.  It provides excellent protection for the head, but the neck is often exposed to slim blades or arrows.  Aside from its obvious benefits and shortcomings, there is something about this object, that is difficult to describe to one not holding it.  Bonus: + 25 impact resistance, + 10 blade resistance, + 12 HP",
        image = "icons/helmet_corinthian.png",
        icon = "items/helmet2.png~CS(10,-10,-20)",
	cost = 235,
	usage = "heavy_armor",
	position = "head",
	weight = 2
})
------------------shields-----------------------------
table.insert(the_list, {
	eq_effect = { id = "hide_buckler", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -2, blade = -2}}}}, {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_1 },
        name = _ "Hide Buckler",
	id = "hide_buckler",
        tooltip = _ "all shields offer impact resistance",
        text = _ "This very small shield is made from animal hides and provides some protection against physical attacks, but is too small to be of much use against arrows or spears  Bonus: + 2 each impact and blade resistance, + 2 HP",
        image = "icons/buckler_hide.png",
        icon = "items/hide_buckler.png",
	cost = 15,
	usage = "all",
	position = "shield",
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "bronze_buckler", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -5, blade = -5}}}}, {"effect", { apply_to = "hitpoints", increase_total = "4"}}, wt_effect_1 },
        name = _ "Bronze Buckler",
	id = "bronze_buckler",
        tooltip = _ "all shields offer impact resistance",
        text = _ "This very small shield is made from bronze and provides some protection against physical attacks, but is too small to be of much use against arrows or spears  Bonus: + 5 each impact and blade resistance, + 4 HP",
        image = "icons/buckler_bronze.png",
        icon = "items/bronze_buckler.png",
	cost = 65,
	usage = "all",
	position = "shield",
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "iron_buckler", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -8, blade = -8}}}}, {"effect", { apply_to = "hitpoints", increase_total = "6"}}, wt_effect_1 },
        name = _ "Iron Buckler",
	id = "iron_buckler",
        tooltip = _ "all shields offer impact resistance",
        text = _ "This very small shield is made from iron and provides some protection against physical attacks, but is too small to be of much use against arrows or spears  Bonus: + 8 each impact and blade resistance, + 6 HP",
        image = "icons/buckler_iron.png",
        icon = "items/iron_buckler.png",
	cost = 95,
	usage = "all",
	position = "shield",
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "rusty_targ", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -5, blade = -5, arcane = 10, fire = -5}}}}, {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_1 },
        name = _ "Ancient Targe",
	id = "rusty_targ",
        tooltip = _ "all shields offer impact resistance",
        text = _ "This small, ancient shield is of a type that can frequently be found in the northlands.  It's not clear who made them, but all scavengers find them useful.  Bonus: + 5 impact resistance, + 5 blade resistance, -10 arcane resistance, + 5 fire resistance, + 2 HP",
        image = "icons/rusty_targ.png",
        icon = "items/buckler.png~CS(-30,-10,-10)",
	cost = 15,
	usage = "all",
	position = "shield",
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "wooden_shield", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -5, blade = -5, pierce = -3}}}}, {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_2 },
        name = _ "Wooden Shield",
	id = "wooden_shield",
        tooltip = _ "all shields offer impact resistance",
        text = _ "This is a basic wooden shield.  Nothing fancy but still provides some protection.  Bonus: + 5 impact resistance, + 5 blade resistance, +3 pierce resistance, + 2 HP",
        image = "icons/shield_wooden.png",
        icon = "items/shield-targ.png~CS(30,10,-10)",
	cost = 20,
	usage = "shield",
	position = "shield",
	weight = 2
})
table.insert(the_list, {
	eq_effect = { id = "kite_shield", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -7, blade = -5, pierce = -4}}}}, {"effect", { apply_to = "hitpoints", increase_total = "3"}}, wt_effect_1 },
        name = _ "Kite Shield",
	id = "kite_shield",
        tooltip = _ "all shields offer impact resistance",
        text = _ "This is a wooden shield with a smoothed and painted front face.  The main difference between the kite shield and the more common wooden shield is that the kite shield was made with more care and skill.  Bonus: + 7 impact resistance, + 5 blade resistance, + 2 pierce resistance, + 2 HP",
        image = "icons/shield_kite.png",
        icon = "items/shield_kite.png",
	cost = 25,
	usage = "shield",
	position = "shield",
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "orc_shield", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -5, blade = -6, pierce = -5}}}}, {"effect", { apply_to = "hitpoints", increase_total = "3"}}, wt_effect_2 },
        name = _ "Orcish Shield",
	id = "orc_shield",
        tooltip = _ "all shields offer impact resistance",
        text = _ "This shield is made from bronze and wood, crudely made but still effective.  Bonus: + 5 impact resistance, + 5 blade resistance, + 5 pierce resistance, + 3 HP",
        image = "icons/orc_roundshield.png",
        icon = "items/buckler.png~CS(20,-10,-10)",
	cost = 25,
	usage = "shield",
	position = "shield",
	weight = 2
})
table.insert(the_list, {
	eq_effect = { id = "silver_shield", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -5, blade = -5, arcane = -10, fire = -10}}}}, {"effect", { apply_to = "hitpoints", increase_total = "5"}}, wt_effect_1 },
        name = _ "Silver Shield",
	id = "silver_shield",
        tooltip = _ "all shields offer impact resistance",
        text = _ "This is shiny shield is small but sturdy and has a brilliant aura.  Bonus: + 5 impact resistance, + 5 blade resistance, +10 arcane resistance, + 10 fire resistance, + 5 HP",
        image = "icons/silver_buckler.png",
        icon = "items/buckler.png~CS(20,40,60)",
	cost = 90,
	usage = "shield",
	position = "shield",
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "iron_shield", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -10, blade = -10, pierce = -10, fire = -5}}}}, {"effect", { apply_to = "hitpoints", increase_total = "7"}}, wt_effect_3 },
        name = _ "Iron Shield",
	id = "iron_shield",
        tooltip = _ "all shields offer impact resistance",
        text = _ "This is a heavy iron shield, not for everyone..  Bonus: + 10 impact resistance, + 10 blade resistance, + 10 pierce, + 5 fire resistance, + 7 HP",
        image = "icons/shield_steel.png~CS(-10,-30,-10)",
        icon = "items/shield-iron.png",
	cost = 70,
	usage = "shield",
	position = "shield",
	weight = 3
})
table.insert(the_list, {
	eq_effect = { id = "door_shield", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -25, blade = -20, pierce = -30, fire = -10}}}}, {"effect", { apply_to = "movement", increase = "-1"}}, {"effect", { apply_to = "hitpoints", increase_total = "10"}}, wt_effect_4 },
        name = _ "Door Shield",
	id = "door_shield",
        tooltip = _ "all shields offer impact resistance",
        text = _ "This is a very heavy, tall, rectangular shield that offers superior protection, but is quite awkward to carry.  Bonus: + 25 impact resistance, + 20 blade resistance, + 30 pierce, + 10 fire resistance; + 10 HP.  Penalty: -1 Movepoints",
        image = "icons/shield_tower.png",
        icon = "items/shield-door.png",
	cost = 150,
	usage = "shield",
	position = "shield",
	weight = 4
})
table.insert(the_list, {
	eq_effect = { id = "mirror_shield", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {impact = -5, pierce = -10, fire = -50}}}}, {"effect", { apply_to = "hitpoints", increase_total = "7"}}, wt_effect_1 },
        name = _ "Mirror Shield",
	id = "mirror_shield",
        tooltip = _ "all shields offer impact resistance",
        text = _ "This shield deflects the damaging energy of fire attacks. It also tends to make pierce attacks slide off harmlessly.  Bonus: + 5 impact resistance, + 10 pierce, + 50 fire resistance, + 7 HP",
        image = "icons/shield_polished.png~GS()",
        icon = "misc/reflector-shield.png",
	cost = 270,
	usage = "shield",
	position = "shield",
	weight = 1
})
----------------- cloaks -------------------------------
table.insert(the_list, {
	eq_effect = { id = "fur_cloak", id = "fur_cloak", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {cold = -5}}}}, wt_effect_1 },
        name = _ "Fur Cloak",
        id = "fur_cloak",
        tooltip = _ "all cloaks provide some cold resistance",
        text = _ "This animal fur cloak keeps out the snow and rain, and provides some insulation against the cold winds.  Bonus: + 5 cold resistance",
        image = "icons/cloak_leather_brown.png",
        icon = "items/fur-cloak.png",
	cost = 30,
	usage = "all",
	position = "cloak",
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "elf_cloak", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {cold = -5, pierce = -5}}}}, wt_effect_1 },
        name = _ "Elven Cloak",
        id = "elf_cloak",
        tooltip = _ "all cloaks provide some cold resistance",
        text = _ "This cloak is a thin, dark leather.  The woodland elves wear this because it is a cost-effective protection against the cold, as well as the slight piercings of the thorns and bramble.  Bonus: +5 cold resistance, +5 pierce resistance",
        image = "icons/cloak_leather_brown.png~CS(-20,15,-30)",
        icon = "items/cloak-green.png",
	cost = 38,
	usage = "all",
	position = "cloak",
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "orc_cloak", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {cold = -10, pierce = -5, impact = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_2},
        name = _ "Orcish Cloak",
        id = "orc_cloak",
        tooltip = _ "all cloaks provide some cold resistance",
        text = _ "This is a great-cloak worn by the wiser or powerful orcs.  The orcs have refused to divulge the source of the hide, but although it is crude, the hide is thick, and the fur is nearly impenetrable to claws or thorns.  It is quite a treasure for anyone who must live in the frozen north.  Bonus: +10 cold resistance, +5 pierce and impact resistance, +2 HP",
        image = "icons/cloak_orc.png",
        icon = "items/orc-cloak.png",
	cost = 45,
	usage = "all",
	position = "cloak",
	weight = 2
	
})
table.insert(the_list, {
	eq_effect = { id = "silver_cloak", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {cold = -10, fire = -15, pierce = -5, blade = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_1},
        name = _ "Silver Cloak",
        id = "silver_cloak",
        tooltip = _ "all cloaks provide some cold resistance",
        text = _ "This cloak is of a material that is far beyond anything Weldyn, Knalga, or Wesmere can produce.  It is metallic, yet very light, and seems to whisk away the hot or cold.  Bonus: +10 cold resistance, +15 fire resistance, +5 pierce resistance, +5 blade resistance, +2 HP",
        image = "icons/cloak_silver.png",
        icon = "items/cloak-green.png~GS()",
	cost = 145,
	usage = "all",
	position = "cloak",
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "ancient_cloak", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {cold = -5}}}} , {"effect", { apply_to = "movement", increase = "1"}}, wt_effect_n1},
        name = _ "Ancient Cloak",
        id = "ancient_cloak",
        tooltip = _ "all cloaks provide some cold resistance",
        text = _ "This cloak is of a material that is far beyond anything Weldyn, Knalga, or Wesmere can produce.  It is some very light material, air seems to glide right over it.  Bonus: +5 cold resistance, + 1 Movement",
        image = "icons/cloak_leather_brown.png~CS(10,-45,35)",
        icon = "items/ancient-cloak.png",
	cost = 135,
	usage = "all",
	position = "cloak",
	weight = -1
	
})
table.insert(the_list, {
	eq_effect = { id = "rotten_cloak", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {cold = -2, fire = -10, arcane = -20}}}} , {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_1},
        name = _ "Rotten Cloak",
        id = "rotten_cloak",
        tooltip = _ "all cloaks provide some cold resistance",
        text = _ "This fetid mess of a cloak is some sort of fungal shield for anyone who can stand to wear it.  Moist and disgusting.  Bonus: +2 cold, +10 fire, and +20 arcane resistances; +2 HP",
        image = "icons/cloak_rotten.png",
        icon = "items/cloak-rotten.png",
	cost = 15,
	usage = "all",
	position = "cloak",
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "death_cloak", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {cold = -10, arcane = 20}}}} , {"effect", { apply_to = "hitpoints", increase_total = "-10"}}, shadow_effect},
        name = _ "Death Cloak",
        id = "death_cloak",
        tooltip = _ "all cloaks provide some cold resistance",
        text = _ "This vile black cloak looks like something pulled out of the ground.  There is something unworldly about it, a sinister power.  Bonus: +10 cold resistance; nightstalk ability.  Penalty: -10 HP; -20 arcane resistance",
        image = "icons/cloak_black.png~CS(10,15,-5)",
        icon = "items/cloak-black.png",
	cost = 45,
	usage = "all",
	position = "cloak",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "black_cloak", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {cold = -50}}}} , {"effect", { apply_to = "hitpoints", increase_total = "5"}}, shadow_effect},
        name = _ "Black Cloak",
        id = "black_cloak",
        tooltip = _ "all cloaks provide some cold resistance",
        text = _ "There is something unworldly about this inky black cloak, a sinister power.  Attempts to wear it usually meet with frustration, because it is not meant for the living.  Bonus: +50 cold resistance; nightstalk ability; +5 HP",
        image = "icons/cloak_black.png",
        icon = "items/cloak-black.png~CS(-30,0,10)",
	cost = 65,
	usage = "despair",
	position = "cloak",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "mage_cloak", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {cold = -5, fire = -5, arcane = -5, pierce = -5, blade = -5}}}} , {"effect", { apply_to = "attack", range = "ranged", increase_damage = "1"}}, wt_effect_1},
        name = _ "Mage Cloak",
        id = "mage_cloak",
        tooltip = _ "all cloaks provide some cold resistance",
        text = _ "This cloak was brought up from the South, it is made from fine threads with fine gold wires interwoven into strange symbols that have some meaning to the Magi, but almost no one in the frozen North can understand them. Bonus: +5 cold, fire, arcane, blade, and pierce resistance, + 1 ranged damage",
        image = "icons/cloak_red.png",
        icon = "items/cloak-green.png~CS(80,-60,-30)",
	cost = 265,
	usage = "amulet",
	position = "cloak",
	weight = 1
	
})
------- rings ----------------------
table.insert(the_list, {
	eq_effect = { id = "stone_ring", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {arcane = -3, fire = -3}}}} , {"effect", { apply_to = "hitpoints", increase_total = "1"}}},
        name = _ "Stone Ring",
        id = "stone_ring",
        tooltip = _ "rings usually provide protection against the non-physical attacks",
        text = _ "This crude ring has familiar runes carved into the inner surface.  It's quite likely that this offers very little protection, but every little bit helps.  Bonus: +3 arcane resistance, +3 fire resistance, +1 HP",
        image = "icons/stone_ring.png",
        icon = "items/ring-white.png",
	cost = 38,
	usage = "amulet",
	position = "ring",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "steel_ring", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {arcane = -10, fire = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "2"}}},
        name = _ "Steel Ring",
        id = "steel_ring",
        tooltip = _ "rings usually provide protection against the non-physical attacks",
        text = _ "This steel ring has been blessed by the local mystic or holyman or priest, or whatever you wish to call them.  Many would be skeptical that there is any merit in that, but over time, it has been shown that the blessing does make a difference.  Bonus: +10 arcane resistance, +5 fire resistance, +2 HP",
        image = "icons/ring_gold.png~GS()",
        icon = "items/ring-silver.png",
	cost = 45,
	usage = "amulet",
	position = "ring",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "gold_ring", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {arcane = -15, fire = -10, cold = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "3"}}},
        name = _ "Gold Ring",
        id = "gold_ring",
        tooltip = _ "rings usually provide protection against the non-physical attacks",
        text = _ "This gold ring is quite common amongst those who can afford it.  No one would claim that the runes are nonsense.  Bonus: +15 arcane resistance, +10 fire resistance, +5 cold resistance, +3 HP",
        image = "icons/ring_gold.png",
        icon = "items/ring-gold.png",
	cost = 95,
	usage = "amulet",
	position = "ring",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "green_ring", 
	{"effect", { apply_to = "resistance", replace = "no",{"resistance", {arcane = -10, fire = -5, cold = -5}}}} , 
	{"effect", { apply_to = "defense", replace = "no",{"defense", {forest = -25}}}} , 
	{"effect", { apply_to = "hitpoints", increase_total = "3"}}},
        name = _ "Green Ring",
        id = "green_ring",
        tooltip = _ "rings usually provide protection against the non-physical attacks",
        text = _ "It is as if this ring puts the wearer in harmony with the trees, for they become so nimble in the forest.  Bonus: +25 percent defense in forest, +10 arcane resistance, +5 each fire and cold resistance, +3 HP",
        image = "icons/ring_green.png",
        icon = "items/ring-green.png",
	cost = 135,
	usage = "amulet",
	position = "ring",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "dark_ring", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {fire = -15, cold = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "2"}}},
        name = _ "Dark Ring",
        id = "dark_ring",
        tooltip = _ "rings usually provide protection against the non-physical attacks",
        text = _ "This dark ring is made from some dark metal that cannot be polished to a bright luster, and it is always cold to the touch.  Bonus: +15 fire resistance, +5 cold resistance, +2 HP",
        image = "icons/ring_dark.png",
        icon = "items/ring-black.png~CS(5,-5,0)",
	cost = 55,
	usage = "amulet",
	position = "ring",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "crystal_ring", {"effect", { apply_to = "hitpoints", increase_total = "2"}}, unpoison_effect
	},
        name = _"Crystal Ring",
        id = "crystal_ring",
        tooltip = _ "rings usually provide protection against the non-physical attacks",
        text = _ "This ring has a clear gemstone that shines with an inner light.  Bonus: Cures poison on self and all adjacent, +2 HP",
        image = "icons/jewelry_ring_prismatic.png",
        icon = "items/ring-silver.png",
	cost = 145,
	usage = "amulet",
	position = "ring",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "skull_ring", {"effect", { apply_to = "hitpoints", increase_total = "-5"}}, {"effect", { apply_to = "resistance", replace = "no",{"resistance", {arcane = 10, fire = -15, cold = -50}}}},
		{"effect", { apply_to = "status", add = "unpoisonable"}}, {"effect", {apply_to = "status", add = "undrainable"}}, 
		{"effect", {apply_to = "status", add = "unplagueable"}}, {"effect", {apply_to = "status", add = "unhealable"}}, 
		{"effect", {apply_to = "status", add = "not_living"}},
		{"effect", {apply_to = "image_mod", replace = "~CS(-15,-10,-5)"}}
	},
        name = _ "Skull Ring",
        id = "skull_ring",
        tooltip = _ "rings usually provide protection against the non-physical attacks",
        text = _ "This ring has a sinister-looking skull affixed to a dark metal base.  It's not clear that this is something you really want to wear.  Effects: Grants upoinsonable, unplagueable, undrainable, yet unhealable status; 10 percent arcane weakness; 15 percent fire and 50 percent cold resistance, -5 HP",
        image = "icons/skull_ring.png",
        icon = "items/ring-black.png",
	cost = 15,
	usage = "all",
	position = "ring",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "ancient_ring", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {arcane = -5, fire = -5, cold = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "3"}}, regenerate_effect
--	{"effect", { apply_to = "new_ability",  {"abilities", { { "regenerate", { value=8, id= "regenerates", name= _ "regenerates", female_name= _ "female^regenerates", description= _ "The unit will heal itself 8 HP per turn. If it is poisoned, it will remove the poison instead of healing.", affect_self="yes", poison= "cured" }}}}}}
	},
        name = _ "Ancient Ring",
        id = "ancient_ring",
        tooltip = _ "rings usually provide protection against the non-physical attacks",
        text = _ "This ancient ring has some sort of power that has kept it from rusting away over the ages.  Bonus: +5 arcane resistance, +5 fire resistance, +5 cold resistance, Regeneration Ability",
        image = "icons/ring_gold.png~CS(10,-20,-60)",
        icon = "items/ring-brown.png",
	cost = 195,
	usage = "amulet",
	position = "ring",
	weight = 0
	
})
-- not really rings, but ...
table.insert(the_list, {
	eq_effect = { id = "leather_gloves", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -3, fire = -3, cold = -3}}}} , {"effect", { apply_to = "hitpoints", increase_total = "1"}}, wt_effect_1},
        name = _ "Leather Gloves",
        id = "leather_gloves",
        tooltip = _ "protection for the hands",
        text = _ "These fine leather gloves provide some protection from the elements and minor cuts, without being too cumbersome.  Bonus: +3 blade, +3 cold, +3 fire resistances;  +1 hitpoints.",
        image = "icons/gloves.png",
        icon = "items/gloves.png",
	cost = 35,
	usage = "all",
	position = "ring",
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "white_gloves", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {arcane = -10, cold = -3}}}} , {"effect", { apply_to = "hitpoints", increase_total = "3"}}},
        name = _ "White Gloves",
        id = "white_gloves",
        tooltip = _ "protection for the hands",
        text = _ "These white, silken gloves seem to be woven with supernatural threads.  Bonus: +10 arcane, +3 cold resistances;  +3 hitpoints.",
        image = "icons/white_gloves.png",
        icon = "items/white_gloves.png",
	cost = 55,
	usage = "all",
	position = "ring",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "black_gloves", 
	{"effect", { apply_to = "resistance", replace = "no",{"resistance", {arcane = -10, cold = -5}}}}, 
	{"effect", { apply_to = "hitpoints", increase_total = "5"}}, 
	{"effect", { apply_to = "attack", range = "melee", drains_special}} },
        name = _ "Black Gloves",
        id = "black_gloves",
        tooltip = _ "protection for the hands",
        text = _ "These black, silken gloves seem to be woven with supernatural threads.  Bonus: +10 arcane, +5 cold resistances;  +5 hitpoints; Drain capability for melee attack",
        image = "icons/black_gloves.png",
        icon = "items/black_gloves.png",
	cost = 55,
	usage = "all",
	position = "ring",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "bronze_gloves", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -5, blade = -5, fire = -3, cold = -3}}}} , {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_2},
        name = _ "Bronze Gauntlets",
        id = "bronze_gloves",
        tooltip = _ "protection for the hands",
        text = _ "These crude gauntlets are leather gloves with overlapping bronze plates on the knuckles and back.  They are simple but effective, considering how important your hands are.  Bonus: +5 blade, +5 impact, +3 cold, +3 fire resistances;  +2 hitpoints.",
        image = "icons/gauntlets-bronze.png",
        icon = "items/gauntlets1.png",
	cost = 65,
	usage = "light_armor",
	position = "ring",
	weight = 2
	
})
table.insert(the_list, {
	eq_effect = { id = "thunder_gloves", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -5, blade = -5, arcane = -5, fire = -8, cold = -3}}}} , {"effect", { apply_to = "hitpoints", increase_total = "5"}}, wt_effect_1},
        name = _ "Thunder Gauntlets",
        id = "thunder_gloves",
        tooltip = _ "protection for the hands",
        text = _ "These light gauntlets are encrusted with brilliant, clear jewels that flash in the ambient light.  There is something supernatural about them.  Bonus: +5 blade, +5 impact, +3 cold, +8 fire, +5 arcane resistances;  +5 hitpoints.",
        image = "icons/gauntlets-thunder.png",
        icon = "items/gauntlets-thunder.png",
	cost = 125,
	usage = "light_armor",
	position = "ring",
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "steel_gloves", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -7, impact = -6, fire = -5, cold = -3}}}} , {"effect", { apply_to = "hitpoints", increase_total = "4"}}, wt_effect_3},
        name = _ "Steel Gauntlets",
        id = "steel_gloves",
        tooltip = _ "protection for the hands",
        text = _ "These gauntlets provide full metal protection for the hands and wrist, but they do interfere with normal movement, so they are not for everyone.  Bonus: +7 blade, +6 impact, +3 cold, +5 fire resistances;  +4 hitpoints.",
        image = "icons/gauntlets.png",
        icon = "items/gauntlets2.png",
	cost = 110,
	usage = "heavy_armor",
	position = "ring",
	weight = 3
	
})
table.insert(the_list, {
	eq_effect = { id = "silver_gloves", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -6, impact = -5, pierce = -3, fire = -5, cold = -3}}}} , {"effect", { apply_to = "hitpoints", increase_total = "3"}}, wt_effect_1},
        name = _ "Silver Gauntlets",
        id = "silver_gloves",
        tooltip = _ "protection for the hands",
        text = _ "These gauntlets provide full protection for the hands and wrist, and are much lighter than would be expected, given their sturdy construction.  Bonus: +6 blade, + 5 impact, +3 pierce, +3 cold, +5 fire resistances;  +3 hitpoints.",
        image = "icons/gauntlets-silver.png",
        icon = "items/gauntlets-silver.png",
	cost = 150,
	usage = "heavy_armor",
	position = "ring",
	weight = 1
	
})
------------------------amulets-------------------------
table.insert(the_list, {
	eq_effect = { id = "primeval_charm", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {arcane = 30}}}}, {"effect", { apply_to = "status", add = "unplagueable"}}},
        name = _ "Odd Amulet",
        id = "primeval_charm",
        tooltip = _ "amulets can have special effects",
        text = _ "At the height of the Khthon plague, some research and cooperation between the Primevals and Humans resulted in a device that offered protection to vulnerable races, though it makes the wearer weaker against arcane attacks.  Anyone can use it.  Bonus: Grants 'unplagueable' status",
        image = "icons/primeval_charm.png",
        icon = "items/primeval_charm.png",
	cost = 75,
	usage = "all",
	position = "amulet",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "kidney_belt", {"effect", { apply_to = "hitpoints", increase_total = "3"}}, wt_effect_n2},
        name = _ "Kidney Belt",
        id = "kidney_belt",
        tooltip = _ "belt helps with equipment weight",
        text = _ "This large belt provides support for the lower back.  Anyone can use it.  Bonus: Reduces carried weight by 2; +3 hitpoints",
        image = "icons/kidney_belt.png",
        icon = "items/kidney_belt.png",
	cost = 25,
	usage = "all",
	position = "amulet",
	weight = -2
	
})
table.insert(the_list, {
	eq_effect = { id = "atlas_belt", {"effect", { apply_to = "hitpoints", increase_total = "7"}}, wt_effect_n4},
        name = _ "Atlas Belt",
        id = "atlas_belt",
        tooltip = _ "belt helps with equipment weight",
        text = _ "This large belt provides support for the lower back, and has many straps and ways to help distribute equipment weight.  Anyone can use it.  Bonus: Reduces carried weight by 4; +7 hitpoints",
        image = "icons/atlas_belt.png",
        icon = "items/atlas_belt.png",
	cost = 37,
	usage = "all",
	position = "amulet",
	weight = -4
	
})
table.insert(the_list, {
	eq_effect = { id = "fang_charm", {"effect", { apply_to = "hitpoints", increase_total = "5"}}},
        name = _ "Fang Charm",
        id = "fang_charm",
        tooltip = _ "amulets can have special effects",
        text = _ "This fang of some large beast is believed by many to grant the wearer extra strength and vitality.  The effect is most likely psychological, but maybe it is real.  Anyone can use it.  Bonus: +5 hitpoints",
        image = "icons/fang_charm.png",
        icon = "items/fang_charm.png",
	cost = 75,
	usage = "all",
	position = "amulet",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "shard_charm", {"effect", { apply_to = "hitpoints", increase_total = "5"}}, {"effect", { apply_to = "healthy"}}, {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -10, pierce = -10, arcane = -10}}}}}, 
        name = _ "Shard Charm",
        id = "shard_charm",
        tooltip = _ "amulets can have special effects",
        text = _ "This is some shimmering crystal shard on a lanyard.  Anyone can wear it, and it seems to bestow some good health on the wearer.  Bonus: +10 each blade, pierce, and arcane resistance, always resting,  and +5 hitpoints",
        image = "icons/shard_charm.png",
        icon = "items/shard_charm.png",
	cost = 125,
	usage = "all",
	position = "amulet",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "vitality_charm", {"effect", { apply_to = "hitpoints", increase_total = "3"}}, regenerate_effect
--	{"effect", { apply_to = "new_ability",  {"abilities", { { "regenerate", { value=8, id= "regenerates", name= _ "regenerates", female_name= _ "female^regenerates", description= _ "The unit will heal itself 8 HP per turn. If it is poisoned, it will remove the poison instead of healing.", affect_self="yes", poison= "cured" }}}}}}
	},
        name = _ "Vitality Charm",
        id = "vitality_charm",
        tooltip = _ "amulets can have special effects",
        text = _ "This odd amulet gives off a pleasant warmth, and seems to promote healing.  Bonus: Regeneration ability",
        image = "icons/jewelry_necklace_amber.png~CS(-10,-10,10)",
        icon = "misc/shock-charm.png",
	cost = 165,
	usage = "amulet",
	position = "amulet",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "thief_charm", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {arcane = -15, fire = -10, cold = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "3"}}, skirmisher_effect
--	{"effect", { apply_to = "new_ability",  {"abilities", { { "skirmisher", { id= "skirmisher", name= _ "skirmisher", female_name= _ "female^skirmisher", description= _ "This unit is skilled in moving past enemies quickly, and ignores all enemy Zones of Control.", affect_self="yes"}}}}}}
	},
        name = _ "Thief Charm",
        id = "thief_charm",
        tooltip = _ "amulets can have special effects",
        text = _ "This amulet clouds the mind of those around the bearer, allowing the bearer to skirt around them.  Bonus: Skirmisher ability",
        image = "icons/jewelry_necklace_amber.png~CS(-30,-30,-10)",
        icon = "misc/dark-charm.png",
	cost = 145,
	usage = "amulet",
	position = "amulet",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "herb_bag", {"effect", { apply_to = "hitpoints", increase_total = "1"}}, unpoison_effect2
	},
        name = _ "Herb Bag",
        id = "herb_bag",
        tooltip = _ "amulets can have special effects",
        text = _ "This bag of herbs has an antidote to most venoms and poisons encountered in the area.  Bonus: Cures poison on self, +1 HP",
        image = "icons/herb-bag.png",
        icon = "items/flower4.png",
	cost = 75,
	usage = "amulet",
	position = "amulet",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "ice_charm", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {fire = -50}}}} , {"effect", { apply_to = "hitpoints", increase_total = "1"}}},
        name = _ "Ice Charm",
        id = "ice_charm",
        tooltip = _ "amulets can have special effects",
        text = _ "This odd amulet is cold to the touch, absorbing heat.  Should come in handy against fire blasts. Bonus: +50 fire resistance",
        image = "icons/jewelry_necklace_amber.png~CS(-30,-20,40)",
        icon = "misc/charm.png",
	cost = 125,
	usage = "amulet",
	position = "amulet",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "thunder_amulet", {"effect", { apply_to = "attack", range = "ranged", increase_attacks = 1}}},
        name = _ "Thunder Amulet",
        id = "thunder_amulet",
        tooltip = _ "amulets can have special effects",
        text = _ "This amulet gives an extra ranged strike",
        image = "icons/necklace1.png~CS(-20,-30,40)",
        icon = "items/ankh-necklace.png~CS(20,-20,60)",
	cost = 155,
	usage = "amulet",
	position = "amulet",
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "holy_charm", {"effect", { apply_to = "attack", range = "melee", type = "blade", set_type = "arcane"}}},
        name = _ "Holy Charm",
        id = "holy_charm",
        tooltip = _ "amulets can have special effects",
        text = _ "This amulet makes blades have arcane damage type",
        image = "icons/ankh_necklace.png~GS()",
        icon = "items/ankh-necklace.png",
	cost = 105,
	usage = "all",
	position = "amulet",
	weight = 0
	
})
--------- armor ---------------
table.insert(the_list, {
	eq_effect = { id = "black_tunic", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {cold = -5, pierce = -7, arcane = 5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "4"}}, wt_effect_1},
        name = _ "Black Tunic",
        id = "black_tunic",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "There is something chilling about this dark tunic, like it has been worn to many funerals, and has absorbed some of the sorrow and death.  Bonus: +5 cold resistance, +7 pierce resistance, +4 HP.  Penalty: -5 arcane resistance",
        image = "icons/tunic_black.png",
        icon = "items/tunic_black.png",
	cost = 10,
	usage = "all",
	position = "torso",	
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "elven_tunic", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -2, blade = -2, pierce = -2, arcane = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_1},
        name = _ "Elven Tunic",
        id = "elven_tunic",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "The elves are better weavers than the humans, dwarves, or orcs.  Their tunics are not the simple cotton of the men, nor the woven hair of the orcs, it is something superior, and try as they might, the other races have failed to reverse-engineer the elven fabric.  Bonus: +2 impact resistance, +2 blade resistance, +2 pierce resistance, +5 arcane resistance, +2 HP",
        image = "icons/tunic_elven.png",
        icon = "items/tunic.png",
	cost = 30,
	usage = "all",
	position = "torso",	
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "blue_tunic", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -7, cold = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_1},
        name = _ "Blue Tunic",
        id = "blue_tunic",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "The primevalists have access to some unusual cloth of a forgotten fabric, a small gift from their lords.  It is very tough against the cut of either a blade or a cold wind, but is otherwise unremarkable but for its color, which is an usually pure blue.  Bonus: +5 cold resistance, +7 blade resistance, +2 HP",
        image = "icons/tunic_blue.png",
        icon = "items/tunic_blue.png",
	cost = 28,
	usage = "all",
	position = "torso",	
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "mage_tunic", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -5, blade = -5, pierce = -5, arcane = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "3"}}, wt_effect_1},
        name = _ "Mage Tunic",
        id = "mage_tunic",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "This tunic is made by mages, for mages.  They know their own weaknesses and have tried to address them with this charmed fabric.  Bonus: +5 each impact, blade, and pierce resistances, +5 arcane resistance, +3 HP",
        image = "icons/tunic_mage.png",
        icon = "items/mage_tunic.png",
	cost = 120,
	usage = "all",
	position = "torso",	
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "shaman_tunic", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -2, blade = -2, pierce = -6, arcane = -8}}}} , {"effect", { apply_to = "hitpoints", increase_total = "3"}}, wt_effect_1},
        name = _ "Shaman Tunic",
        id = "shaman_tunic",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "Orcish shamans have sewn charmed little stones and bones into a coarse animal hair tunic.  Though not stylish, it does offer some protection for those who cannot take advantage of heavier armor.  Bonus: +2 each impact and blade resistance, +6 pierce resistances, +8 arcane resistance, +2 HP",
        image = "icons/tunic_shaman.png",
        icon = "items/shaman_tunic.png",
	cost = 80,
	usage = "all",
	position = "torso",	
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "padded_coat", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -8, blade = -4, cold = -5, fire = 5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "3"}}, wt_effect_1},
        name = _ "Padded Coat",
        id = "padded_coat",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "This heavy coat has padding and thick cloth that softens impacts, keeps out the cold, and even offers some slight protection against cuts from fangs and blades.  It offers no protection against punctures, and can get quite uncomfortable in hot environments.  Bonus: +8 impact resistance, +4 blade resistance, +5 cold resistance, -5 fire resistance, +3 HP",
        image = "icons/padded_coat.png",
        icon = "items/padded_coat.png",
	cost = 50,
	usage = "all",
	position = "torso",	
	weight = 1
})
table.insert(the_list, {
	eq_effect = { id = "leather_armor", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -5, blade = -5, pierce = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_1},
        name = _ "Leather Armor",
        id = "leather_armor",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "This is the most basic of combat gear, but it is well worth its minimal expense.  Bonus: +5 impact resistance, +5 blade resistance, +5 pierce resistance, +2 HP",
        image = "icons/armor_leather.png",
        icon = "items/armor-leather.png",
	cost = 35,
	usage = "light_armor",
	position = "torso",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "rusty_armor", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -7, blade = -4, arcane = -10}}}} , {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_2},
        name = _ "Rusty Armor",
        id = "rusty_armor",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "This armor is rusted, rotten, and ruined.  It doesn't offer the same protection it once did, and it is especially easy to pierce the corrupted material, but the armor does still give some mundane barrier to arcane attacks.  Bonus: +7 impact, +4 blade, and +10 arcane resistances, +2 HP",
        image = "icons/armor_rusty.png",
        icon = "items/armor-rusty.png",
	cost = 15,
	usage = "light_armor",
	position = "torso",	
	weight = 2
	
})
table.insert(the_list, {
	eq_effect = { id = "dragon_armor", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {fire = -15, cold = -5, impact = -5, blade = -10, pierce = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "5"}}, wt_effect_1},
        name = _ "Dragonscale Armor",
        id = "dragon_armor",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "This is very similar to leather armor in construction, but the major outer surfaces are covered in the iridescent, scaled skin of the rare dragon.  Bonus: +15 fire, +5 cold, +5 impact resistance, +10 blade resistance, +5 pierce resistance, +5 HP",
        image = "icons/armor_dragon.png",
        icon = "items/armor-dragon.png",
	cost = 135,
	usage = "light_armor",
	position = "torso",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "scale_armor", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -8, blade = -10, pierce = -8}}}} , {"effect", { apply_to = "hitpoints", increase_total = "3"}}, wt_effect_2},
        name = _ "Scale Armor",
        id = "scale_armor",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "The leather cuirass has been fitted with thin, overlapping metal shingles. It is not chain-mail, but it is a cost-effective improvement over simple leather.   Bonus: +8 impact resistance, +10 blade resistance, +8 pierce resistance, +3 HP",
        image = "icons/cuirass_leather_studded.png",
        icon = "items/armor.png",
	cost = 55,
	usage = "light_armor",
	position = "torso",	
	weight = 2
	
})
table.insert(the_list, {
	eq_effect = { id = "assassin_armor", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -9, pierce = -7, impact = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "3"}}, wt_effect_n1},
        name = _ "Assassin Vest",
        id = "assassin_armor",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "A tight-fitting vest with steel plate sewn between the two cloth layers.  Straps and belts make a perfect fit possible for almost anyone.  Bonus: +9 blade, +7 pierce, and +5 impact resistance; reduces equipment weight by 1; +3 HP",
        image = "icons/cuirass_assassin.png",
        icon = "items/armor-assassin.png",
	cost = 95,
	usage = "all",
	position = "torso",	
	weight = -1
	
})
table.insert(the_list, {
	eq_effect = { id = "fiber_armor", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -13, fire = -13}}}} , {"effect", { apply_to = "hitpoints", increase_total = "3"}}, wt_effect_1},
        name = _ "Fiberglass Armor",
        id = "fiber_armor",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "This sturdy tunic is made of some rough, strange cloth of a very coarse thread.  It doesn't keep out the cold or provide much padding, but it is very difficult to cut and it does not burn.   Bonus: +13 blade resistance, +13 fire resistance, +3 HP",
        image = "icons/cuirass_fiber.png",
        icon = "items/armor-fiber.png",
	cost = 85,
	usage = "all",
	position = "torso",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "chain_armor", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -10, blade = -14, pierce = -8}}}} , {"effect", { apply_to = "hitpoints", increase_total = "4"}}, wt_effect_3},
        name = _ "Chainmail Tunic",
        id = "chain_armor",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "A tunic of interlocking chainlinks.  It is effective against blade slashes, but less effective against piercing attacks.   Bonus: +10 impact resistance, +14 blade resistance, +8 pierce resistance, +4 HP",
        image = "icons/armor-chain.png",
        icon = "items/armor-chain.png",
	cost = 76,
	usage = "light_armor",
	position = "torso",	
	weight = 3
	
})
table.insert(the_list, {
	eq_effect = { id = "bronze_armor", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -10, blade = -15, pierce = -10}}}} , {"effect", { apply_to = "hitpoints", increase_total = "5"}}, wt_effect_3},
        name = _ "Bronze Armor",
        id = "bronze_armor",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "Bronze is more easily produced and shaped than iron or steel.  Despite being made from the cheaper metal, this cuirass is better than leather or hide, and is frequently used by orcs.   Bonus: +10 impact resistance, +15 blade resistance, +10 pierce resistance, +5 HP",
        image = "icons/cuirass_muscled.png~CS(-5,0,-25)",
        icon = "items/armor-iron.png~CS(10,-30,-50)",
	cost = 85,
	usage = "heavy_armor",
	position = "torso",	
	weight = 3
	
})
table.insert(the_list, {
	eq_effect = { id = "iron_armor", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -15, blade = -15, pierce = -15}}}} , {"effect", { apply_to = "hitpoints", increase_total = "8"}}, wt_effect_4},
        name = _ "Iron Armor",
        id = "iron_armor",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "Sturdy iron has been formed into a protective cuirass.  This is not the best armor available, but it has a good balance between cost and effectiveness, and for that reason it is a favourite of brigands and orcish warriors.   Bonus: +15 impact resistance, +15 blade resistance, +15 pierce resistance, +8 HP",
        image = "icons/cuirass_muscled.png~CS(-5,-35,-10)",
        icon = "items/armor-iron.png",
	cost = 155,
	usage = "heavy_armor",
	position = "torso",	
	weight = 4
	
})
table.insert(the_list, {
	eq_effect = { id = "breastplate", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -20, blade = -15, pierce = -15}}}} , {"effect", { apply_to = "hitpoints", increase_total = "12"}}, wt_effect_2},
        name = _ "Breastplate",
        id = "breastplate",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "This is the best armor for those who need mobility.  It is expensive steel, and leaves plenty of weak-points, but offers good protection against a spear or axe to the chest.   Bonus: +20 impact resistance, +15 blade resistance, +15 pierce resistance, +12 HP",
        image = "icons/breastplate.png",
        icon = "items/breastplate.png",
	cost = 195,
	usage = "light_armor",
	position = "torso",	
	weight = 2
	
})
table.insert(the_list, {
	eq_effect = { id = "primeval_breastplate", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -20, blade = -22, pierce = -15, fire = -10}}}} , {"effect", { apply_to = "hitpoints", increase_total = "15"}}, wt_effect_2},
        name = _ "Primeval Breastplate",
        id = "primeval_breastplate",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "This breastplate is made from the unusual golden alloy of which the Primeval civilization made such heavy and effective use.  Bonus: +20 impact resistance, +22 blade resistance, +15 pierce resistance, +10 fire resistance, +15 HP",
        image = "icons/breastplate-golden.png",
        icon = "items/primeval_breastplate.png",
	cost = 395,
	usage = "light_armor",
	position = "torso",	
	weight = 2
	
})
table.insert(the_list, {
	eq_effect = { id = "frost_armor", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -15, blade = -22, pierce = -20, fire = -25}}}} , {"effect", { apply_to = "hitpoints", increase_total = "10"}}, wt_effect_2},
        name = _ "Frost Armor",
        id = "frost_armor",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "This rime-encrusted armor is enchanted to remain freezing cold, at least on the outer surface.  Bonus: +15 impact, +22 blade, +20 pierce, and +25 fire resistance; +10 HP",
        image = "icons/frost_armor.png",
        icon = "items/armor-frost.png",
	cost = 335,
	usage = "heavy_armor",
	position = "torso",	
	weight = 2
	
})
table.insert(the_list, {
	eq_effect = { id = "steel_armor", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -24, blade = -25, pierce = -20}}}} , {"effect", { apply_to = "hitpoints", increase_total = "15"}}, wt_effect_4},
        name = _ "Steel Armor",
        id = "steel_armor",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "This is the armor of professional fighters.  It is expensive, but offers good protection against all physical strikes.   Bonus: +24 impact resistance, +25 blade resistance, +20 pierce resistance, +15 HP",
        image = "icons/steel_armor.png",
        icon = "items/armor-iron.png~CS(10,15,20)",
	cost = 245,
	usage = "heavy_armor",
	position = "torso",	
	weight = 4
	
})
table.insert(the_list, {
	eq_effect = { id = "aegis_armor", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -40, blade = -65, pierce = -40}}}} , {"effect", { apply_to = "hitpoints", increase_total = "17"}}, wt_effect_2},
        name = _ "Aegis Armor",
        id = "aegis_armor",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "This armor bears a complicated crest of unfamiliar design.  The material of construction appears quite tough, yet it is very light.  Bonus: +40 impact resistance, +65 blade resistance, +40 pierce resistance, +17 HP",
        image = "icons/steel_armor.png~CS(25,25,30)",
        icon = "misc/aegis-armor.png",
	cost = 495,
	usage = "light_armor",
	position = "torso",	
	weight = 2
	
})
--------------------------greaves------------------------------------------
table.insert(the_list, {
	eq_effect = { id = "leather_greaves", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -4, pierce = -2}}}} , {"effect", { apply_to = "hitpoints", increase_total = "1"}}},
        name = _ "Leather Leggings",
        id = "leather_greaves",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "These simple leather coverings offer some small protection to a large and frequently targetted area of the body, without much hinderance, so almost anyone can use them.  Bonus: +4 blade resistance, +2 pierce resistance, +1 HP",
        image = "icons/greaves_leather.png",
        icon = "items/greaves-leather.png",
	cost = 21,
	usage = "all",
	position = "foot",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "wooden_greaves", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -5, blade = -5, pierce = -2}}}} , {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_1},
        name = _ "Wooden Shinguards",
        id = "wooden_greaves",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "These wooden shin-guards offer some rigid protection for the legs, and while it isn't the best armor, it is something.  Bonus: +5 blade, impact resistance, +2 pierce resistance, +2 HP",
        image = "icons/greaves_wooden.png",
        icon = "items/greaves-wooden.png",
	cost = 29,
	usage = "light_armor",
	position = "foot",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "serpent_greaves", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -2}}}} , {"effect", { apply_to = "movement_costs", replace = "no",{"movement_costs", {shallow_water = -1, swamp_water = -1}}}}, {"effect", { apply_to = "hitpoints", increase_total = "1"}} },
        name = _ "Sea-Serpent Skins",
        id = "serpent_greaves",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "Slick, scaled skin of sea-snakes have been fashioned into a sort of greaves that allow the wearer to pass walk through water without the usual drag.  Bonus: +2 blade resistance, -1 swamp and shallow water movement cost, +1 HP",
        image = "icons/greaves_serpent.png",
        icon = "items/greaves-serpent.png",
	cost = 125,
	usage = "all",
	position = "foot",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "brass_greaves", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -3, blade = -6, pierce = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_2},
        name = _ "Bronze Greaves",
        id = "brass_greaves",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "Easily crafted and not particularly heavy, these leg-guards can be worn by anyone with some physical strength without being a hinderance.  Bonus: +3 impact, +6 blade, +5 pierce resistances; +2 HP",
        image = "icons/greaves_brass.png",
        icon = "items/greaves-brass.png",
	cost = 39,
	usage = "light_armor",
	position = "foot",	
	weight = 2
	
})
table.insert(the_list, {
	eq_effect = { id = "steel_greaves", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {pierce = -8, blade = -10, pierce = -8}}}} , {"effect", { apply_to = "hitpoints", increase_total = "5"}}, wt_effect_2},
        name = _ "Steel Greaves",
        id = "steel_greaves",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "The steel leg protection offered is substantial, but is does come at a price, so that only those capable of using heavy armor can use them.  Bonus: +8 impact, +10 blade, +8 pierce resistances; +5 HP",
        image = "icons/greaves.png",
        icon = "items/greaves-steel.png",
	cost = 80,
	usage = "heavy_armor",
	position = "foot",	
	weight = 2
	
})
table.insert(the_list, {
	eq_effect = { id = "primeval_greaves", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {impact = -10, blade = -10, pierce = -10}}}} , {"effect", { apply_to = "hitpoints", increase_total = "6"}}, wt_effect_1},
        name = _ "Primeval Greaves",
        id = "primeval_greaves",
        tooltip = _ "armor offers broad protection to physical attacks",
        text = _ "The golden alloy protects the legs as well as the steel greaves, but is not nearly as heavy.  Bonus: +10 impact, +10 blade, +10 pierce resistances; +6 HP",
        image = "icons/greaves-golden.png",
        icon = "items/greaves-primeval.png",
	cost = 100,
	usage = "light_armor",
	position = "foot",	
	weight = 1
	
})
--------------------------boots------------------------------------------
-- what happens if you subtract movement cost down to zero?
table.insert(the_list, {
	eq_effect = { id = "boot_cleats", {"effect", { apply_to = "movement_costs", replace = "no",{"movement_costs", {mountains = -1}}}}, wt_effect_1},
        name = _ "Boot Cleat",
        id = "boot_cleat",
        tooltip = _ "Footwear usually affects movement",
        text = _ "These cleats allow you to better keep your footing on steep terrain, you won't have to worry about the ice or pebbles so much.  Reduces mountains movement costs by 1.",
        image = "icons/boots_cleats.png",
        icon = "misc/boots.png~CS(20,10,30)",
	cost = 95,
	usage = "all",
	position = "foot",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "officer_boots", {"effect", { apply_to = "hitpoints", increase_total = "2"}}, wt_effect_n2 },
        name = _ "Officer Boots",
        id = "officer_boots",
        tooltip = _ "Footwear usually affects movement",
        text = _ "Made for Royal officers, but treasured by all, these boots offer good support for the ankle and have better treads than any other available footwear.  Bonus: reduces equipment burden by 2; +2 HP",
        image = "icons/boots_officer.png",
        icon = "misc/officer_boots.png",
	cost = 125,
	usage = "all",
	position = "foot",	
	weight = -2
	
})
table.insert(the_list, {
	eq_effect = { id = "leather_boots", {"effect", { apply_to = "movement_costs", replace = "no",{"movement_costs", {forest = -1}}}}, wt_effect_1 },
        name = _ "Fine Leather Boots",
        id = "leather_boots",
        tooltip = _ "Footwear usually affects movement",
        text = _ "These fine boots offer the same protection as your standard clodhopper, but they are much more flexible and light.  Reduces forest movement costs by 1.",
        image = "icons/boots_elven.png",
        icon = "misc/boots.png",
	cost = 125,
	usage = "all",
	position = "foot",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "miner_boots", {"effect", { apply_to = "movement_costs", replace = "no",{"movement_costs", {cave = -1}}}}, wt_effect_1 },
        name = _ "Miner Boots",
        id = "miner_boots",
        tooltip = _ "Footwear usually affects movement",
        text = _ "These boots have just the right amount of support and protection to avoid injury in the dark, rocky caverns.  Reduces cave movement costs by 1.",
        image = "icons/boots_miner.png",
        icon = "misc/boots.png~CS(-20,-20,-25)",
	cost = 135,
	usage = "all",
	position = "foot",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "primeval_boots", {"effect", { apply_to = "resistance", replace = "no", {"resistance", {blade = -5, pierce = -5}}}} , {"effect", { apply_to = "movement_costs", replace = "no", {"movement_costs", {hills = -1, frozen = -1, cave = -1}}}}, wt_effect_1 },
        name = _ "Primeval Sandals",
        id = "primeval_boots",
        tooltip = _ "Footwear usually affects movement",
        text = _ "These sandals are marvals of footwear engineering.  Reduces cave, frozen, and hill movement costs by 1, gives +5 blade and +5 pierce resistances bonus",
        image = "icons/sandals-golden.png",
        icon = "items/sandals.png",
	cost = 235,
	usage = "all",
	position = "foot",	
	weight = 1
	
})
----------------------------axes-------------------------------------------------------------------
table.insert(the_list, {
	eq_effect = { id = "rusty_axe", {"effect", { apply_to = "attack", range = "melee", type = "blade", {"set_specials", {mode = "replace", 							
							{"poison", {id="poison", name= _ "poison", 
							description= _ "This attack poisons living targets. Poisoned units lose 8 HP every turn until they are cured or are reduced to 1 HP. Poison can not, of itself, kill a unit."
							}} 
							}} }}, wt_effect_1}, 
        name = _ "Rusty Axe",
        id = "rusty_axe",
        tooltip = _ "Supplements for the axe attacks",
        text = _ "This axe blade covered in rust and filth.  Awkward to use, but imparts poison weapon special",
        image = "icons/axe-rusty.png",
        icon = "items/axe.png~CS(-10,-25,-30)",
	cost = 10,
	usage = "axe",
	position = "weapon",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "obsidian_axe", {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_damage = "1", increase_parry = "5"}}, wt_effect_1 },
        name = _ "Obsidian Axe",
        id = "obsidian_axe",
        tooltip = _ "Supplements for the axe attacks",
        text = _ "This axe is a crude orcish instrument, but it is sharper and lighter than what they usually use.  Increases axe damage by 1, increase parry by 5 percent",
        image = "icons/axe-obsidian.png",
        icon = "items/obsidian_axe.png",
	cost = 60,
	usage = "axe",
	position = "weapon",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "steel_axe", {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_damage = "2"}}, wt_effect_1 },
        name = _ "Steel Edge",
        id = "steel_axe",
        tooltip = _ "Supplements for the axe attacks",
        text = _ "This axe blade is made with imported steel, it holds its edge much better than the cheap iron things most of you use.  Increases axe damage by 2",
        image = "attacks/axe.png~CS(-10,0,10)",
        icon = "items/axe.png",
	cost = 130,
	usage = "axe",
	position = "weapon",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "silver_axe", {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_damage = "2"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_accuracy = "5"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_parry = "5"}} },
        name = _ "Silver Axe",
        id = "silver_axe",
        tooltip = _ "Supplements for the sword attacks",
        text = _ "This blade surely isn't really made of silver, but it is very shiny.  It is also very sharp.  Increases damage by 2.  Increases accuracy and parry by 5 percent",
        image = "attacks/axe.png~GS()",
        icon = "items/axe-silver.png",
	cost = 200,
	usage = "axe",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "ice_gem", {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_damage = "3"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", set_type = "cold"}} },
        name = _ "Ice Axe Inlay",
        id = "ice_gem",
        tooltip = _ "Supplements for the axe attacks",
        text = _ "This blue gem can be fit to the hilt of an axe, increasing damage by 3 and changes attack type to cold.",
        image = "icons/gem_ice_axe.png",
        icon = "items/ice_gem.png",
	cost = 215,
	usage = "axe",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "ancient_axe", {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_damage = "4"}}, {"effect", { apply_to = "resistance", replace = "no",{"resistance", {arcane = -15}}}}  },
        name = _ "Ancient Edge",
        id = "ancient_axe",
        tooltip = _ "Supplements for the axe attacks",
        text = _ "This axe blade is made with some alloy of a forgotten technology.  Increases axe damage by 4, increase arcane defense 15 percent",
        image = "attacks/axe.png~CS(10,-30,20)",
        icon = "items/axe.png~CS(10,-30,20)",
	cost = 330,
	usage = "axe",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "primeval_axe", {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_damage = "4"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_accuracy = "10"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_parry = "10"}}, wt_effect_1 },
        name = _ "Great Primeval Axe",
        id = "primeval_axe",
        tooltip = _ "Supplements for the sword attacks",
        text = _ "This blade is an elite version of the standard Primeval warrior axe.  It is very heavy.  Increases damage by 4.  Increases accuracy and parry by 10 percent",
        image = "icons/axe-golden.png",
        icon = "items/axe-primeval.png",
	cost = 400,
	usage = "axe",
	position = "weapon",	
	weight = 1
	
})


----------------------------sword-------------------------------------------------------------------
table.insert(the_list, {
	eq_effect = { id = "steel_blade", {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_damage = "2"}}, wt_effect_1 },
        name = _ "Steel Blade",
        id = "steel_blade",
        tooltip = _ "Supplements for the sword attacks",
        text = _ "This fine blade is made with imported steel, it holds its edge much better than the cheap iron things most of you use.  Increases sword damage by 2",
        image = "attacks/sword-steel.png",
        icon = "items/sword.png",
	cost = 130,
	usage = "sword",
	position = "weapon",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "silver_sword", {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_damage = "2"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_accuracy = "5"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_parry = "5"}}, wt_effect_1 },
        name = _ "Silver Sword",
        id = "silver_sword",
        tooltip = _ "Supplements for the sword attacks",
        text = _ "This blade surely isn't really made of silver, but it is very shiny.  It is also very sharp.  Increases damage by 2.  Increases accuracy and parry by 5 percent",
        image = "attacks/scimitar.png~GS()",
        icon = "items/sword-silver.png",
	cost = 200,
	usage = "sword",
	position = "weapon",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "ice_hilt", {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_damage = "3"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", set_type = "cold"}} },
        name = _ "Ice Hilt",
        id = "ice_hilt",
        tooltip = _ "Supplements for the sword attacks",
        text = _ "This blue gem can be fit to the hilt of a sword, increasing damage by 3 and changes attack type to cold.",
        image = "icons/jewelry_necklace_amber.png~CS(-45,-5,80)",
        icon = "items/ball-gem1.png",
	cost = 210,
	usage = "sword",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "ice_blade", {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_damage = "7"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", set_type = "cold"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", set_icon="misc/ice_blade.png"}}, wt_effect_1 },
        name = _ "Ice Blade",
        id = "ice_blade",
        tooltip = _ "Supplements for the sword attacks",
        text = _ "This frosty blade is strangely cold, just seems to suck the heat out of whatever it touches.  Increases sword damage by 7, changes attack type to cold.",
        image = "misc/ice_blade.png",
        icon = "items/sword6.png",
	cost = 400,
	usage = "sword",
	position = "weapon",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "revanche_blade", {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_damage = "7"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", set_type = "fire"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", set_icon="attacks/sword-flaming.png"}}, wt_effect_1 },
        name = _ "Revanche Blade",
        id = "revanche_blade",
        tooltip = _ "Supplements for the sword attacks",
        text = "_ This blade is a manifestation of the desire for revenge.  Increases sword damage by 7, changes attack type to fire.",
        image = "attacks/sword-flaming.png",
        icon = "items/flame-sword.png",
	cost = 400,
	usage = "sword",
	position = "weapon",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "dark_blade", {"effect", { apply_to = "attack", range = "melee", type = "blade", increase_damage = "7"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", set_type = "arcane"}}, {"effect", { apply_to = "attack", range = "melee", type = "blade", set_icon="attacks/baneblade.png"}}, wt_effect_1 },
        name = _ "Dark Blade",
        id = "dark_blade",
        tooltip = _ "Supplements for the sword attacks",
        text = _ "This sinister-looking blade is made from some dark material and does not really seem to be of this world.  Increases sword damage by 7, changes attack type to arcane.",
        image = "attacks/baneblade.png",
        icon = "items/sword-dark.png",
	cost = 400,
	usage = "sword",
	position = "weapon",	
	weight = 1
	
})
----------------------------spears-------------------------------------------------------------------
table.insert(the_list, {
	eq_effect = { id = "obsidian_spear", {"effect", { apply_to = "attack", range = "melee", type = "pierce", increase_damage = "1", increase_parry = "5"}}},
        name = _ "Obsidian Spear",
        id = "obsidian_spear",
        tooltip = _ "Supplements for the spear attacks",
        text = _ "This spear is a crude orcish instrument, but it is sharper and lighter than what they usually use.  Increases spear damage by 1, increase parry by 5 percent",
        image = "icons/spear-obsidian.png",
        icon = "items/obsidian_spear.png",
	cost = 60,
	usage = "spear",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "steel_spear", {"effect", { apply_to = "attack", name = "spear", increase_damage = "2"}}, wt_effect_1 },
        name = _ "Steelpoint Spear",
        id = "steel_spear",
        tooltip = _ "Supplements for the spear attacks",
        text = _ "These fine steel spearheads can deliver a more deadly punch than the brittle iron or stone points usually used.  Increases spear damage by 2",
        image = "attacks/pike.png",
        icon = "items/spear1.png",
	cost = 105,
	usage = "spear",
	position = "weapon",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "royal_spear", {"effect", { apply_to = "attack", name = "spear", increase_damage = "3"}}, wt_effect_1 },
        name = _ "Royal Spear",
        id = "royal_spear",
        tooltip = _ "Supplements for the spear attacks",
        text = _ "A shiny, well-balanced pike.  Increases spear damage by 3",
        image = "attacks/pike.png~CS(-5,0,8)",
        icon = "items/spear3.png",
	cost = 215,
	usage = "spear",
	position = "weapon",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "dragon_spear", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {fire = -5, cold = -5}}}} , {"effect", { apply_to = "attack", name = "spear", increase_damage = "4"}} },
        name = _ "Dragon Spear",
        id = "dragon_spear",
        tooltip = _ "Supplements for the spear attacks",
        text = _ "The spearhead is made of some sort of bone, and the shaft has a scale-like pattern which makes this odd spear seem fragile, but it is light and sturdy.  Increases spear damage by 4; increases fire and cold resistance by 5 percent.",
        image = "attacks/pike.png~CS(-20,10,-5)",
        icon = "items/spear4.png",
	cost = 365,
	usage = "spear",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "sun_spear", illuminates_halo, illuminates_effect, {"effect", { apply_to = "resistance", replace = "no",{"resistance", {arcane = -10, cold = -10}}}} , 
	{"effect", { apply_to = "attack", name = "spear", increase_damage = "5"}}  },
        name = _ "Sun-Beam Spear",
        id = "sun_spear",
        tooltip = _ "Supplements for the spear attacks",
        text = _ "This radiant pike appears to be made of gold, though that is probably from the golden sunlight that shines from the spearhead.  Bonus: +5 spear damage, +10 cold and arcane resistance, illuminates.",
        image = "icons/sun_pike.png",
        icon = "items/spear5.png",
	cost = 405,
	usage = "spear",
	position = "weapon",	
	weight = 0
	
})
----------------------------bows-------------------------------------------------------------------
table.insert(the_list, {
	eq_effect = { id = "poison_arrows", {"effect", { apply_to = "attack", name = "bow", poison_special}} },
        name = _ "Poison Arrows",
        id = "poison_arrows",
        tooltip = _ "Supplements for the bow attacks",
        text = _ "These arrows have small feather barbs nea the head, and have been soaked in the toxin commonly used by orcs.  Bonus: Grants poison ability",
        image = "icons/bow-poison.png",
        icon = "items/bow.png",
	cost = 100,
	usage = "bow",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "steel_arrows", {"effect", { apply_to = "attack", name = "bow", increase_damage = "2"}} },
        name = _ "Steel Arrows",
        id = "steel_arrows",
        tooltip = _ "Supplements for the bow attacks",
        text = _ "These fine steel arrowheads can deliver a more deadly punch than those brittle iron things you usually use.  Increases bow damage by 2",
        image = "attacks/bow-short-reinforced.png",
        icon = "items/bow.png",
	cost = 125,
	usage = "bow",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "silver_arrows", {"effect", { apply_to = "attack", name = "bow", increase_accuracy = "10"}} },
        name = _ "Silver Arrows",
        id = "silver_arrows",
        tooltip = _ "Supplements for the bow attacks",
        text = "These sleek silver arrows are perfectly balanced, much better than the usual crude things used by humans and orcs.  Increases bow accuracy by 10",
        image = "icons/bow-silver.png",
        icon = "items/bow.png~CS(20,30,30)",
	cost = 160,
	usage = "bow",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "sky_arrows", {"effect", { apply_to = "attack", name = "bow", increase_damage = "3", firststrike_special}} },
        name = _ "Sky Arrows",
        id = "sky_arrows",
        tooltip = _ "Supplements for the bow attacks",
        text = "These odd crystalline arrows are well balanced and razor sharp, but the special thing about them is that they seem to be less affected by the wind and air, extending their effective range.  Bonus:  Increases bow damage by 3, Grants First Strike ability.",
        image = "icons/bow-sky.png",
        icon = "items/bow.png~CS(-10,20,50)",
	cost = 120,
	usage = "bow",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "starburst_arrows", {"effect", { apply_to = "new_attack", name = "starburst", description = "starburst", range = "ranged", type = "arcane", damage = 13, number = 3}} },
        name = _ "Starburst Arrows",
        id = "starburst_arrows",
        tooltip = _ "Supplements for the bow attacks",
        text = _ "The soft metal of these arrowheads is impregnated with a shards of a very rare crystal, causing them to explode upon impact, with an otherworldly flame.  Grants a new arcane attack.",
        image = "attacks/bow-short-reinforced.png~BLIT(halo/elven/ice-halo1.png~CROP(0,0,47,49),11,9)",
        icon = "items/bow-crystal.png",
	cost = 255,
	usage = "bow",
	position = "weapon",	
	weight = 0
	
})
-----------------------------random weapons--------------------------------------------------------------
-- still need to add missile animation
table.insert(the_list, {
	eq_effect = { id = "sling_found", {"effect", { apply_to = "new_attack", name = "sling_found", description = "sling", range = "ranged", type = "impact", damage = 6, number = 2, icon = "attacks/sling.png"}} },
        name = _ "Sling",
        id = "sling_found",
        tooltip = _ "Weapon for anyone to use",
        text = _ "A small, but effective weapon that can be used by almost anyone, with a little practice.  Grants a new ranged impact attack.",
        image = "attacks/sling.png",
        icon = "items/sling1.png",
	cost = 15,
	usage = "all",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "club_found", {"effect", { apply_to = "new_attack", name = "club_found", description = "club", range = "melee", type = "impact", damage = 8, number = 2, icon = "attacks/club-found.png"}} },
        name = _ "Club",
        id = "club_found",
        tooltip = _ "Weapon for anyone to use",
        text = _ "A small, but effective weapon that can be used by almost anyone, with a little practice.  Grants a new melee impact attack.",
        image = "attacks/club-found.png",
        icon = "items/club-found.png",
	cost = 15,
	usage = "all",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "club_torch", illuminates_effect, illuminates_halo, {"effect", { apply_to = "new_attack", name = "club_torch", description = "torch", range = "melee", type = "fire", damage = 10, number = 2, icon = "attacks/torch.png"}} },
        name = _ "Torch",
        id = "club_torch",
        tooltip = _ "Weapon for anyone to use",
        text = _ "A dense wooden stick with flammable material wrapped around one end.  Grants a new melee fire attack, and illuminates.",
        image = "attacks/torch.png",
        icon = "items/torch.png",
	cost = 18,
	usage = "all",
	position = "weapon",	
	weight = 0
	
})
-----------------------------daggers--------------------------------------------------------------
table.insert(the_list, {
	eq_effect = { id = "small_dagger", {"effect", { apply_to = "new_attack", name = "small_dagger", description = "small dagger", range = "melee", type = "blade", damage = 4, number = 3, icon = "attacks/dagger-curved.png"}} },
        name = _ "Small Dagger",
        id = "small_dagger",
        tooltip = _ "Weapon for anyone to use",
        text = _ "A small, but effective weapon that can be used by almost anyone with a free hand.  Grants a new blade attack.",
        image = "attacks/dagger-curved.png",
        icon = "items/dagger.png",
	cost = 25,
	usage = "all",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "orc_dagger", {"effect", { apply_to = "new_attack", name = "orc_dagger", description = "orcish dagger", range = "melee", type = "blade", damage = 7, number = 2, icon = "attacks/dagger-orcish.png"}} },
        name = _ "Orcish Dagger",
        id = "orc_dagger",
        tooltip = _ "Weapon for anyone to use",
        text = _ "A crude, but vicious weapon that can be used by almost anyone with a free hand.  Grants a new blade attack.",
        image = "attacks/dagger-orcish.png",
        icon = "items/dagger.png~CS(-10,0,-20)",
	cost = 30,
	usage = "all",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "silver_dagger", {"effect", { apply_to = "new_attack", name = "silver_dagger", description = "small dagger", range = "melee", type = "blade", damage = 4, number = 4, icon = "attacks/dagger-human.png"}} },
        name = _ "Silver Dagger",
        id = "silver_dagger",
        tooltip = _ "Weapon for anyone to use",
        text = _ "A small, shiny dagger that seems to float through the air.  It can be used by almost anyone with a free hand.  Grants a new blade attack.",
        image = "attacks/dagger-human.png~CS(5,5,5)",
        icon = "items/silver_dagger.png",
	cost = 125,
	usage = "all",
	position = "weapon",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "poison_dagger", {"effect", { apply_to = "new_attack", name = "poison_dagger", description = "posion dagger", range = "melee", type = "blade", damage = 3, number = 2, icon = "attacks/dagger-undead.png",
							{"specials", {{"poison", {id="poison", name= _ "poison", 
							description= _ "This attack poisons living targets. Poisoned units lose 8 HP every turn until they are cured or are reduced to 1 HP. Poison can not, of itself, kill a unit."
							}}}}
									}} },
        name = _ "Poison Dagger",
        id = "poison_dagger",
        tooltip = _ "Weapon for anyone to use",
        text = _ "A small blade with a channel for poison to flow from a reserviour in the handle.  Grants a new blade attack, with poison special",
        image = "attacks/dagger-undead.png",
        icon = "items/poison_dagger.png",
	cost = 125,
	usage = "all",
	position = "weapon",	
	weight = 0
	
})
-------------------------------for-dogs-----------------------------
table.insert(the_list, {
	eq_effect = { id = "leather_collar", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -10}}}} , {"effect", { apply_to = "hitpoints", increase_total = "4"}}},
        name = _ "Leather Collar",
        id = "leather_collar",
        tooltip = _ "collars can protect a canine's neck",
        text = _ "This collar gives some additional protection to the neck of a dog or wolf, without encumbering the animal.   Bonus: +10 blade resistance, +4 HP",
        image = "icons/collar.png",
        icon = "items/collar.png",
	cost = 24,
	usage = "dog",
	position = "neck",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "studded_collar", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -15, impact = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "7"}}},
        name = _ "Studded Collar",
        id = "studded_collar",
        tooltip = _ "collars can protect a canine's neck",
        text = _ "This collar has metal studs in the leather, that gives more protection to the neck of a dog or wolf than leather alone, and still does not encumber the animal.   Bonus: +15 blade, +5 impact resistance, +7 HP",
        image = "icons/collar2.png",
        icon = "items/collar2.png",
	cost = 46,
	usage = "dog",
	position = "neck",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "diamond_collar", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -10, impact = -5, arcane = -10, fire = -10}}}} , {"effect", { apply_to = "hitpoints", increase_total = "10"}}},
        name = _ "Diamond Collar",
        id = "diamond_collar",
        tooltip = _ "collars can protect a canine's neck",
        text = _ "This collar has metal studs in the leather, that gives more protection to the neck of a dog or wolf than leather alone, and still does not encumber the animal.   Bonus: +10 blade, +5 impact, +10 arcane, +10 fire resistance, +10 HP",
        image = "icons/collar3.png",
        icon = "items/collar3.png",
	cost = 120,
	usage = "dog",
	position = "neck",	
	weight = 0
	
})
table.insert(the_list, {
	eq_effect = { id = "leather_vest", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -5, pierce = -5, impact = -5}}}} , {"effect", { apply_to = "hitpoints", increase_total = "5"}}, wt_effect_1},
        name = _ "Leather Vest",
        id = "leather_vest",
        tooltip = _ "these vests are body armor for dogs",
        text = _ "This vest is body armor for dogs, it offers some protection without restricting movement.   Bonus: +5 blade, +5 pierce, +5 impact resistance, +5 HP",
        image = "icons/leather_vest.png",
        icon = "items/leather_vest.png",
	cost = 38,
	usage = "dog",
	position = "torso",	
	weight = 1
	
})
table.insert(the_list, {
	eq_effect = { id = "brigandine_vest", {"effect", { apply_to = "resistance", replace = "no",{"resistance", {blade = -5, pierce = -10, impact = -10}}}} , {"effect", { apply_to = "hitpoints", increase_total = "10"}}, wt_effect_2},
        name = _ "Brigandine Vest",
        id = "brigandine_vest",
        tooltip = _ "these vests are body armor for dogs",
        text = _ "This vest is body armor for dogs, it offers some protection without restricting movement.   Bonus: +5 blade, +10 pierce, +10 impact resistance, +10 HP",
        image = "icons/brigandine_vest.png",
        icon = "items/brigandine_vest.png",
	cost = 75,
	usage = "dog",
	position = "torso",	
	weight = 2
	
})



-----------------------------------------------------------------------------------------------

-- to catalogue everything...  To Do.  Done?

for k,v in pairs(equipment_list.the_list) do
        if(equipment_list.list_by_name[v.name] ~= nil) then
                        error("duplicate names in equipment_list: " .. v.name)
        end
        equipment_list.list_by_name[v.name] = v
end
                                        
return equipment_list

