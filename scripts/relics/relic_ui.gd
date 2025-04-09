extends Control
class_name RelicUI

signal description

@export var relic: Relic : set = set_relic

@onready var icon = $Icon
@onready var animation_player = $AnimationPlayer

func _ready():
	set_relics()
	
func _process(delta):
	if relic.relic_name == "Health Potion":
		health_potion()
	if relic.relic_name == "Armor":
		armor()
	if relic.relic_name == "Report":
		report()
	if relic.relic_name == "Thorned Necklace":
		thorned_necklace()

func set_relics():
	await get_tree().create_timer(3).timeout
	if relic.relic_name == "Amulet of Protection":
		amulet_of_protection()
	if relic.relic_name == "Antivenom":
		antivenom()
	if relic.relic_name == "Root":
		root()
	if relic.relic_name == "Shuriken":
		shuriken()
	if relic.relic_name == "Wealth Necklace":
		wealth_necklace()
	if relic.relic_name == "Gem Necklace":
		gem_necklace()
	
func set_relic(new_relic: Relic):
	if not is_node_ready():
		await ready
		
	relic = new_relic
	icon.texture = relic.relic_texture

func flash():
	Sfx.play_SFX(Sfx.relic)
	animation_player.play("flash")

func _on_gui_input(event):
	if event.is_action_pressed("ui_touch"):
		pass
		
		
func health_potion():
	if RelicManager.got_hit_health_potion == 5:
		PlayerManager.player.heal(5)
		flash()
		RelicManager.got_hit_health_potion = 0
	if RelicManager.got_hit_health_potion > 5:
		RelicManager.got_hit_health_potion = 0

func armor():
	if RelicManager.got_hit_armor == 5:
		PlayerManager.player.shield_up(5)
		flash()
		RelicManager.got_hit_armor = 0
	if RelicManager.got_hit_armor > 5:
		RelicManager.got_hit_armor = 0
			
func amulet_of_protection():
	if LevelManager.type == "Enemy" or LevelManager.type == "Elite Enemy" or LevelManager.type == "Boss":
		flash()
		PlayerManager.player.shield_up(10)

func antivenom():
	flash()
	PlayerManager.player.has_antivenom = true

func report():
	if RelicManager.report == 3:
		PlayerManager.player.get_coins(30)
		flash()
		RelicManager.report = 0
	if RelicManager.report > 3:
		RelicManager.report = 0
	
func root():
	if LevelManager.type == "Boss":
		flash()
		PlayerManager.player.heal(25)

func shuriken():
	flash()
	RelicManager.has_shuriken = true

func wealth_necklace():
	flash()
	RelicManager.has_wealth_necklace = true

func thorned_necklace():
	if RelicManager.thorned_necklade == 10:
		flash()
		PlayerManager.player.damage_thorned_necklace()
		RelicManager.thorned_necklade = 0
	if RelicManager.thorned_necklade > 10:
		RelicManager.thorned_necklade = 0

func gem_necklace():
	flash()
	RelicManager.has_gem_necklace = true

func _on_mouse_entered():
	$TextureRect.modulate = Color(0.439, 0.439, 0.439)
	RelicManager.relic_name = relic.relic_name
	RelicManager.relic_description = relic.description

	
func _on_mouse_exited():
	$TextureRect.modulate = Color(0.235, 0.235, 0.235)
	RelicManager.relic_name = ""
	RelicManager.relic_description = ""
	
