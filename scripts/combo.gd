extends CanvasLayer

@export var combo_shader: ShaderMaterial
@onready var shader = $Shader

var combo_on: bool = false

var combo_level: int = 0
var combo_time_left: float = 2.5

func _ready():
	shader.material = combo_shader
	hide_combo()
	
func _process(_delta):
	if combo_on == true:
		show_combo()
	else:
		hide_combo()

func change_combo_shader_parameter(value: float):
	combo_shader.set_shader_parameter("smear", value)

func hide_combo():
	shader.visible = false
	
func show_combo():
	shader.visible = true
