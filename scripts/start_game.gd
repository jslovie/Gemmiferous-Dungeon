extends CanvasLayer



func _on_button_pressed():
	LevelManager.show_map = true
	visible = false
	get_tree().change_scene_to_file("res://scenes/dungeons/start_level.tscn")
