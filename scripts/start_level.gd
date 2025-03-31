extends Node2D

func _ready():
	SaveManager.autosave()
	get_viewport().size = DisplayServer.screen_get_size()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
