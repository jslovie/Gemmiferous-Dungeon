extends Node2D

func _ready():
	set_resolution()
	SaveManager.autosave()
	if LevelManager.is_mobile == true:
		get_window().set_size(Vector2(288,512))
	else:
		get_viewport().size = DisplayServer.screen_get_size()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	LevelManager.windows_mode = 0


		
		
func set_resolution():
	if str(DisplayServer.screen_get_size()) == "(960, 540)":
		LevelManager.resolution = 0
	elif str(DisplayServer.screen_get_size()) == "(1280, 720)":
		LevelManager.resolution = 1
	elif str(DisplayServer.screen_get_size()) == "(1920, 1080)":
		LevelManager.resolution = 2
	elif str(DisplayServer.screen_get_size()) == "(2500, 1440)":
		LevelManager.resolution = 3
