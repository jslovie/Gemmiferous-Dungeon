extends Node2D

signal camera_effect

#State Machine
enum {wait, move}
var state
var timesup = false

#Grid variables
@export var width: int
@export var height: int
@export var x_start: int
@export var y_start: int
@export var offset: int
@export var y_offset: int

#Possible pieces array
var possible_pieces = [
	preload("res://scenes/pieces/gems/red_gem_piece.tscn"),
	preload("res://scenes/pieces/gems/green_gem_piece.tscn"),
	preload("res://scenes/pieces/gems/blue_gem_piece.tscn"),
	preload("res://scenes/pieces/gems/yellow_gem_piece.tscn"),
	preload("res://scenes/pieces/gems/gold_piece.tscn"),
	#preload("res://scenes/pieces/material_piece.tscn"),
]

#Effects
var particle_effect = preload("res://scenes/pieces/particle.tscn")
var red_gem_effect = preload("res://scenes/GUI/red_gem_treasure.tscn")
var blue_gem_effect = preload("res://scenes/GUI/blue_gem_treasure.tscn")
var green_gem_effect = preload("res://scenes/GUI/green_gem_treasure.tscn")
var yellow_gem_effect = preload("res://scenes/GUI/yellow_gem_treasure.tscn")
var coin_effect = preload("res://scenes/GUI/coin_treasure.tscn")

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
	all_pieces = make_2d_array()
	spawn_pieces()

func _process(_delta):
	if timesup == true:
		state = wait
	if state == move:
		touch_input()
	
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
	
	var was_matched = false
	for i in width:
		for j in height:
			if all_pieces[i][j] != null:
				if all_pieces[i][j].matched:
					was_matched = true
					if LevelManager.treasure_timesup == false:
						if all_pieces[i][j].color == "red":
							red_gem_load += 1
							material_effect(red_gem_effect,i,j)
						elif all_pieces[i][j].color == "green":
							green_gem_load += 1
							material_effect(green_gem_effect,i,j)
						elif all_pieces[i][j].color == "blue":
							blue_gem_load += 1
							material_effect(blue_gem_effect,i,j)
						elif all_pieces[i][j].color == "yellow":
							yellow_gem_load += 1
							material_effect(yellow_gem_effect,i,j)
						elif all_pieces[i][j].color == "gold":
							gold_load += 1
							material_effect(coin_effect,i,j)
					
					var color = all_pieces[i][j].background_color
					all_pieces[i][j].queue_free()
					all_pieces[i][j] = null
					make_effect(particle_effect, i, j, color)
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


func _on_times_up_timeout():
	timesup = true
