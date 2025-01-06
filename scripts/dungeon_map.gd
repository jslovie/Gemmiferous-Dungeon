extends CanvasLayer

func _process(delta):
	dungeon_map()

func dungeon_map():
	if PlayerManager.show_map == false:
		visible = false
	elif PlayerManager.show_map == true:
		visible = true
