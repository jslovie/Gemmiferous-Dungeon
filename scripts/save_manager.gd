extends Node

const SAVE_PATH = "user://"

#Autosave
var autosave_data = {
	player_data = {
		sword_damage = 0,
		magic_damage = 0,
		bow_damage = 0,
		health = 0,
		max_health = 0,
		shield = 0,
		shield_load = 0,
		xp = 0,
		coins = 0,
		first_spawn = false},
}

#Savefile
var savefile_data = {
	player_data = {
		sword_damage = 0,
		magic_damage = 0,
		bow_damage = 0,
		health = 0,
		max_health = 0,
		shield = 0,
		shield_load = 0,
		xp = 0,
		coins = 0,
		first_spawn = false},
}

#Savefile
func update_player_data_savefile():
	var p : Player = PlayerManager.player
	savefile_data.player_data.sword_damage = p.sword_damage
	savefile_data.player_data.magic_damage = p.magic_damage
	savefile_data.player_data.bow_damage = p.bow_damage
	savefile_data.player_data.health = p.health
	savefile_data.player_data.max_health = p.max_health
	savefile_data.player_data.shield = p.shield
	savefile_data.player_data.shield_load = p.shield_load
	savefile_data.player_data.xp = p.xp
	savefile_data.player_data.coins = p.coins

#Autosave
func update_player_data_autosave():
	var p : Player = PlayerManager.player
	autosave_data.player_data.sword_damage = p.sword_damage
	autosave_data.player_data.magic_damage = p.magic_damage
	autosave_data.player_data.bow_damage = p.bow_damage
	autosave_data.player_data.health = p.health
	autosave_data.player_data.max_health = p.max_health
	autosave_data.player_data.shield = p.shield
	autosave_data.player_data.shield_load = p.shield_load
	autosave_data.player_data.xp = p.xp
	autosave_data.player_data.coins = p.coins
	
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
	
func savefile_1():
	update_player_data_savefile()
	var file := FileAccess.open(SAVE_PATH + "savefile_1", FileAccess.WRITE)
	var save_json = JSON.stringify(savefile_data)
	file.store_line(save_json)

func get_savefile_1():
	return FileAccess.open(SAVE_PATH + "savefile_1.sav", FileAccess.READ)

func get_autosave_file():
	return FileAccess.open(SAVE_PATH + "autosave.sav", FileAccess.READ)

func load_autosave():
	var file = get_autosave_file()
	var json = JSON.new()
	json.parse(file.get_line())
	var save_dict : Dictionary = json.get_data() as Dictionary
	autosave_data = save_dict
	
	PlayerManager.set_player_stats(autosave_data.player_data.sword_damage, autosave_data.player_data.magic_damage,
	 autosave_data.player_data.bow_damage, autosave_data.player_data.health, autosave_data.player_data.max_health,
	 autosave_data.player_data.shield, autosave_data.player_data.shield_load, autosave_data.player_data.xp, 
	 autosave_data.player_data.coins,)
