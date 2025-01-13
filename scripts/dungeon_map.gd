extends CanvasLayer

func _ready():
	LevelManager.show_map = false

func _process(_delta):
	dungeon_map()

func dungeon_map():
	if LevelManager.show_map == false:
		visible = false
	elif LevelManager.show_map == true:
		visible = true
