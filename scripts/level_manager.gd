extends Node

var is_demo = false

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
var spinning = false

var level_active = true

var resolution
var windows_mode

var timer_stop = false

func _ready():
	check_demo()

func check_demo():
	if OS.has_feature("Demo"):
		is_demo = true

func reset_map():
	level_done = 0
	available_level = 1
	chosen_path = "ABC"
	floor = 1
	reset_complete_level = true
	await get_tree().create_timer(1).timeout
	reset_complete_level = false

func reset_win():
	PlayerManager.player.player_won = false
	handle_winning = false

func switch_to_dungeon_map():
	SaveManager.autosave()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	show_map = true
	
func switch_to_dungeon_map_timeless():
	SaveManager.autosave()
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	show_map = true

func main_menu():
	SaveManager.remove_autosave()
	SaveManager.remove_resources()
	LevelManager.reset_map()
	RelicManager.reset_pieces_relics()
	LevelManager.show_map = false
	Loading.loading_1s()
	StartGame.visible = true
	Music.play_music_menu()
	get_tree().change_scene_to_file("res://scenes/GUI/main_menu.tscn")

func back_to_village():
	get_tree().paused = false
	SaveManager.remove_autosave()
	SaveManager.remove_resources()
	LevelManager.reset_map()
	RelicManager.reset_pieces_relics()
	Loading.loading_1s()
	LevelManager.show_map = false
	get_tree().change_scene_to_file("res://scenes/village.tscn")

func reset():
	SaveManager.remove_autosave()
	SaveManager.remove_resources()
	LevelManager.reset_map()
	RelicManager.reset_pieces_relics()
