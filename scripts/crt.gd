extends CanvasLayer

var crt_on = false

func _ready():
	hide_crt()
	
func _process(delta):
	if crt_on == true:
		show_crt()
	else:
		hide_crt()


func hide_crt():
	$ColorRect.visible = false

func show_crt():
	$ColorRect.visible = true
	
