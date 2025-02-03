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
	
func handle_new_game():
	SaveManager.save_file = true
	SaveManager.savefilesave()
	visible = false
	get_tree().change_scene_to_file("res://scenes/village.tscn")
	
func handle_continue_game():
	SaveManager.load_savefile()
	visible = false
	get_tree().change_scene_to_file("res://scenes/village.tscn")

func _on_button_pressed():
	visible = false
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
