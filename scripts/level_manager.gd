extends Node



var show_map = true

var available_level = 1
var level_done = 0

var type : String

var treasure_timesup = false

var handle_winning = false


func switch_to_dungeon_map():
	SaveManager.autosave()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	show_map = true
	
func switch_to_dungeon_map_timeless():
	SaveManager.autosave()
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	show_map = true
