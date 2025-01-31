extends Node2D

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

func destroy_matched():
	var shield_load = 0
	var sword_load = 0
	var magic_load = 0
	var bow_load = 0
	
	var was_matched = false
	for i in width:
		for j in height:
			if all_pieces[i][j] != null:
				if all_pieces[i][j].matched:
					was_matched = true
					if LevelManager.treasure_timesup == false:
						if all_pieces[i][j].color == "red":
							PlayerManager.player.red_gem_up(1)
						elif all_pieces[i][j].color == "green":
							PlayerManager.player.green_gem_up(1)
						elif all_pieces[i][j].color == "blue":
							PlayerManager.player.blue_gem_up(1)
						elif all_pieces[i][j].color == "yellow":
							PlayerManager.player.yellow_gem_up(1)
						elif all_pieces[i][j].color == "gold":
							PlayerManager.player.coins_up()
						
					all_pieces[i][j].queue_free()
					all_pieces[i][j] = null
	
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
