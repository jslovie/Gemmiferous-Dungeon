extends CanvasLayer

@export var combo_shader: ShaderMaterial
@onready var shader = $Shader
@onready var timer = $Timer

var all_combo_buffs := [
	{"name": "Damage"},
	{"name": "Double Items"},
	{"name": "Status Resistance"},
	{"name": "HP on match chance"},
	{"name": "Shield on match chance"}
]


var treasure_combo_buffs := [
	{"name": "Double Items"},
	{"name": "HP on match chance"},
]
var damage_buff_active: bool = false
var double_items_buff_active: bool = false
var status_resistance_buff_active: bool = false
var hp_buff_active: bool = false
var shield_buff_active: bool = false

var available_buffs := []

var combo_level: int = 0
var combo_time_left: float = 2.5

var combo_damage_level: int = 0
var double_items_level: int = 0
var hp_level: int = 0
var shield_level: int = 0

func _ready():
	shader.material = combo_shader
	change_combo_shader_parameter(0.0)
	setup_buffs()
	hide_combo()

func setup_buffs():
	available_buffs = []
	if LevelManager.type == "Treasure":
		available_buffs = treasure_combo_buffs
	else:
		available_buffs = all_combo_buffs

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
		20: 0.10,
		25: 0.15,
		30: 0.20
	}
	if combo_level in combo_levels:
		apply_random_buff()
		show_combo()
		change_combo_shader_parameter(combo_levels[combo_level])
	elif combo_level == 5 or combo_level == 10 or combo_level == 15:
		apply_random_buff()
		
func change_combo_shader_parameter(value: float):
	var tw = create_tween()
	tw.tween_property(combo_shader, "shader_parameter/smear", value, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

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
		if double_items_level == 5:
			double_items_level = 4
			available_buffs.erase(buff)
			apply_random_buff()

	elif buff["name"] == "Status Resistance":
		status_resistance_buff_active = true
		available_buffs.erase(buff)
		
	elif buff["name"] == "HP on match chance":
		hp_buff_active = true
		hp_level += 1
		if hp_level == 4:
			hp_level = 3
			available_buffs.erase(buff)
			apply_random_buff()
			
	elif buff["name"] == "Shield on match chance":
		shield_buff_active = true
		shield_level += 1
		if shield_level == 4:
			shield_level = 3
			available_buffs.erase(buff)
			apply_random_buff()
		
func hide_combo():
	shader.visible = false
	
func show_combo():
	shader.visible = true

func _on_timer_timeout():
	combo_level = 0
	combo_damage_level = 0
	double_items_level = 0
	hp_level = 0
	shield_level = 0
	damage_buff_active = false
	double_items_buff_active = false
	status_resistance_buff_active = false
	hp_buff_active = false
	shield_buff_active = false
	PlayerManager.player.combo_multiplier = 1.0
	available_buffs = all_combo_buffs.duplicate(true)
	var tw = create_tween()
	tw.tween_property(combo_shader, "shader_parameter/smear", 0.0, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func():
		hide_combo()
	)
	SignalBus.emit_signal("zero_out_combo")
