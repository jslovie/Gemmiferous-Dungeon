extends Node2D


func _ready():
	SaveManager.load_savefile()
	SaveManager.load_autosave()
	LevelManager.level_done += 1

func _process(_delta):
	change_background()
	
func change_background():
	if LevelManager.floor == 1:
		$Background/F1.visible = true
	elif LevelManager.floor == 2:
		$Background/F2.visible = true
	elif LevelManager.floor == 3:
		$Background/F3.visible = true
	elif LevelManager.floor == 4:
		$Background/F4.visible = true	
	
func handle_option():
	PlayerManager.player.heal(15)
	SaveManager.autosave()
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	LevelManager.show_map = true

func _on_button_pressed():
	handle_option()


func _on_button_2_pressed():
	PlayerManager.player.set_treasure()
	SaveManager.savefilesave()
	SaveManager.remove_autosave()
	get_tree().change_scene_to_file("res://scenes/village.tscn")
