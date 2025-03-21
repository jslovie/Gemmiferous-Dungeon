extends Control
class_name RelicUI

signal description

@export var relic: Relic : set = set_relic

@onready var icon = $Icon
@onready var animation_player = $AnimationPlayer

func _ready():
	if relic.relic_name == "Amulet of Protection":
		amulet_of_protection()
	if relic.relic_name == "Antivenom":
		antivenom()
	
func _process(delta):
	if relic.relic_name == "Health Potion":
		health_potion()
	if relic.relic_name == "Armor":
		armor()
	if relic.relic_name == "Report":
		report()
	
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
	if RelicManager.got_hit_health_potion == 5:
		PlayerManager.player.heal(5)
		flash()
		RelicManager.got_hit_health_potion = 0

func armor():
	if RelicManager.got_hit_armor == 5:
		PlayerManager.player.shield_up(5)
		flash()
		RelicManager.got_hit_armor = 0
		
func amulet_of_protection():
	if LevelManager.type == "Enemy" or LevelManager.type == "Elite Enemy" or LevelManager.type == "Boss":
		PlayerManager.player.shield_up(10)

func antivenom():
	flash()
	PlayerManager.player.has_antivenom = true

func report():
	if RelicManager.report == 3:
		PlayerManager.player.get_coins(30)
		flash()
		RelicManager.report = 0

func _on_mouse_entered():
	$TextureRect.modulate = Color(0.439, 0.439, 0.439)
	RelicManager.relic_name = relic.relic_name
	RelicManager.relic_description = relic.description

	
func _on_mouse_exited():
	$TextureRect.modulate = Color(0.235, 0.235, 0.235)
	RelicManager.relic_name = ""
	RelicManager.relic_description = ""
	
