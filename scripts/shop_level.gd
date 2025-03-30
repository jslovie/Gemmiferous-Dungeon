extends Node2D

@onready var relic_handler = %RelicHandler

const RESOURCE_PATH = "user://resources/"

#Effects
var particle_effect = preload("res://scenes/pieces/particle.tscn")

var possible_relics = [
	load("res://scripts/level_shop/relics/amulet_of_protection.tres"),
	load("res://scripts/level_shop/relics/antivenom.tres"),
	load("res://scripts/level_shop/relics/armor_relic.tres"),
	load("res://scripts/level_shop/relics/gem_relic.tres"),
	load("res://scripts/level_shop/relics/health_potion_relic.tres"),
	load("res://scripts/level_shop/relics/report.tres"),
	load("res://scripts/level_shop/relics/root.tres"),
	load("res://scripts/level_shop/relics/shuriken.tres"),
	load("res://scripts/level_shop/relics/thorned_necklace.tres"),
	load("res://scripts/level_shop/relics/wealth_necklace.tres"),
	#load(),
]

var possible_pieces = [
	load("res://scripts/level_shop/pieces/bolt_staff.tres"),
	load("res://scripts/level_shop/pieces/crossbow.tres"),
	load("res://scripts/level_shop/pieces/flail.tres"),
	load("res://scripts/level_shop/pieces/ice_staff.tres"),
	load("res://scripts/level_shop/pieces/maul.tres"),
	load("res://scripts/level_shop/pieces/sickle.tres"),
	#load(),
]

func _ready():
	Music.play_music_shop()
	SaveManager.load_savefile()
	SaveManager.load_autosave()
	LevelManager.level_done += 1
	PlayerManager.player.update_player_texture()
	load_relics()
	check_duplicates()
	choose_relic()
	choose_piece()

func _process(delta):
	update_treasures_bar()
	update_relic_description()

func check_duplicates():
	for i in RelicManager.current_relics:
		for j in possible_relics:
			if i == j:
				possible_relics.erase(j)
	for i in RelicManager.curret_pieces_for_check:
		for j in possible_pieces:
			if i == j:
				possible_pieces.erase(j)
	
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


func choose_piece():
	if possible_pieces.size() > 0 :
		var random_piece = possible_pieces[randi() % possible_pieces.size()]
		$RelicUIShop4.relic = random_piece
		possible_pieces.erase(random_piece)
	else:
		$RelicUIShop4.visible = false
		$RelicUIShop5.visible = false
		$RelicUIShop6.visible = false
	if possible_pieces.size() > 0 :
		var random_piece = possible_pieces[randi() % possible_pieces.size()]
		$RelicUIShop5.relic = random_piece
		possible_pieces.erase(random_piece)
	else:
		$RelicUIShop5.visible = false
		$RelicUIShop6.visible = false
	if possible_pieces.size() > 0 :
		var random_piece = possible_pieces[randi() % possible_pieces.size()]
		$RelicUIShop6.relic = random_piece
		possible_pieces.erase(random_piece)
	else:
		$RelicUIShop6.visible = false


func load_relics():
	var dir = DirAccess.open(RESOURCE_PATH)
	for file in dir.get_files():
		relic_handler.add_relic(SaveManager.load_resource(file))

func add_relic(relic):
	relic_handler.add_relic(relic)
	SaveManager.save_resource(relic, relic.resource_naming)

func add_piece(relic_name, relic):
	RelicManager.curret_pieces_for_check.append(relic)
	if relic_name == "Bolt Staff":
		RelicManager.current_pieces.append(RelicManager.bolt_staff)
	elif relic_name == "Crossbow":
		RelicManager.current_pieces.append(RelicManager.crossbow)
	elif relic_name == "Flail":
		RelicManager.current_pieces.append(RelicManager.flail)
	elif relic_name == "Ice Staff":
		RelicManager.current_pieces.append(RelicManager.ice_staff)
	elif relic_name == "Maul":
		RelicManager.current_pieces.append(RelicManager.maul)
	elif relic_name == "Sickle":
		RelicManager.current_pieces.append(RelicManager.sickle)
		
		
func spawn_effect(pos):
	make_effect(particle_effect, Color(0.235, 0.235, 0.235), pos)

func spawn_effect_pieces(pos, color):
	make_effect(particle_effect, color, pos)

func make_effect(effect, color, pos):
	var current = effect.instantiate()
	current.scale = Vector2(2.5,2.5)
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
	$Material/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.coins)


func _on_leave_button_pressed():
	LevelManager.switch_to_dungeon_map_timeless()
