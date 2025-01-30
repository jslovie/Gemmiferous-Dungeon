extends Node


const SAVE_PATH = "user://"

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
		total_coins = 0,
		upgraded_axe_damage_x = 0,
		upgraded_axe_damage_y = 0,
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
}

#Savefile
func update_player_data_savefile():
	var p : Player = PlayerManager.player
	savefile_data.player_data.save_file = save_file
	savefile_data.player_data.total_coins = p.total_coins
	savefile_data.gems.total_red_gem = p.total_red_gem
	savefile_data.gems.total_green_gem = p.total_green_gem
	savefile_data.gems.total_blue_gem = p.total_blue_gem
	savefile_data.gems.total_yellow_gem = p.total_yellow_gem
	savefile_data.materials.total_wood = p.total_wood
	savefile_data.materials.total_stone = p.total_stone
	savefile_data.materials.total_iron = p.total_iron
	savefile_data.player_data.upgraded_axe_damage_x = p.upgraded_axe_damage.x
	savefile_data.player_data.upgraded_axe_damage_y = p.upgraded_axe_damage.y
	
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
	 autosave_data.materials.wood, autosave_data.materials.stone, autosave_data.materials.iron)

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
	savefile_data.player_data.upgraded_axe_damage_x, savefile_data.player_data.upgraded_axe_damage_y)
