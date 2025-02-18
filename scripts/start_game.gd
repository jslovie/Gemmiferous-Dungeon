extends CanvasLayer

const SAVE_PATH = "user://"

func _ready():
	if FileAccess.file_exists(SAVE_PATH + "savefile.sav"):
		SaveManager.load_savefile()
	else:
		print("No")

func _process(_delta):
	if SaveManager.save_file == true:
		$StartGame.text = "Continue"
	else:
		$StartGame.text = "New Game"

func create_test_game():
	SaveManager.save_file = true
	SaveManager.remove_savefile()
	SaveManager.reset_savefile()
	VillageManager.reset_village_stats()
	PlayerManager.player.total_red_gem = 1000
	PlayerManager.player.total_green_gem = 1000
	PlayerManager.player.total_blue_gem = 1000
	PlayerManager.player.total_yellow_gem = 1000
	PlayerManager.player.total_coins = 1000
	PlayerManager.player.total_wood = 1000
	PlayerManager.player.total_stone = 1000
	PlayerManager.player.total_iron = 1000
	SaveManager.savefilesave()
	
func handle_new_game():
	SaveManager.save_file = true
	SaveManager.savefilesave()
	visible = false
	Loading.loading_1s()
	get_tree().change_scene_to_file("res://scenes/village.tscn")
	
func handle_continue_game():
	SaveManager.load_savefile()
	visible = false
	Loading.loading_1s()
	get_tree().change_scene_to_file("res://scenes/village.tscn")

func _on_button_pressed():
	visible = false
	Loading.loading_1s()
	create_test_game()
	get_tree().change_scene_to_file("res://scenes/village.tscn")




func _on_quit_game_pressed():
	SaveManager.remove_autosave()
	get_tree().quit()


func _on_start_game_pressed():
	if SaveManager.save_file == false:
		handle_new_game()
	else:
		handle_continue_game()
	


func _on_remove_pressed():
	SaveManager.save_file = false
	SaveManager.remove_savefile()
	SaveManager.reset_savefile()
	VillageManager.reset_village_stats()
