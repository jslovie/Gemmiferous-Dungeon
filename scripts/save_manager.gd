extends Node


const SAVE_PATH = "user://"
const RESOURCE_PATH = "user://resources/"
var test_resource_name = "HealthPotion.tres"

#Savefile
var save_file = false


#Autosave
var autosave_data = {
	player_data = {
		type = 0,
		type_action1x = 0,
		type_action1y = 0,
		type_action2x = 0,
		type_action2y = 0,
		type_action3x = 0,
		type_action3y = 0,
		health = 0,
		max_health = 0,
		shield = 0,
		shield_load = 0,
		coins = 0,
		},
	gems = {
		red_gem = 0,
		green_gem = 0,
		blue_gem = 0,
		yellow_gem = 0,
	},
	materials = {
		wood = 0,
		stone = 0,
		iron = 0,
	},
}

#Savefile
var savefile_data = {
	player_data = {
		save_file = false,
		barbarian_unlocked = false,
		total_coins = 0,
		upgraded_axe_damage_x = 0,
		upgraded_axe_damage_y = 0,
		upgraded_mace_damage_x = 0,
		upgraded_mace_damage_y = 0,
		upgraded_sword_damage_x = 0,
		upgraded_sword_damage_y = 0,
		upgraded_bow_damage_x = 0,
		upgraded_bow_damage_y = 0,
	},
	gems = {
		total_red_gem = 0,
		total_green_gem = 0,
		total_blue_gem = 0,
		total_yellow_gem = 0,
	},
	materials = {
		total_wood = 0,
		total_stone = 0,
		total_iron = 0,
	},
	village = {
		#Buildings levels
		manor_lvl = 0,
		tavern_lvl = 1,
		weaponsmith_lvl = 1,
		armourer_lvl = 1,
		sorcerer_lvl = 1,
		woodcutters_lvl = 1,
		stone_mine_lvl = 1,
		iron_mine_lvl = 1,
		rathaus_lvl = 1,
		farm_lvl = 1,
		build_houses = 0,
		#Buildings state
		church_repaired = false,
		tavern_repaired = false,
		weaponsmith_repaired = false,
		armourer_repaired = false,
		sorcerer_repaired = false,
		town_square_repaired = false,
		farm_repaired = false,
		houses_repaired = false,
		left_watchtower_repaired = false,
		right_watchtower_repaired = false,
		woodcutters_camp_repaired = false,
		stone_mine_repaired = false,
		iron_mine_repaired = false,
		lamps_built = false,
		campfire_built = false,
		#Items
		axe_item_lvl = 0,
		mace_item_lvl = 0,
		sword_item_lvl = 0,
		bow_item_lvl = 0,
	},
}

#Resourcesaver
func _ready():
	verify_save_directory(RESOURCE_PATH)
	
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)

func save_resource(resource, resource_name):
	ResourceSaver.save(resource, RESOURCE_PATH + resource_name)

func load_resource(resource_name):
	return ResourceLoader.load(RESOURCE_PATH + resource_name)

func remove_resources():
	var dir = DirAccess.open(RESOURCE_PATH)
	for file in dir.get_files():
		dir.remove(file)

#Savefile
func update_player_data_savefile():
	var p : Player = PlayerManager.player
	var v = VillageManager
	savefile_data.player_data.save_file = save_file
	savefile_data.player_data.upgraded_axe_damage_x = p.upgraded_axe_damage.x
	savefile_data.player_data.upgraded_axe_damage_y = p.upgraded_axe_damage.y
	savefile_data.player_data.upgraded_mace_damage_x = p.upgraded_mace_damage.x
	savefile_data.player_data.upgraded_mace_damage_y = p.upgraded_mace_damage.y
	savefile_data.player_data.upgraded_sword_damage_x = p.upgraded_sword_damage.x
	savefile_data.player_data.upgraded_sword_damage_y = p.upgraded_sword_damage.y
	savefile_data.player_data.upgraded_bow_damage_x = p.upgraded_bow_damage.x
	savefile_data.player_data.upgraded_bow_damage_y = p.upgraded_bow_damage.y
	savefile_data.player_data.barbarian_unlocked = p.barbarian_unlocked
	savefile_data.player_data.total_coins = p.total_coins
	savefile_data.gems.total_red_gem = p.total_red_gem
	savefile_data.gems.total_green_gem = p.total_green_gem
	savefile_data.gems.total_blue_gem = p.total_blue_gem
	savefile_data.gems.total_yellow_gem = p.total_yellow_gem
	savefile_data.materials.total_wood = p.total_wood
	savefile_data.materials.total_stone = p.total_stone
	savefile_data.materials.total_iron = p.total_iron
	savefile_data.village.manor_lvl = v.manor_lvl
	savefile_data.village.tavern_lvl = v.tavern_lvl
	savefile_data.village.weaponsmith_lvl = v.weaponsmith_lvl
	savefile_data.village.armourer_lvl = v.armourer_lvl
	savefile_data.village.sorcerer_lvl = v.sorcerer_lvl
	savefile_data.village.woodcutters_lvl = v.woodcutters_lvl
	savefile_data.village.stone_mine_lvl = v.stone_mine_lvl
	savefile_data.village.iron_mine_lvl = v.iron_mine_lvl
	savefile_data.village.rathaus_lvl = v.rathaus_lvl
	savefile_data.village.farm_lvl = v.farm_lvl
	savefile_data.village.build_houses = v.build_houses
	savefile_data.village.church_repaired = v.church_repaired
	savefile_data.village.tavern_repaired = v.tavern_repaired
	savefile_data.village.weaponsmith_repaired = v.weaponsmith_repaired
	savefile_data.village.armourer_repaired = v.armourer_repaired
	savefile_data.village.sorcerer_repaired = v.sorcerer_repaired
	savefile_data.village.town_square_repaired = v.town_square_repaired
	savefile_data.village.farm_repaired = v.farm_repaired
	savefile_data.village.houses_repaired = v.houses_repaired
	savefile_data.village.left_watchtower_repaired = v.left_watchtower_repaired
	savefile_data.village.right_watchtower_repaired = v.right_watchtower_repaired
	savefile_data.village.woodcutters_camp_repaired = v.woodcutters_camp_repaired
	savefile_data.village.stone_mine_repaired = v.stone_mine_repaired
	savefile_data.village.iron_mine_repaired = v.iron_mine_repaired
	savefile_data.village.lamps_built = v.lamps_built
	savefile_data.village.campfire_built = v.campfire_built
	savefile_data.village.axe_item_lvl = v.axe_item_lvl
	savefile_data.village.mace_item_lvl = v.mace_item_lvl
	savefile_data.village.sword_item_lvl = v.sword_item_lvl
	savefile_data.village.bow_item_lvl = v.bow_item_lvl
	
func reset_savefile():
	savefile_data = {
	player_data = {
		save_file = false,
		total_coins = 0,
		upgraded_axe_damage_x = 0,
		upgraded_axe_damage_y = 0,
		upgraded_mace_damage_x = 0,
		upgraded_mace_damage_y = 0,
		upgraded_sword_damage_x = 0,
		upgraded_sword_damage_y = 0,
		upgraded_bow_damage_x = 0,
		upgraded_bow_damage_y = 0,
	},
	gems = {
		total_red_gem = 0,
		total_green_gem = 0,
		total_blue_gem = 0,
		total_yellow_gem = 0,
	},
	materials = {
		total_wood = 0,
		total_stone = 0,
		total_iron = 0,
	},
	village = {
		#Buildings levels
		manor_lvl = 0,
		tavern_lvl = 1,
		weaponsmith_lvl = 1,
		armourer_lvl = 1,
		sorcerer_lvl = 1,
		woodcutters_lvl = 1,
		stone_mine_lvl = 1,
		iron_mine_lvl = 1,
		rathaus_lvl = 1,
		farm_lvl = 1,
		build_houses = 0,
		#Buildings state
		church_repaired = false,
		tavern_repaired = false,
		weaponsmith_repaired = false,
		armourer_repaired = false,
		sorcerer_repaired = false,
		town_square_repaired = false,
		farm_repaired = false,
		houses_repaired = false,
		left_watchtower_repaired = false,
		right_watchtower_repaired = false,
		woodcutters_camp_repaired = false,
		stone_mine_repaired = false,
		iron_mine_repaired = false,
		lamps_built = false,
		campfire_built = false,
		#Items
		axe_item_lvl = 0,
		mace_item_lvl = 0,
		sword_item_lvl = 0,
		bow_item_lvl = 0,
	},
}



#Autosave
func update_player_data_autosave():
	var p : Player = PlayerManager.player
	autosave_data.player_data.type = p.type
	autosave_data.player_data.type_action1x = p.type_action1.x
	autosave_data.player_data.type_action1y = p.type_action1.y
	autosave_data.player_data.type_action2x = p.type_action2.x
	autosave_data.player_data.type_action2y = p.type_action2.y
	autosave_data.player_data.type_action3x = p.type_action3.x
	autosave_data.player_data.type_action3y = p.type_action3.y
	autosave_data.player_data.health = p.health
	autosave_data.player_data.max_health = p.max_health
	autosave_data.player_data.shield = p.shield
	autosave_data.player_data.shield_load = p.shield_load
	autosave_data.player_data.coins = p.coins
	autosave_data.gems.red_gem = p.red_gem
	autosave_data.gems.green_gem = p.green_gem
	autosave_data.gems.blue_gem = p.blue_gem
	autosave_data.gems.yellow_gem = p.yellow_gem
	autosave_data.materials.wood = p.wood
	autosave_data.materials.stone = p.stone
	autosave_data.materials.iron = p.iron
	
func add_persistent_value(value):
	if check_persistent_value(value) == false:
		autosave_data.persistence.append(value)
	pass

func check_persistent_value(value):
	var p = autosave_data.persistence as Array
	return p.has(value)

func autosave():
	update_player_data_autosave()
	var file := FileAccess.open(SAVE_PATH + "autosave.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(autosave_data)
	file.store_line(save_json)
	
func remove_autosave():
	DirAccess.remove_absolute(SAVE_PATH + "autosave.sav")

func remove_savefile():
	DirAccess.remove_absolute(SAVE_PATH + "savefile.sav")

func savefilesave():
	update_player_data_savefile()
	var file := FileAccess.open(SAVE_PATH + "savefile.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(savefile_data)
	file.store_line(save_json)

func get_savefile_file():
	return FileAccess.open(SAVE_PATH + "savefile.sav", FileAccess.READ)

func get_autosave_file():
	return FileAccess.open(SAVE_PATH + "autosave.sav", FileAccess.READ)

func load_autosave():
	var file = get_autosave_file()
	var json = JSON.new()
	json.parse(file.get_line())
	var save_dict : Dictionary = json.get_data() as Dictionary
	autosave_data = save_dict
	
	PlayerManager.set_player_stats(autosave_data.player_data.type_action1x,autosave_data.player_data.type_action1y, 
	 autosave_data.player_data.type_action2x, autosave_data.player_data.type_action2y,
	 autosave_data.player_data.type_action3x, autosave_data.player_data.type_action3y, 
	 autosave_data.player_data.health, autosave_data.player_data.max_health,
	 autosave_data.player_data.shield, autosave_data.player_data.shield_load, autosave_data.player_data.coins, autosave_data.player_data.type, autosave_data.gems.red_gem, 
	 autosave_data.gems.green_gem, autosave_data.gems.blue_gem, autosave_data.gems.yellow_gem, 
	 autosave_data.materials.wood, autosave_data.materials.stone, autosave_data.materials.iron,)

func load_savefile():
	var file = get_savefile_file()
	var json = JSON.new()
	json.parse(file.get_line())
	var save_dict : Dictionary = json.get_data() as Dictionary
	savefile_data = save_dict
	
	save_file = savefile_data.player_data.save_file
	
	PlayerManager.set_savefile_stats(savefile_data.player_data.total_coins, savefile_data.gems.total_green_gem,
	savefile_data.gems.total_red_gem, savefile_data.gems.total_blue_gem, savefile_data.gems.total_yellow_gem, 
	savefile_data.materials.total_wood, savefile_data.materials.total_stone, savefile_data.materials.total_iron, 
	savefile_data.player_data.upgraded_axe_damage_x, savefile_data.player_data.upgraded_axe_damage_y,
	savefile_data.player_data.upgraded_mace_damage_x, savefile_data.player_data.upgraded_mace_damage_y,
	savefile_data.player_data.upgraded_sword_damage_x, savefile_data.player_data.upgraded_sword_damage_y,
	savefile_data.player_data.upgraded_bow_damage_x, savefile_data.player_data.upgraded_bow_damage_y, 
	savefile_data.player_data.barbarian_unlocked,)
	
	VillageManager.set_village_stats(savefile_data.village.manor_lvl, savefile_data.village.tavern_lvl, savefile_data.village.weaponsmith_lvl, savefile_data.village.armourer_lvl, 
	savefile_data.village.sorcerer_lvl, savefile_data.village.woodcutters_lvl, savefile_data.village.stone_mine_lvl, savefile_data.village.iron_mine_lvl, savefile_data.village.rathaus_lvl,
	savefile_data.village.farm_lvl, savefile_data.village.build_houses, savefile_data.village.church_repaired, savefile_data.village.tavern_repaired, savefile_data.village.weaponsmith_repaired, 
	savefile_data.village.armourer_repaired, savefile_data.village.sorcerer_repaired, savefile_data.village.town_square_repaired, savefile_data.village.farm_repaired, savefile_data.village.houses_repaired,
	savefile_data.village.left_watchtower_repaired, savefile_data.village.right_watchtower_repaired, savefile_data.village.woodcutters_camp_repaired, savefile_data.village.stone_mine_repaired, 
	savefile_data.village.iron_mine_repaired, savefile_data.village.lamps_built, savefile_data.village.campfire_built, savefile_data.village.axe_item_lvl, savefile_data.village.mace_item_lvl,
	savefile_data.village.sword_item_lvl, savefile_data.village.bow_item_lvl,)
