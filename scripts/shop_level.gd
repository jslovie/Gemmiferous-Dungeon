extends Node2D

@onready var relic_handler = %RelicHandler

const RESOURCE_PATH = "user://resources/"

#Effects
var particle_effect = preload("res://scenes/pieces/particle.tscn")

var possible_relics = [
	load("res://scripts/relics/armor_relic.tres"),
	load("res://scripts/relics/gem_relic.tres"),
	load("res://scripts/relics/health_potion_relic.tres"),
	load("res://scripts/relics/thorned_necklace.tres"),
	load("res://scripts/relics/amulet_of_protection.tres"),
	load("res://scripts/relics/antivenom.tres"),
	load("res://scripts/relics/shuriken.tres"),
	#load(),
]

func _ready():
	Music.play_music_shop()
	SaveManager.load_savefile()
	SaveManager.load_autosave()
	LevelManager.level_done += 1
	PlayerManager.player.update_player_texture()
	load_relics()
	choose_relic()

func _process(delta):
	update_treasures_bar()
	update_relic_description()

func choose_relic():
	if possible_relics.size() > 0 :
		var random_relic = possible_relics[randi() % possible_relics.size()]
		$RelicUIShop.relic = random_relic
		possible_relics.erase(random_relic)
	else:
		$RelicUIShop.visible = false
		$RelicUIShop2.visible = false
		$RelicUIShop3.visible = false
	if possible_relics.size() > 0 :
		var random_relic = possible_relics[randi() % possible_relics.size()]
		$RelicUIShop2.relic = random_relic
		possible_relics.erase(random_relic)
	else:
		$RelicUIShop2.visible = false
		$RelicUIShop3.visible = false
	if possible_relics.size() > 0 :
		var random_relic = possible_relics[randi() % possible_relics.size()]
		$RelicUIShop3.relic = random_relic
		possible_relics.erase(random_relic)
	else:
		$RelicUIShop3.visible = false
		
func load_relics():
	var dir = DirAccess.open(RESOURCE_PATH)
	for file in dir.get_files():
		relic_handler.add_relic(SaveManager.load_resource(file))

func add_relic(relic):
	relic_handler.add_relic(relic)
	SaveManager.save_resource(relic, relic.resource_naming)

func spawn_effect(pos):
	make_effect(particle_effect, Color(0.235, 0.235, 0.235), pos)

func make_effect(effect, color, pos):
	var current = effect.instantiate()
	current.scale = Vector2(3,3)
	current.position = pos
	add_child(current)
	current.color = color

func update_relic_description():
	$RelicName.text = RelicManager.relic_name
	$RelicDescription.text = RelicManager.relic_description

func update_treasures_bar():
	$Material/HBoxContainer/Wood.text = ": " + str(PlayerManager.player.wood)
	$Material/HBoxContainer/Stone.text = ": " + str(PlayerManager.player.stone)
	$Material/HBoxContainer/Iron.text = ": " + str(PlayerManager.player.iron)
	$Gems/HBoxContainer/RedGem.text = ": " + str(PlayerManager.player.red_gem)
	$Gems/HBoxContainer/BlueGem.text = ": " + str(PlayerManager.player.blue_gem)
	$Gems/HBoxContainer/GreenGem.text = ": " + str(PlayerManager.player.green_gem)
	$Gems/HBoxContainer/YellowGem.text = ": " + str(PlayerManager.player.yellow_gem)
	$Gems/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.coins)


func _on_leave_button_pressed():
	LevelManager.switch_to_dungeon_map_timeless()
