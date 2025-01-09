extends Node2D

func _ready():
	SaveManager.load_autosave()
	
func handle_option():
	SaveManager.autosave()
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	LevelManager.show_map = true

func _on_option_1_pressed():
	PlayerManager.player.health -= 10
	handle_option()

func _on_option_2_pressed():
	if PlayerManager.player.coins >= 3:
		PlayerManager.player.coins -= 3
	if PlayerManager.player.xp >= 3:
		PlayerManager.player.xp -= 3
	handle_option()
