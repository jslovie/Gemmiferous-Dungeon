extends Node



var show_map = true

var available_level = 1
var level_done = 0
var type : String
var chosen_path = "ABC"
var treasure_timesup = false
var handle_winning = false


func reset_map():
	level_done = 0
	available_level = 1
	chosen_path = "ABC"

func switch_to_dungeon_map():
	SaveManager.autosave()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	show_map = true
	
func switch_to_dungeon_map_timeless():
	SaveManager.autosave()
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	show_map = true
