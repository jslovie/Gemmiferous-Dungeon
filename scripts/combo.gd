extends CanvasLayer

@export var combo_shader: ShaderMaterial
@onready var shader = $Shader
@onready var timer = $Timer


var combo_level: int = 0
var combo_time_left: float = 2.5

func _ready():
	shader.material = combo_shader
	hide_combo()
	
func _process(_delta):
	check_combo_level()

func reset_timer(time):
	timer.start(time)

func check_combo_level():
	if combo_level == 5:
		change_combo_shader_parameter(0.08)
		show_combo()
	elif combo_level == 10:
		change_combo_shader_parameter(0.15)
	elif combo_level == 20:
		change_combo_shader_parameter(0.25)
	elif combo_level == 25:
		change_combo_shader_parameter(0.35)
		
func change_combo_shader_parameter(value: float):
	combo_shader.set_shader_parameter("smear", value)

func hide_combo():
	shader.visible = false
	
func show_combo():
	shader.visible = true


func _on_timer_timeout():
	combo_level = 0
	var current_smear = combo_shader.get_shader_parameter("smear")
	var tw = create_tween()
	tw.tween_property(combo_shader, "shader_parameter/smear", 0.0, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func():
		hide_combo()
	)
