extends Node2D

signal camera_effect

#State Machine
enum {wait, move}
var state

#Grid variables
@export var width: int
@export var height: int
@export var x_start: int
@export var y_start: int
@export var offset: int
@export var y_offset: int

@export var empty_spaces: PackedVector2Array

#Effects
var particle_effect = preload("res://scenes/pieces/particle.tscn")
var wood_effect = preload("res://scenes/GUI/wood_effect.tscn")
var stone_effect = preload("res://scenes/GUI/stone_effect.tscn")
var iron_effect = preload("res://scenes/GUI/iron_effect.tscn")
var shield_effect = preload("res://scenes/GUI/shield_effect.tscn")
var red_gem_effect = preload("res://scenes/GUI/red_gem_treasure.tscn")
var blue_gem_effect = preload("res://scenes/GUI/blue_gem_treasure.tscn")
var green_gem_effect = preload("res://scenes/GUI/green_gem_treasure.tscn")
var yellow_gem_effect = preload("res://scenes/GUI/yellow_gem_treasure.tscn")
var coin_effect = preload("res://scenes/GUI/coin_treasure.tscn")

#Hint effect
@export var hint_effect : PackedScene
var hint = null
var match_color = ""

#Possible pieces array
var possible_pieces = []

#Current pieces in scene
var all_pieces = []
var clone_array = []

#Swap back variables
var piece_one = null
var piece_two = null
var last_place = Vector2(0,0)
var last_direction = Vector2(0,0)
var move_checked = false

#Touch variable
var first_touch = Vector2(0, 0)
var final_touch = Vector2(0, 0)
var controlling = false

func _ready():
	state = move
	randomize()
	choose_player_type()
	all_pieces = make_2d_array()
	clone_array = make_2d_array()
	spawn_pieces()
	
func _process(_delta):
	if LevelManager.type == "Treasure":
		if LevelManager.treasure_timesup == true:
			state = wait
		pass
	else:
		if EnemyManager.enemy.status == "dead":
			state = wait
	if state == move:
		touch_input()

func choose_player_type():
	if SaveManager.autosave_data.player_data.type == "Rogue":
		var rogue_pieces = [
			preload("res://scenes/pieces/sword_piece.tscn"),
			preload("res://scenes/pieces/bow_piece.tscn"),
			preload("res://scenes/pieces/invisibility_ring_piece.tscn"),
			preload("res://scenes/pieces/rogue_shield_piece.tscn"),
			preload("res://scenes/pieces/material_piece.tscn"),]
		possible_pieces.append_array(rogue_pieces)
	elif SaveManager.autosave_data.player_data.type == "Barbarian":
		var barbarian_pieces = [
			preload("res://scenes/pieces/axe_piece.tscn"),
			preload("res://scenes/pieces/mace_piece.tscn"),
			preload("res://scenes/pieces/rage_piece.tscn"),
			preload("res://scenes/pieces/barb_shield_piece.tscn"),
			preload("res://scenes/pieces/material_piece.tscn"),]
		possible_pieces.append_array(barbarian_pieces)
	if RelicManager.current_pieces.size() > 0:
		possible_pieces.append_array(RelicManager.current_pieces)
	
	if LevelManager.type == "Treasure":
		possible_pieces.clear()
		var gems_pieces = [
			preload("res://scenes/pieces/gems/red_gem_piece.tscn"),
			preload("res://scenes/pieces/gems/blue_gem_piece.tscn"),
			preload("res://scenes/pieces/gems/green_gem_piece.tscn"),
			preload("res://scenes/pieces/gems/yellow_gem_piece.tscn"),
			preload("res://scenes/pieces/gems/gold_piece.tscn"),]
		possible_pieces.append_array(gems_pieces)
		
func make_2d_array():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array

	
func restricted_movement(place):
	if empty_spaces != null:
		for i in empty_spaces:
			if i == place:
				return true
		return false

func spawn_pieces():
	for i in width:
		for j in height:
			if !restricted_movement(Vector2(i,j)) and all_pieces[i][j] == null:
				var rand = floor(randf_range(0, possible_pieces.size()))
				var loops = 0
				var piece = possible_pieces[rand].instantiate()
				while match_at(i, j, piece.color) && loops < 100:
					rand = floor(randf_range(0, possible_pieces.size()))
					loops += 1
					piece = possible_pieces[rand].instantiate()
				
				add_child(piece)
				piece.position = grid_to_pixel(i, j)
				all_pieces[i][j] = piece
	if is_deadlocked():
		$ShuffleTimer.start()
	$HintTimer.start()
# i = column and j = row
func match_at(i, j, color):
	if i > 1:
		if all_pieces[i-1][j] != null && all_pieces[i -2][j] != null:
			if all_pieces[i-1][j].color == color && all_pieces[i-2][j].color == color:
				return true
	if j > 1:
		if all_pieces[i][j-1] != null && all_pieces[i][j-2] != null:
			if all_pieces[i][j-1].color == color && all_pieces[i][j-2].color == color:
				return true
			
func grid_to_pixel(column, row):
	var new_x = x_start + offset * column
	var new_y = y_start + -offset * row
	return Vector2(new_x, new_y)

func pixel_to_grid(pixel_x, pixel_y):
	var new_x = round((pixel_x - x_start) / offset)
	var new_y = round((pixel_y - y_start) / -offset)
	return Vector2(new_x, new_y)

func is_in_grid(grid_position):
	if grid_position.x >= 0 && grid_position.x < width:
		if grid_position.y >= 0 && grid_position.y < height:
			return true
	return false
	
func touch_input():
	var mouse = get_global_mouse_position()
	mouse = pixel_to_grid(mouse.x, mouse.y)
	
	if Input.is_action_just_pressed("ui_touch"):
		if is_in_grid(mouse):
			first_touch = mouse
			controlling = true
			if hint:
				destroy_hint()
		else:
			controlling = false
			
	if Input.is_action_just_released("ui_touch"):
		if is_in_grid(mouse) && controlling:
			controlling = false
			final_touch = mouse
			touch_difference(first_touch, final_touch)

func swap_pieces(column, row, direction):
	var firts_piece = all_pieces[column][row]
	var other_piece = all_pieces[column + direction.x][row + direction.y]
	if firts_piece != null && other_piece != null:
		store_info(firts_piece, other_piece, Vector2(column, row), direction)
		state = wait
		all_pieces[column][row] = other_piece
		all_pieces[column + direction.x][row + direction.y] = firts_piece
		firts_piece.move(grid_to_pixel(column + direction.x, row + direction.y))
		other_piece.move(grid_to_pixel(column, row))
		if !move_checked:
			find_matches()

func store_info(first_piece, other_piece, place, direction):
	piece_one = first_piece
	piece_two = other_piece
	last_place = place
	last_direction = direction

func swap_back():
	if piece_one != null && piece_two != null:
		swap_pieces(last_place.x, last_place.y, last_direction)
	state = move
	move_checked = false
	$HintTimer.start()

func touch_difference(grid_1, grid_2):
	var difference = grid_2 - grid_1
	if abs(difference.x) > abs(difference.y):
		if difference.x > 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(1, 0))
		elif difference.x < 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(-1, 0))
	elif abs(difference.y) > abs(difference.x):
		if difference.y > 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(0, 1))
		elif difference.y < 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(0, -1))
			
func find_matches(query = false, array = all_pieces):
	for i in width:
		for j in height:
			if array[i][j] != null:
				var current_color = array[i][j].color
				if i > 0 && i < width - 1:
					if array[i - 1][j] != null && array[i + 1][j] != null:
						if array[i - 1][j].color == current_color && array[i + 1][j].color == current_color:
							if query:
								match_color = current_color
								return true
							array[i - 1][j].matched = true
							array[i - 1][j].dim()
							array[i][j].matched = true
							array[i][j].dim()
							array[i + 1][j].matched = true
							array[i + 1][j].dim()
				if j > 0 && j < height - 1:
					if array[i][j - 1] != null && array[i][j + 1] != null:
						if array[i][j - 1].color == current_color && array[i][j + 1].color == current_color:
							if query:
								match_color = current_color
								return true
							array[i][j - 1].matched = true
							array[i][j - 1].dim()
							array[i][j].matched = true
							array[i][j].dim()
							array[i][j + 1].matched = true
							array[i][j + 1].dim()
	if query:
		return false
	var timer = %DestroyTimer
	timer.start()

func make_effect(effect, column, row, color):
	var current = effect.instantiate()
	current.position = grid_to_pixel(column,row)
	add_child(current)
	current.color = Color(color.x, color.y, color.z)

func material_effect(effect,column, row):
	var current = effect.instantiate()
	current.position = grid_to_pixel(column,row)
	add_child(current)

	
func destroy_matched():
	var red_gem_load = 0
	var blue_gem_load = 0
	var green_gem_load = 0
	var yellow_gem_load = 0
	var gold_load = 0
	var shield_load = 0
	var shield_effect_position = Vector2(0,0)
	var material_load = 0
	var sword_load = 0
	var bow_load = 0
	var axe_load = 0
	var mace_load = 0
	var rage_load = 0
	var invisibility_load = 0
	var bolt_staff_load = 0
	var crossbow_load = 0
	var flail_load = 0
	var ice_staff_load = 0
	var maul_load = 0
	var sickle_load = 0
	
	
	
	var was_matched = false
	for i in width:
		for j in height:
			if all_pieces[i][j] != null:
				if all_pieces[i][j].matched:
					was_matched = true
					#Gems
					if all_pieces[i][j].color == "red":
						red_gem_load += 1
						$TileBreakSFX.play()
						material_effect(red_gem_effect,i,j)
					elif all_pieces[i][j].color == "green":
						green_gem_load += 1
						$TileBreakSFX.play()
						material_effect(green_gem_effect,i,j)
					elif all_pieces[i][j].color == "blue":
						blue_gem_load += 1
						$TileBreakSFX.play()
						material_effect(blue_gem_effect,i,j)
					elif all_pieces[i][j].color == "yellow":
						yellow_gem_load += 1
						$TileBreakSFX.play()
						material_effect(yellow_gem_effect,i,j)
					elif all_pieces[i][j].color == "gold":
						gold_load += 1
						$TileBreakSFX.play()
						material_effect(coin_effect,i,j)
					#Attacks
					#Rogue
					if all_pieces[i][j].color == "sword":
						sword_load += 1
						$TileBreakSFX.play()
						Sfx.play_SFX(Sfx.sword)
					elif all_pieces[i][j].color == "bow":
						bow_load += 1
						$TileBreakSFX.play()
						Sfx.play_SFX(Sfx.bow)
					elif all_pieces[i][j].color == "invisibility":
						invisibility_load += 1
						$TileBreakSFX.play()
						Sfx.play_SFX(Sfx.invisibility)
					#Barbarian
					elif all_pieces[i][j].color == "axe":
						axe_load += 1
						$TileBreakSFX.play()
						Sfx.play_SFX(Sfx.axe)
					elif all_pieces[i][j].color == "mace":
						mace_load += 1
						$TileBreakSFX.play()
						Sfx.play_SFX(Sfx.mace)
					elif all_pieces[i][j].color == "rage":
						rage_load += 1
						$TileBreakSFX.play()
						Sfx.play_SFX(Sfx.rage)
					
					#Shop pieces 
					#ADD SFX
					if all_pieces[i][j].color == "bolt":
						bolt_staff_load += 1
						$TileBreakSFX.play()
					elif all_pieces[i][j].color == "crossbow":
						crossbow_load += 1
						$TileBreakSFX.play()
					elif all_pieces[i][j].color == "flail":
						flail_load += 1
						$TileBreakSFX.play()
					elif all_pieces[i][j].color == "ice":
						ice_staff_load += 1
						$TileBreakSFX.play()
					elif all_pieces[i][j].color == "maul":
						maul_load += 1
						$TileBreakSFX.play()
					elif all_pieces[i][j].color == "sickle":
						sickle_load += 1
						$TileBreakSFX.play()
					
					
					
					#Extras
					elif all_pieces[i][j].color == "barbarian shield":
						shield_load += 1
					elif all_pieces[i][j].color == "rogue shield":
						shield_load += 1
					elif all_pieces[i][j].color == "shield":
						shield_load += 1
					elif all_pieces[i][j].color == "material":
						Sfx.play_SFX(Sfx.material)
						material_load += 1
						if EnemyManager.enemy.status == "alive":
							var random_material = randi_range(1,3)
							if random_material == 1:
								material_effect(wood_effect, i, j)
							elif random_material == 2:
								material_effect(stone_effect, i, j)
							elif random_material == 3:
								material_effect(iron_effect, i, j)
					
					if shield_load > 0:
						shield_effect_position.x = i
						shield_effect_position.y = j
					var color = all_pieces[i][j].background_color
					all_pieces[i][j].queue_free()
					all_pieces[i][j] = null
					make_effect(particle_effect, i, j, color)
	######################################################################
	if red_gem_load == 4:
		emit_signal("camera_effect", 10)
	elif red_gem_load >= 5:
		emit_signal("camera_effect", 20)
	if blue_gem_load == 4:
		emit_signal("camera_effect", 10)
	elif blue_gem_load >= 5:
		emit_signal("camera_effect", 20)
	if green_gem_load == 4:
		emit_signal("camera_effect", 10)
	elif green_gem_load >= 5:
		emit_signal("camera_effect", 20)
	if yellow_gem_load == 4:
		emit_signal("camera_effect", 10)
	elif yellow_gem_load >= 5:
		emit_signal("camera_effect", 20)
	if gold_load == 4:
		emit_signal("camera_effect", 10)
	elif gold_load >= 5:
		emit_signal("camera_effect", 20)
		
	#Shield load
	if shield_load == 3:
		$TileBreakSFX.play()
		Sfx.play_SFX(Sfx.shield)
		PlayerManager.player.shield_to_be_loaded = PlayerManager.player.shield_load
		material_effect(shield_effect, shield_effect_position.x, shield_effect_position.y)
	elif shield_load == 4:
		$TileBreakSFX.play()
		Sfx.play_SFX(Sfx.shield)
		PlayerManager.player.shield_to_be_loaded = PlayerManager.player.shield_load + 1
		material_effect(shield_effect, shield_effect_position.x, shield_effect_position.y)
		emit_signal("camera_effect", 10)
	elif shield_load >= 5:
		$TileBreakSFX.play()
		Sfx.play_SFX(Sfx.shield)
		PlayerManager.player.shield_to_be_loaded = PlayerManager.player.shield_load + 2
		material_effect(shield_effect, shield_effect_position.x, shield_effect_position.y)
		emit_signal("camera_effect", 20)
	#Material load
	if material_load == 4:
		emit_signal("camera_effect", 10)
	elif material_load >= 5:
		emit_signal("camera_effect", 20)
	
	#Shop pieces
	#Bolt staff
	if bolt_staff_load == 3:
		PlayerManager.player.piece_multiplier = 1
		#animation
		PlayerManager.player.base_action4 = Vector2(5,7)
		PlayerManager.player.damage4_attack()
	elif bolt_staff_load == 4:
		PlayerManager.player.piece_multiplier = 1.5
		#animation
		PlayerManager.player.base_action4 = Vector2(5,7)
		PlayerManager.player.damage4_attack()
		emit_signal("camera_effect", 10)
	elif bolt_staff_load >= 5:
		PlayerManager.player.piece_multiplier = 2
		#animation
		PlayerManager.player.base_action4 = Vector2(5,7)
		PlayerManager.player.damage4_attack()
		emit_signal("camera_effect", 20)
	#Crossbow
	if crossbow_load == 3:
		PlayerManager.player.piece_multiplier = 1
		#animation
		PlayerManager.player.base_action4 = Vector2(2,10)
		PlayerManager.player.damage4_attack()
	elif crossbow_load == 4:
		PlayerManager.player.piece_multiplier = 1.5
		#animation
		PlayerManager.player.base_action4 = Vector2(2,10)
		PlayerManager.player.damage4_attack()
		emit_signal("camera_effect", 10)
	elif crossbow_load >= 5:
		PlayerManager.player.piece_multiplier = 2
		#animation
		PlayerManager.player.base_action4 = Vector2(2,10)
		PlayerManager.player.damage4_attack()
		emit_signal("camera_effect", 20)
	#Flail
	if flail_load == 3:
		PlayerManager.player.piece_multiplier = 1
		#animation
		PlayerManager.player.base_action4 = Vector2(6,8)
		PlayerManager.player.damage4_attack()
	elif flail_load == 4:
		PlayerManager.player.piece_multiplier = 1.5
		#animation
		PlayerManager.player.base_action4 = Vector2(6,8)
		PlayerManager.player.damage4_attack()
		emit_signal("camera_effect", 10)
	elif flail_load >= 5:
		PlayerManager.player.piece_multiplier = 2
		#animation
		PlayerManager.player.base_action4 = Vector2(6,8)
		PlayerManager.player.damage4_attack()
		emit_signal("camera_effect", 20)
	#Ice Staff
	if ice_staff_load == 3:
		PlayerManager.player.piece_multiplier = 1
		#animation
		PlayerManager.player.base_action4 = Vector2(5,9)
		PlayerManager.player.damage4_attack()
	elif ice_staff_load == 4:
		PlayerManager.player.piece_multiplier = 1.5
		#animation
		PlayerManager.player.base_action4 = Vector2(5,9)
		PlayerManager.player.damage4_attack()
		emit_signal("camera_effect", 10)
	elif ice_staff_load >= 5:
		PlayerManager.player.piece_multiplier = 2
		#animation
		PlayerManager.player.base_action4 = Vector2(5,9)
		PlayerManager.player.damage4_attack()
		emit_signal("camera_effect", 20)
	#Maul
	if maul_load == 3:
		PlayerManager.player.piece_multiplier = 1
		#animation
		PlayerManager.player.base_action4 = Vector2(7,8)
		PlayerManager.player.damage4_attack()
	elif maul_load == 4:
		PlayerManager.player.piece_multiplier = 1.5
		#animation
		PlayerManager.player.base_action4 = Vector2(7,8)
		PlayerManager.player.damage4_attack()
		emit_signal("camera_effect", 10)
	elif maul_load >= 5:
		PlayerManager.player.piece_multiplier = 2
		#animation
		PlayerManager.player.base_action4 = Vector2(7,8)
		PlayerManager.player.damage4_attack()
		emit_signal("camera_effect", 20)
	#Sickle
	if sickle_load == 3:
		PlayerManager.player.piece_multiplier = 1
		#animation
		PlayerManager.player.base_action4 = Vector2(1,10)
		PlayerManager.player.damage4_attack()
	elif sickle_load == 4:
		PlayerManager.player.piece_multiplier = 1.5
		#animation
		PlayerManager.player.base_action4 = Vector2(1,10)
		PlayerManager.player.damage4_attack()
		emit_signal("camera_effect", 10)
	elif sickle_load >= 5:
		PlayerManager.player.piece_multiplier = 2
		#animation
		PlayerManager.player.base_action4 = Vector2(1,10)
		PlayerManager.player.damage4_attack()
		emit_signal("camera_effect", 20)

	#Rogue
	#Sword update
	if sword_load == 3:
		PlayerManager.player.piece_multiplier = 1
		sword_animation()
		PlayerManager.player.damage1_attack()
	elif sword_load == 4:
		PlayerManager.player.piece_multiplier = 1.5
		sword_animation()
		PlayerManager.player.damage1_attack()
		emit_signal("camera_effect", 10)
	elif sword_load >= 5:
		PlayerManager.player.piece_multiplier = 2
		sword_animation()
		PlayerManager.player.damage1_attack()
		emit_signal("camera_effect", 20)
	#Bow update
	if bow_load == 3:
		PlayerManager.player.poison_rarities["poison"] = PlayerManager.player.poison_chance
		PlayerManager.player.poison_rarities["nothing"] = 100 - PlayerManager.player.poison_chance
		PlayerManager.player.has_bow_poison = true
		PlayerManager.player.piece_multiplier = 1
		PlayerManager.player.damage2_attack()
		bow_animation()
		PlayerManager.player.check_for_poison_arrow = false
	elif bow_load == 4:
		PlayerManager.player.poison_rarities["poison"] = PlayerManager.player.poison_chance + 25
		PlayerManager.player.poison_rarities["nothing"] = 100 - PlayerManager.player.poison_chance - 25
		PlayerManager.player.has_bow_poison = true
		PlayerManager.player.piece_multiplier = 1.5
		PlayerManager.player.damage2_attack()
		bow_animation()
		PlayerManager.player.check_for_poison_arrow = false
		emit_signal("camera_effect", 10)
	elif bow_load >= 5:
		PlayerManager.player.poison_rarities["poison"] = 100
		PlayerManager.player.poison_rarities["nothing"] = 0
		PlayerManager.player.has_bow_poison = true
		PlayerManager.player.piece_multiplier = 2
		PlayerManager.player.damage2_attack()
		bow_animation()
		PlayerManager.player.check_for_poison_arrow = false
		emit_signal("camera_effect", 20)
	#Invisibility update
	if invisibility_load == 3:
		PlayerManager.player.invisibility_rarities["invisibility"] = PlayerManager.player.invisibility_chance
		PlayerManager.player.invisibility_rarities["nothing"] = 100 - PlayerManager.player.invisibility_chance
		PlayerManager.player.has_invisibility = true
		PlayerManager.player.handle_invisibility()
	elif invisibility_load == 4:
		PlayerManager.player.invisibility_rarities["invisibility"] = PlayerManager.player.invisibility_chance + 25
		PlayerManager.player.invisibility_rarities["nothing"] = 100 - PlayerManager.player.invisibility_chance - 25
		PlayerManager.player.has_invisibility = true
		PlayerManager.player.handle_invisibility()
		emit_signal("camera_effect", 10)
	elif invisibility_load >= 5:
		PlayerManager.player.invisibility_rarities["invisibility"] = 100
		PlayerManager.player.invisibility_rarities["nothing"] = 0
		PlayerManager.player.has_invisibility = true
		PlayerManager.player.handle_invisibility()
		emit_signal("camera_effect", 20)
	######################################################################
	#Barbarian
	#Axe update
	if axe_load == 3:
		PlayerManager.player.piece_multiplier = 1
		axe_animation()
		
		PlayerManager.player.damage1_attack()
	elif axe_load == 4:
		PlayerManager.player.piece_multiplier = 1.5
		axe_animation()
		PlayerManager.player.damage1_attack()
		emit_signal("camera_effect", 10)
	elif axe_load >= 5:
		PlayerManager.player.piece_multiplier = 2
		axe_animation()
		PlayerManager.player.damage1_attack()
		emit_signal("camera_effect", 20)
	#Mace update
	if mace_load == 3:
		PlayerManager.player.mace_stunt_rarities["stunt"] = PlayerManager.player.mace_stunt_chance
		PlayerManager.player.mace_stunt_rarities["nothing"] = 100 - PlayerManager.player.mace_stunt_chance
		PlayerManager.player.has_mace = true
		PlayerManager.player.piece_multiplier = 1
		mace_animation()
		PlayerManager.player.damage2_attack()
	elif mace_load == 4:
		PlayerManager.player.mace_stunt_rarities["stunt"] = PlayerManager.player.mace_stunt_chance + 25
		PlayerManager.player.mace_stunt_rarities["nothing"] = 100 - PlayerManager.player.mace_stunt_chance - 25
		PlayerManager.player.has_mace = true
		PlayerManager.player.piece_multiplier = 1.5
		mace_animation()
		PlayerManager.player.damage2_attack()
		emit_signal("camera_effect", 10)
	elif mace_load >= 5:
		PlayerManager.player.mace_stunt_rarities["stunt"] = 100
		PlayerManager.player.mace_stunt_rarities["nothing"] = 0
		PlayerManager.player.has_mace = true
		PlayerManager.player.piece_multiplier = 2
		mace_animation()
		PlayerManager.player.damage2_attack()
		emit_signal("camera_effect", 20)
	#Rage update
	if rage_load == 3:
		PlayerManager.player.handle_rage(0.2)
	elif rage_load == 4:
		PlayerManager.player.handle_rage(0.4)
		emit_signal("camera_effect", 10)
	elif rage_load >= 5:
		PlayerManager.player.handle_rage(0.6)
		emit_signal("camera_effect", 20)
		
	move_checked = true
	if was_matched:
		var timer = %CollapseTimer
		timer.start()
	else:
		swap_back()

func collapse_columns():
	for i in width:
		for j in height:
			if all_pieces[i][j] == null && !restricted_movement(Vector2(i,j)):
				for k in range(j + 1, height):
					if all_pieces[i][k] != null:
						all_pieces[i][k].move(grid_to_pixel(i, j))
						all_pieces[i][j] = all_pieces[i][k]
						all_pieces[i][k] = null
						break
	var timer = %RefillTimer
	timer.start()
	
func refill_columns():
	for i in width:
		for j in height:
			if all_pieces[i][j] == null && !restricted_movement(Vector2(i,j)):
				var rand = floor(randf_range(0, possible_pieces.size()))
				var loops = 0
				var piece = possible_pieces[rand].instantiate()
				while match_at(i, j, piece.color) && loops < 100:
					rand = floor(randf_range(0, possible_pieces.size()))
					loops += 1
					piece = possible_pieces[rand].instantiate()
				
				add_child(piece)
				piece.position = grid_to_pixel(i, j - y_offset)
				piece.move(grid_to_pixel(i,j))
				all_pieces[i][j] = piece
	after_refill()

func after_refill():
	for i in width:
		for j in height:
			if all_pieces[i][j] != null:
				if match_at(i, j, all_pieces[i][j].color):
					find_matches()
					get_parent().get_node("%DestroyTimer").start()
	state = move
	move_checked = false
	if is_deadlocked():
		$ShuffleTimer.start()
	$HintTimer.start()

func switch_pieces(place, direction, array):
	if is_in_grid(place) and !restricted_movement(place):
		if is_in_grid(place + direction) and !restricted_movement(place + direction):
			var holder = array[place.x + direction.x][place.y + direction.y]
			array[place.x + direction.x][place.y + direction.y] = array[place.x][place.y]
			array[place.x][place.y] = holder

func is_deadlocked():
	clone_array = copy_array(all_pieces)
	for i in width:
		for j in height:
			if switch_and_check(Vector2(i,j), Vector2(1,0), clone_array):
				return false
			if switch_and_check(Vector2(i,j), Vector2(0,1), clone_array):
				return false
	return true

func switch_and_check(place, direction, array):
	switch_pieces(place, direction, array)
	if find_matches(true, array):
		switch_pieces(place, direction, array)
		return true
	switch_pieces(place, direction, array)
	return false

func copy_array(array_to_copy):
	var new_array = make_2d_array()
	for i in width:
		for j in height:
			new_array[i][j] = array_to_copy[i][j]
	return new_array

func clear_and_store_board():
	var holder_array = []
	for i in width:
		for j in height:
			if all_pieces[i][j] != null:
				holder_array.append(all_pieces[i][j])
				all_pieces[i][j] = null
	return holder_array

func shuffle_board():
	var holder_array = clear_and_store_board()
	for i in width:
		for j in height:
			if !restricted_movement(Vector2(i,j)) and all_pieces[i][j] == null:
				var rand = floor(randf_range(0,holder_array.size()))
				var loops = 0
				var piece = holder_array[rand]
				while match_at(i, j, piece.color) && loops < 100:
					rand = floor(randf_range(0,holder_array.size()))
					loops += 1
					piece = holder_array[rand]
				
				piece.move(grid_to_pixel(i,j))
				all_pieces[i][j] = piece
				holder_array.remove_at(rand)
	if is_deadlocked():
		shuffle_board()
	state = move

func find_all_matches():
	var hint_holder = []
	clone_array = copy_array(all_pieces)
	for i in width:
		for j in height:
			if clone_array[i][j] != null:
				if switch_and_check(Vector2(i,j), Vector2(1,0), clone_array) and is_in_grid(Vector2(i + 1, j)):
					if match_color != "":
						if match_color == clone_array[i][j].color:
							hint_holder.append(clone_array[i][j])
						else:
							hint_holder.append(clone_array[i + 1][j])
				if switch_and_check(Vector2(i,j), Vector2(0,1), clone_array) and is_in_grid(Vector2(i, j + 1)):
					if match_color != "":
						if match_color == clone_array[i][j].color:
							hint_holder.append(clone_array[i][j])
						else:
							hint_holder.append(clone_array[i][j + 1])
	return hint_holder

func generate_hint():
	var hints = find_all_matches()
	if hints != null:
		if hints.size() > 0:
			destroy_hint()
			var rand = floor(randi_range(1, hints.size()))
			hint = hint_effect.instantiate()
			add_child(hint)
			hint.position = hints[rand].position
			hint.setup(hints[rand].get_node("Sprite2D").texture, hints[rand].get_node("TextureRect").texture, hints[rand].get_node("TextureRect").modulate)

func destroy_hint():
	if hint:
		hint.queue_free()
		hint = null
		
func _on_destroy_timer_timeout():
	destroy_matched()

func _on_collapse_timer_timeout():
	collapse_columns()

func _on_refill_timer_timeout():
	refill_columns()

#Animations
func sword_animation():
	%SwordAnimation.visible = true
	%SwordAnimation.play("Sword")
	await %SwordAnimation.animation_finished
	%SwordAnimation.visible = false

func bow_animation():
	%BowAnimation.visible = true
	if PlayerManager.player.check_for_poison_arrow == true:
		%BowAnimation.play("BowPoison")
	else:
		%BowAnimation.play("Bow")
	await %BowAnimation.animation_finished
	%BowAnimation.visible = false

func axe_animation():
	%AxeAnimation.visible = true
	%AxeAnimation.play("Axe")
	await %AxeAnimation.animation_finished
	%AxeAnimation.visible = false

func mace_animation():
	%MaceAnimation.visible = true
	%MaceAnimation.play("Mace")
	await %MaceAnimation.animation_finished
	%MaceAnimation.visible = false


func _on_shuffle_timer_timeout():
	shuffle_board()


func _on_hint_timer_timeout():
	#generate_hint()
	pass
