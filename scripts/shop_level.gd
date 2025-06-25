extends Node2D

@onready var relic_handler = %RelicHandler

const RESOURCE_PATH = "user://resources/"

var remove_dict = {}

var reroll_price = 25
var heal10_price = 30
var heal25_price = 50

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
	change_background()
	RelicManager.reset_pieces_relics()
	$RemoveTile.visible = false
	%LessTiles.visible = false
	SignalBus.remove_tile.connect(_on_remove_tile_signal)
	SignalBus.minimum_tiles.connect(_on_minimum_tiles_signal)
	Music.play_music_shop()
	SaveManager.load_savefile()
	SaveManager.load_autosave()
	LevelManager.level_done += 1
	PlayerManager.player.update_player_texture()
	load_relics()
	check_duplicates()
	choose_relic()
	choose_piece()
	spawn_remove_tiles()

func _process(_delta):
	update_treasures_bar()
	update_relic_description()
	check_in_tile_remove()
	update_healthbars()

func change_background():
	if LevelManager.floor == 1:
		$Desktop/Background/F1.visible = true
	elif LevelManager.floor == 2:
		$Desktop/Background/F2.visible = true
	elif LevelManager.floor == 3:
		$Desktop/Background/F3.visible = true
	elif LevelManager.floor == 4:
		$Desktop/Background/F4.visible = true

func update_healthbars():
	#Player healthbar
	%PlayerHealth.value = PlayerManager.player.health
	%PlayerHealth.max_value = PlayerManager.player.max_health
	%PlayerHealthLabel.text = str(PlayerManager.player.health)

func spawn_remove_tiles():
	if PlayerManager.player.type == "Rogue":
		%TilesNumber.text = "Current tiles: " + str(len(RelicManager.rogue_pieces)) + "/9"
	elif PlayerManager.player.type == "Barbarian":
		%TilesNumber.text = "Current tiles: " + str(len(RelicManager.barbarian_pieces)) + "/9"
	for i in %Tiles.get_children():
		i.queue_free()
	RelicManager.remove_dict.clear()
	var tile_position = Vector2(777,415)
	if PlayerManager.player.type == "Rogue":
		for i in RelicManager.rogue_pieces:
			var index = RelicManager.rogue_pieces.find(i)
			var tile = i.instantiate()
			var path = tile.get_name()
			%Tiles.add_child(tile)
			tile.scale = Vector2(2,2)
			tile.position = tile_position
			if tile_position == Vector2(1121,415):
				tile_position = Vector2(777,570)
			elif tile_position == Vector2(1121,570):
				tile_position = Vector2(777,726)
			else:
				tile_position += Vector2(172,0)
			RelicManager.remove_dict[path] = index
	elif PlayerManager.player.type == "Barbarian":
		for i in RelicManager.barbarian_pieces:
			var index = RelicManager.barbarian_pieces.find(i)
			var tile = i.instantiate()
			var path = tile.get_name()
			$RemoveTile.add_child(tile)
			tile.scale = Vector2(2,2)
			tile.position = tile_position
			if tile_position == Vector2(1121,415):
				tile_position = Vector2(777,570)
			elif tile_position == Vector2(1121,570):
				tile_position = Vector2(777,726)
			else:
				tile_position += Vector2(172,0)
			RelicManager.remove_dict[path] = index

func check_in_tile_remove():
	if RelicManager.in_tile_remove == true:
		$LeaveLabel.text = "Back"
	else:
		$LeaveLabel.text = "Leave"
		
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
	RelicManager.current_relics.append(relic)
	SaveManager.save_resource(relic, relic.resource_naming)

func add_piece(relic_name, relic):
	spawn_remove_tiles()
	if PlayerManager.player.type == "Rogue":
		RelicManager.curret_pieces_for_check.append(relic)
		if relic_name == "Bolt Staff":
			RelicManager.rogue_pieces.append(RelicManager.bolt_staff)
		elif relic_name == "Crossbow":
			RelicManager.rogue_pieces.append(RelicManager.crossbow)
		elif relic_name == "Flail":
			RelicManager.rogue_pieces.append(RelicManager.flail)
		elif relic_name == "Ice Staff":
			RelicManager.rogue_pieces.append(RelicManager.ice_staff)
		elif relic_name == "Maul":
			RelicManager.rogue_pieces.append(RelicManager.maul)
		elif relic_name == "Sickle":
			RelicManager.rogue_pieces.append(RelicManager.sickle)
	elif PlayerManager.player.type == "Barbarian":
		RelicManager.curret_pieces_for_check.append(relic)
		if relic_name == "Bolt Staff":
			RelicManager.barbarian_pieces.append(RelicManager.bolt_staff)
		elif relic_name == "Crossbow":
			RelicManager.barbarian_pieces.append(RelicManager.crossbow)
		elif relic_name == "Flail":
			RelicManager.barbarian_pieces.append(RelicManager.flail)
		elif relic_name == "Ice Staff":
			RelicManager.barbarian_pieces.append(RelicManager.ice_staff)
		elif relic_name == "Maul":
			RelicManager.barbarian_pieces.append(RelicManager.maul)
		elif relic_name == "Sickle":
			RelicManager.barbarian_pieces.append(RelicManager.sickle)
		
func spawn_effect(pos):
	make_effect(particle_effect, Color(0.235, 0.235, 0.235), pos)

func spawn_effect_pieces(pos, color):
	make_effect(particle_effect, color, pos)

func make_effect(effect, color, pos):
	var current = effect.instantiate()
	current.scale = Vector2(2.25,2.25)
	current.position = pos
	add_child(current)
	current.color = color

func update_relic_description():
	$RelicName.text = RelicManager.relic_name
	$RelicDescription.text = RelicManager.relic_description
	if RelicManager.hide_stats:
		if LevelManager.is_mobile:
			$Material.visible = false
			$Gems.visible = false
	else:
		$Material.visible = true
		$Gems.visible = true

func update_treasures_bar():
	$Material/HBoxContainer/Wood.text = ": " + str(PlayerManager.player.wood)
	$Material/HBoxContainer/Stone.text = ": " + str(PlayerManager.player.stone)
	$Material/HBoxContainer/Iron.text = ": " + str(PlayerManager.player.iron)
	$Gems/HBoxContainer/RedGem.text = ": " + str(PlayerManager.player.red_gem)
	$Gems/HBoxContainer/BlueGem.text = ": " + str(PlayerManager.player.blue_gem)
	$Gems/HBoxContainer/GreenGem.text = ": " + str(PlayerManager.player.green_gem)
	$Gems/HBoxContainer/YellowGem.text = ": " + str(PlayerManager.player.yellow_gem)
	$Material/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.coins)

func hide_shop():
	$RelicUIShop.visible = false
	$RelicUIShop2.visible = false
	$RelicUIShop3.visible = false
	$RelicUIShop4.visible = false
	$RelicUIShop5.visible = false
	$RelicUIShop6.visible = false

func show_shop():
	if $RelicUIShop.is_purchased == false:
		$RelicUIShop.visible = true
	if $RelicUIShop2.is_purchased == false:
		$RelicUIShop2.visible = true
	if $RelicUIShop3.is_purchased == false:
		$RelicUIShop3.visible = true
	if $RelicUIShop4.is_purchased == false:
		$RelicUIShop4.visible = true
	if $RelicUIShop5.is_purchased == false:
		$RelicUIShop5.visible = true
	if $RelicUIShop6.is_purchased == false:
		$RelicUIShop6.visible = true

func _on_leave_button_pressed():
	spawn_remove_tiles()
	if RelicManager.in_tile_remove == true:
		show_shop()
		$RemoveTile.visible = false
		RelicManager.in_tile_remove = false
	else:
		LevelManager.switch_to_dungeon_map_timeless()


func _on_remove_tiles_pressed():
	spawn_remove_tiles()
	hide_shop()
	$RemoveTile.visible = true
	RelicManager.in_tile_remove = true

func _on_remove_tile_signal():
	spawn_remove_tiles()

func show_minimum():
	print("show")
	%LessTiles.visible = true
	await get_tree().create_timer(1.5).timeout
	%LessTiles.visible = false
	
func _on_minimum_tiles_signal():
	show_minimum()

func check_enough_coins(coins):
	if PlayerManager.player.coins >= coins:
		return true
	else:
		return false

func process_cost(coins):
	PlayerManager.player.coins -= coins
	SaveManager.savefilesave()

func not_enough():
	$RerollNotEnough.visible = true
	await get_tree().create_timer(1).timeout
	$RerollNotEnough.visible = false

func not_enough_heal():
	$HealNotEnought.visible = true
	await get_tree().create_timer(1).timeout
	$HealNotEnought.visible = false

func _on_reroll_pressed():
	if check_enough_coins(reroll_price):
		process_cost(reroll_price)
		load_relics()
		check_duplicates()
		choose_relic()
		choose_piece()
		spawn_remove_tiles()
	else:
		not_enough()


func _on_heal_10_pressed():
	if check_enough_coins(heal10_price):
		process_cost(heal10_price)
		PlayerManager.player.heal(10)
		$AnimationPlayer.play("heal10_pressed")
		%Heal10Button.disabled = true
	else:
		not_enough_heal()


func _on_heal_25_pressed():
	if check_enough_coins(heal25_price):
		process_cost(heal25_price)
		PlayerManager.player.heal(25)
		$AnimationPlayer.play("heal25_pressed")
		%Heal25Button.disabled = true
	else:
		not_enough_heal()
