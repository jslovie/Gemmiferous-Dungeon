extends CanvasLayer


func _ready():
	visible = false

func loading():
	visible = true

func loading_done():
	visible = false

func loading_1s():
	visible = true
	await get_tree().create_timer(1).timeout
	visible = false

func loading_2s():
	visible = true
	await get_tree().create_timer(2).timeout
	visible = false
