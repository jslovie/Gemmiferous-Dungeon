extends Node

var is_demo = false
var is_mobile = false

var show_map = false
var show_map_mobile = false

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
var effects

var timer_stop = false

var in_game = true
var in_village = false
var in_tutorial_level = false
var tutorial_completed = false

func _ready():
	check_version()

func check_version():
	if OS.has_feature("Demo"):
		LevelManager.is_demo = true
	if OS.has_feature("Mobile"):
		LevelManager.is_mobile = true
	#LevelManager.is_mobile = true

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

func reset_tutorial():
	in_tutorial_level = false
	tutorial_completed = false

func switch_to_dungeon_map():
	SaveManager.autosave()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	if is_mobile:
		show_map_mobile = true
	else:
		show_map = true
	
func switch_to_dungeon_map_timeless():
	SaveManager.autosave()
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	if is_mobile:
		show_map_mobile = true
	else:
		show_map = true

func switch_to_game_window():
	if is_mobile:
		get_tree().change_scene_to_file("res://scenes/game_window_mobile.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game_window.tscn")

func main_menu():
	SaveManager.remove_autosave()
	SaveManager.remove_resources()
	LevelManager.reset_map()
	RelicManager.reset_pieces_relics()
	LevelManager.reset_tutorial()
	LevelManager.show_map = false
	LevelManager.show_map_mobile = false
	LevelManager.in_village = false
	Loading.loading_1s()
	if is_mobile:
		StartGameMobile.visible = true
	else:
		StartGame.visible = true
	Music.play_music_menu()
	get_tree().change_scene_to_file("res://scenes/GUI/main_menu_.tscn")




func back_to_village():
	get_tree().paused = false
	VillageHudMobile.update_village_hud_mobile()
	SaveManager.remove_autosave()
	SaveManager.remove_resources()
	LevelManager.reset_map()
	RelicManager.reset_pieces_relics()
	LevelManager.reset_tutorial()
	LevelManager.show_map = false
	LevelManager.show_map_mobile = false
	Loading.loading_1s()
	await get_tree().create_timer(0.8).timeout
	LevelManager.in_village = true
	LevelManager.in_tutorial_level = false
	get_tree().change_scene_to_file("res://scenes/village.tscn")


func reset():
	DungeonMap.hide_all_dungeons()
	DungeonMapMobile.hide_all_dungeons()
	SaveManager.remove_autosave()
	SaveManager.remove_resources()
	LevelManager.reset_map()
	RelicManager.reset_pieces_relics()
	LevelManager.reset_tutorial()
