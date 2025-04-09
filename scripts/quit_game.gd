extends CanvasLayer

var is_paused = false

func _ready():
	hide_quit()

func show_quit():
	visible = true
	
func hide_quit():
	visible = false
	
#func _unhandled_input(event):
	#if  event.is_action_pressed("Esc"):
		#if is_paused == false:
			#show_quit()
		#else:
			#hide_quit()
		##get_viewport().set_input_as_handled()


func _on_button_pressed():
	SaveManager.remove_autosave()
	SaveManager.remove_resources()
	hide_quit()
	LevelManager.reset_map()
	LevelManager.show_map = false
	get_tree().change_scene_to_file("res://scenes/GUI/start_game.tscn")
	
