extends Node2D

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

#Possible pieces array
var possible_pieces = [
	preload("res://scenes/pieces/shield_piece.tscn"),
	preload("res://scenes/pieces/material_piece.tscn"),
]



#Current pieces in scene
var all_pieces = []

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
	spawn_pieces()

func _process(_delta):
	if EnemyManager.enemy.status == "dead":
		state = wait
	if state == move:
		touch_input()

func choose_player_type():
	if SaveManager.autosave_data.player_data.type == "Rogue":
		var rogue_pieces = [
			preload("res://scenes/pieces/sword_piece.tscn"),
			preload("res://scenes/pieces/bow_piece.tscn"),
			preload("res://scenes/pieces/shuriken_piece.tscn"),]
		possible_pieces.append_array(rogue_pieces)
	elif SaveManager.autosave_data.player_data.type == "Barbarian":
		var barbarian_pieces = [
			preload("res://scenes/pieces/axe_piece.tscn"),
			preload("res://scenes/pieces/mace_piece.tscn"),
			preload("res://scenes/pieces/rage_piece.tscn"),]
		possible_pieces.append_array(barbarian_pieces)
		
func make_2d_array():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array


func spawn_pieces():
	for i in width:
		for j in height:
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
	pass

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
			
func find_matches():
	for i in width:
		for j in height:
			if all_pieces[i][j] != null:
				var current_color = all_pieces[i][j].color
				if i > 0 && i < width - 1:
					if all_pieces[i - 1][j] != null && all_pieces[i + 1][j] != null:
						if all_pieces[i - 1][j].color == current_color && all_pieces[i + 1][j].color == current_color:
							all_pieces[i - 1][j].matched = true
							all_pieces[i - 1][j].dim()
							all_pieces[i][j].matched = true
							all_pieces[i][j].dim()
							all_pieces[i + 1][j].matched = true
							all_pieces[i + 1][j].dim()
				if j > 0 && j < height - 1:
					if all_pieces[i][j - 1] != null && all_pieces[i][j + 1] != null:
						if all_pieces[i][j - 1].color == current_color && all_pieces[i][j + 1].color == current_color:
							all_pieces[i][j - 1].matched = true
							all_pieces[i][j - 1].dim()
							all_pieces[i][j].matched = true
							all_pieces[i][j].dim()
							all_pieces[i][j + 1].matched = true
							all_pieces[i][j + 1].dim()
	var timer = %DestroyTimer
	timer.start()

func destroy_matched():
	var shield_load = 0
	var sword_load = 0
	var magic_load = 0
	var bow_load = 0
	var shuriken_load = 0
	var axe_load = 0
	var mace_load = 0
	var rage_load = 0
	
	var was_matched = false
	for i in width:
		for j in height:
			if all_pieces[i][j] != null:
				if all_pieces[i][j].matched:
					was_matched = true
					#Attacks
					#Rogue
					if all_pieces[i][j].color == "sword":
						sword_load += 1
					elif all_pieces[i][j].color == "bow":
						bow_load += 1
					elif all_pieces[i][j].color == "shuriken":
						shuriken_load += 1
					#Barbarian
					elif all_pieces[i][j].color == "axe":
						axe_load += 1
					elif all_pieces[i][j].color == "mace":
						mace_load += 1
					elif all_pieces[i][j].color == "rage":
						rage_load += 1
					
					#Extras
					elif all_pieces[i][j].color == "shield":
						shield_load += 1
					elif all_pieces[i][j].color == "material":
						PlayerManager.player.material_up()
					
					
					all_pieces[i][j].queue_free()
					all_pieces[i][j] = null
	#Shield update
	if shield_load == 3:
		PlayerManager.player.shield_up(PlayerManager.player.shield_load)
		shield_load = 0
	elif shield_load == 4:
		PlayerManager.player.shield_up(PlayerManager.player.shield_load + 1)
		shield_load = 0
	elif shield_load >= 5:
		PlayerManager.player.shield_up(PlayerManager.player.shield_load + 2)
		
	######################################################################
	#Rogue
	#Sword update
	if sword_load == 3:
		PlayerManager.player.piece_multiplier = 1
		PlayerManager.player.damage1_attack()
	elif sword_load == 4:
		PlayerManager.player.piece_multiplier = 1.5
		PlayerManager.player.damage1_attack()
	elif sword_load >= 5:
		PlayerManager.player.piece_multiplier = 2
		PlayerManager.player.damage1_attack()
	#Bow update
	if bow_load == 3:
		PlayerManager.player.piece_multiplier = 1	
		PlayerManager.player.damage2_attack()
	elif bow_load == 4:
		PlayerManager.player.piece_multiplier = 1.5	
		PlayerManager.player.damage2_attack()
	elif bow_load >= 5:
		PlayerManager.player.piece_multiplier = 2	
		PlayerManager.player.damage2_attack()
	#Shuriken update
	if shuriken_load == 3:
		PlayerManager.player.piece_multiplier = 1	
		PlayerManager.player.damage3_attack()
	elif shuriken_load == 4:
		PlayerManager.player.piece_multiplier = 1.5	
		PlayerManager.player.damage3_attack()
	elif shuriken_load >= 5:
		PlayerManager.player.piece_multiplier = 2	
		PlayerManager.player.damage3_attack()
	######################################################################
	#Barbarian
	#Axe update
	if axe_load == 3:
		PlayerManager.player.piece_multiplier = 1
		PlayerManager.player.damage1_attack()
	elif axe_load == 4:
		PlayerManager.player.piece_multiplier = 1.5
		PlayerManager.player.damage1_attack()
	elif axe_load >= 5:
		PlayerManager.player.piece_multiplier = 2
		PlayerManager.player.damage1_attack()
	#Mace update
	if mace_load == 3:
		PlayerManager.player.piece_multiplier = 1	
		PlayerManager.player.damage2_attack()
	elif mace_load == 4:
		PlayerManager.player.piece_multiplier = 1.5	
		PlayerManager.player.damage2_attack()
	elif mace_load >= 5:
		PlayerManager.player.piece_multiplier = 2	
		PlayerManager.player.damage2_attack()
	#Rage update
	if rage_load == 3:
		PlayerManager.player.handle_rage(0.2)
	elif rage_load == 4:
		PlayerManager.player.handle_rage(0.4)
	elif rage_load >= 5:
		PlayerManager.player.handle_rage(0.6)
		
	move_checked = true
	if was_matched:
		var timer = %CollapseTimer
		timer.start()
	else:
		swap_back()



func hit():
	print("hit")

func collapse_columns():
	for i in width:
		for j in height:
			if all_pieces[i][j] == null:
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
			if all_pieces[i][j] == null:
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
	
func _on_destroy_timer_timeout():
	destroy_matched()

func _on_collapse_timer_timeout():
	collapse_columns()

func _on_refill_timer_timeout():
	refill_columns()
