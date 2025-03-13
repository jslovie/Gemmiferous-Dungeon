extends Node2D


func _ready():
	Music.play_music_selection()
	SaveManager.load_autosave()
	SaveManager.load_savefile()
