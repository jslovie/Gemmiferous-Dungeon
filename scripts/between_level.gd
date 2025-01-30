extends Node2D


func _ready():
	SaveManager.load_autosave()
	SaveManager.load_savefile()
