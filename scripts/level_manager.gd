extends Node



var show_map = true

var available_level = 1
var level_done = 0
var floor = 1
var type : String
var chosen_path = "ABC"
var treasure_timesup = true
var handle_winning = false
var reset_complete_level = false
var place : String

var relic_description = ""

func _process(delta):
	print(relic_description)

func reset_map():
	level_done = 0
	available_level = 1
	chosen_path = "ABC"
	floor = 1
	reset_complete_level = true
	await get_tree().create_timer(1).timeout
	reset_complete_level = false
	
func switch_to_dungeon_map():
	SaveManager.autosave()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	show_map = true
	
func switch_to_dungeon_map_timeless():
	SaveManager.autosave()
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	show_map = true
