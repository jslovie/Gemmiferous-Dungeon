extends Control
class_name RelicUI

signal description

@export var relic: Relic : set = set_relic

@onready var icon = $Icon
@onready var animation_player = $AnimationPlayer

func _process(delta):
	if relic.relic_name == "Health Potion":
		health_potion()

func set_relic(new_relic: Relic):
	if not is_node_ready():
		await ready
		
	relic = new_relic
	icon.texture = relic.relic_texture

func flash():
	animation_player.play("flash")

func _on_gui_input(event):
	if event.is_action_pressed("ui_touch"):
		pass
		
		
func health_potion():
	if PlayerManager.player.got_hit_health_potion == 5:
		PlayerManager.player.shield_up(5)
		flash()
		PlayerManager.player.got_hit_health_potion = 0


func _on_mouse_entered():
	$TextureRect.modulate = Color(0.439, 0.439, 0.439)
	LevelManager.relic_description = relic.description
	
func _on_mouse_exited():
	$TextureRect.modulate = Color(0.235, 0.235, 0.235)
	LevelManager.relic_description = ""
	
