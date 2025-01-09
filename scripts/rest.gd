extends Node2D


func _ready():
	SaveManager.load_autosave()
	
func handle_option():
	PlayerManager.player.health += 25
	SaveManager.autosave()
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	LevelManager.show_map = true

func _on_button_pressed():
	handle_option()