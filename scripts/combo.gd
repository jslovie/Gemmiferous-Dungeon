extends CanvasLayer

@export var combo_shader: ShaderMaterial
@onready var shader = $Shader
@onready var timer = $Timer

var all_combo_buffs := [
	{"name": "Damage"},
	{"name": "Double Items"},
	{"name": "Status Resistance"}
]

var damage_buff_active: bool = false
var double_items_buff_active: bool = false
var status_resistance_buff_active: bool = false

var available_buffs := []

var combo_level: int = 0
var combo_time_left: float = 2.5

var combo_damage_level: int = 0
var double_items_level: int = 0

func _ready():
	shader.material = combo_shader
	change_combo_shader_parameter(0.0)
	available_buffs = all_combo_buffs.duplicate(true)
	hide_combo()

func reset_timer(time):
	timer.start(time)

func check_combo_level():
	#var combo_levels := {
		#5: 0.08,
		#10: 0.12,
		#15: 0.15,
		#20: 0.25,
		#25: 0.30
	#}
	var combo_levels := {
		10: 0.08,
		15: 0.15,
		20: 0.20,
		25: 0.25
	}
	if combo_level in combo_levels:
		apply_random_buff()
		show_combo()
		change_combo_shader_parameter(combo_levels[combo_level])
	elif combo_level == 5:
		apply_random_buff()
		
func change_combo_shader_parameter(value: float):
	var tw = create_tween()
	tw.tween_property(combo_shader, "shader_parameter/smear", value, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func apply_random_buff():
	if available_buffs.size() == 0:
		print("No buffs left!")
		return

	var buff = available_buffs[randi() % available_buffs.size()]
	
	var damage_buff_levels = {
	1: 1.15,
	2: 1.25,
	3: 1.5,
	4: 1.75,
	5: 2.0
	}
	var double_items_buff_levels = {
	1: 1.5,
	2: 2.0,
	}
	
	if buff["name"] == "Damage":
		damage_buff_active = true
		combo_damage_level += 1
		if combo_damage_level == 6:
			available_buffs.erase(buff)
			apply_random_buff()
		else:
			if combo_damage_level in damage_buff_levels:
				PlayerManager.player.combo_multiplier = damage_buff_levels[combo_damage_level]
				
	elif buff["name"] == "Double Items":
		double_items_buff_active = true
		double_items_level += 1
		if double_items_level == 3:
			double_items_level = 2
			available_buffs.erase(buff)
			apply_random_buff()


	elif buff["name"] == "Status Resistance":
		status_resistance_buff_active = true
		available_buffs.erase(buff)

		
		
		
func hide_combo():
	shader.visible = false
	
func show_combo():
	shader.visible = true


func _on_timer_timeout():
	combo_level = 0
	combo_damage_level = 0
	double_items_level = 0
	damage_buff_active = false
	double_items_buff_active = false
	status_resistance_buff_active = false
	PlayerManager.player.combo_multiplier = 1.0
	available_buffs = all_combo_buffs.duplicate(true)
	var current_smear = combo_shader.get_shader_parameter("smear")
	var tw = create_tween()
	tw.tween_property(combo_shader, "shader_parameter/smear", 0.0, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func():
		hide_combo()
	)
