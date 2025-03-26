extends CanvasLayer

var crt_on = false

@export var crt_shader: ShaderMaterial
@onready var color_rect = $ColorRect


func _ready():
	color_rect.material = crt_shader
	hide_crt()
	
	
func _process(delta):
	get_CRT_parameter()
	if crt_on == true:
		show_crt()
	else:
		hide_crt()


func hide_crt():
	$ColorRect.visible = false
	
func show_crt():
	$ColorRect.visible = true

func get_CRT_parameter():
	var crt = crt_shader.get_shader_parameter("scan_line_amount")
	return crt

func change_CRT_parameter(value):
	crt_shader.set_shader_parameter("scan_line_amount", value)
