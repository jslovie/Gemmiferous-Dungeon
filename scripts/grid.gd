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

@export var shader: ShaderMaterial

@onready var combo_level = $ComboLevel
@onready var combo_level_description = $ComboLevelDescription
@onready var combo_timer = $TextureComboTimer
@onready var explosion_l = $ExplosionL
@onready var explosion_r = $ExplosionR
@onready var buffs = $Buffs




#Effects
var particle_effect: PackedScene = preload("res://scenes/pieces/particle.tscn")
var wood_effect: PackedScene = preload("res://scenes/GUI/wood_effect.tscn")
var stone_effect: PackedScene = preload("res://scenes/GUI/stone_effect.tscn")
var iron_effect: PackedScene = preload("res://scenes/GUI/iron_effect.tscn")
var shield_effect: PackedScene = preload("res://scenes/GUI/shield_effect.tscn")
var red_gem_effect: PackedScene = preload("res://scenes/GUI/red_gem_treasure.tscn")
var blue_gem_effect: PackedScene = preload("res://scenes/GUI/blue_gem_treasure.tscn")
var green_gem_effect: PackedScene = preload("res://scenes/GUI/green_gem_treasure.tscn")
var yellow_gem_effect: PackedScene = preload("res://scenes/GUI/yellow_gem_treasure.tscn")
var coin_effect: PackedScene = preload("res://scenes/GUI/coin_treasure.tscn")

#Hint effect
@export var hint_effect: PackedScene
var hint = null
var match_color: String = ""

#Possible pieces array
var possible_pieces := []

#Current pieces in scene
var all_pieces := []
var clone_array := []

#Swap back variables
var piece_one = null
var piece_two = null
var last_place = Vector2(0,0)
var last_direction = Vector2(0,0)
var move_checked: bool = false

#Touch variable
var first_touch := Vector2(0, 0)
var final_touch := Vector2(0, 0)
var controlling: bool = false

#Shuffle
var shuffles_left: int = 2

#Treasure
var red_gem_gained: int = 0
var blue_gem_gained: int = 0
var green_gem_gained: int = 0
var yellow_gem_gained: int = 0
var coins_gained: int = 0

var combo_active: bool = true
var jitter_tweens := {}

var base_position_combo_level := Vector2.ZERO
var base_position_combo_level_description := Vector2.ZERO
var base_position_combo_timer:= Vector2.ZERO
var base_position_buffs := Vector2.ZERO

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	change_empty_spaces()
	%ShuffleLabel.text = "x" + str(shuffles_left)
	state = move
	randomize()
	choose_player_type()
	all_pieces = make_2d_array()
	clone_array = make_2d_array()
	spawn_pieces()
	base_position_combo_level = combo_level.position
	base_position_combo_level_description = combo_level_description.position
	base_position_combo_timer = combo_timer.position
	base_position_buffs = buffs.position
	SignalBus.zero_out_combo.connect(_on_zero_out_combo)
	await get_tree().process_frame
	zero_out_combo()
	
func _process(_delta):
	#zero_out_combo()
	check_combo_timer()
	check_buffs()
	%ShuffleLabel.text = "x" + str(shuffles_left)
	if LevelManager.type == "Treasure":
		if LevelManager.treasure_timesup == true:
			state = wait
		pass
	else:
		if EnemyManager.enemy.status == "dead":
			state = wait
	if state == move:
		touch_input()

func change_empty_spaces():
	if RelicManager.has_gem_necklace == true:
		empty_spaces.clear()
		var empty_spaces_list = [Vector2(0,0),Vector2(0,1),Vector2(0,2),Vector2(1,0),Vector2(2,0),Vector2(1,1),
								Vector2(0,9),Vector2(0,8),Vector2(0,7),Vector2(1,9),Vector2(2,9),Vector2(1,8),
								Vector2(7,0),Vector2(6,0),Vector2(5,0),Vector2(7,1),Vector2(7,2),Vector2(6,1),
								Vector2(7,9),Vector2(6,9),Vector2(5,9),Vector2(7,8),Vector2(6,8),Vector2(7,7),]
		empty_spaces.append_array(empty_spaces_list)

func choose_player_type():
	if SaveManager.autosave_data.player_data.type == "Rogue":
		possible_pieces.append_array(RelicManager.rogue_pieces)
	elif SaveManager.autosave_data.player_data.type == "Barbarian":
		possible_pieces.append_array(RelicManager.barbarian_pieces)
	if RelicManager.current_pieces.size() > 0:
		possible_pieces.append_array(RelicManager.current_pieces)
	
	if LevelManager.type == "Treasure":
		possible_pieces.clear()
		possible_pieces.append_array(RelicManager.gems_pieces)
		
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
	if get_tree().paused == true:
		return
	if Input.is_action_just_pressed("ui_touch"):
		var mouse_grid = pixel_to_grid(get_global_mouse_position().x, get_global_mouse_position().y)
		if is_in_grid(mouse_grid):
			first_touch = mouse_grid
			controlling = true
			if hint:
				destroy_hint()
		else:
			controlling = false

	if Input.is_action_just_released("ui_touch") and controlling:
		controlling = false
		var mouse_grid = pixel_to_grid(get_global_mouse_position().x, get_global_mouse_position().y)

		# Clamp the final touch to the nearest valid grid within bounds
		var final_grid = mouse_grid
		final_grid.x = clamp(final_grid.x, 0, width - 1)
		final_grid.y = clamp(final_grid.y, 0, height - 1)

		touch_difference(first_touch, final_grid)

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
	var move_vector = Vector2.ZERO

	# Determine primary direction of movement
	if abs(difference.x) > abs(difference.y):
		move_vector.x = sign(difference.x)
	elif abs(difference.y) > abs(difference.x):
		move_vector.y = sign(difference.y)
	else:
		# If no movement or diagonal (equal), ignore
		return

	# Only attempt swap if adjacent and inside grid
	var target_pos = grid_1 + move_vector
	if is_in_grid(target_pos) and !restricted_movement(grid_1) and !restricted_movement(target_pos):
		swap_pieces(grid_1.x, grid_1.y, move_vector)

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

func make_effect_shuffle(effect, pos, color):
	var current = effect.instantiate()
	current.position = pos
	add_child(current)
	current.color = color

func material_effect(effect,column, row):
	var current = effect.instantiate()
	current.position = grid_to_pixel(column,row)
	add_child(current)


##Matches processing##
func gem_match_sound(gem_effect: PackedScene, i, j):
	Sfx.play_SFX(Sfx.gem)
	$TileBreakSFX.play()
	material_effect(gem_effect,i,j)

func tile_match_sound(tile):
	$TileBreakSFX.play()
	if tile != null:
		Sfx.play_SFX(tile)

func damage_4_match(multiplier: float, attack_magic_color: Color, attack_damage: Vector2, damage_type: String, camera_shake: int):
	process_combo()
	PlayerManager.player.piece_multiplier = multiplier
	if attack_magic_color != Color.TRANSPARENT:
		magic_animation(attack_magic_color)
	PlayerManager.player.base_action4 = attack_damage
	PlayerManager.player.damage4_attack(damage_type)
	if camera_shake != 0:
		emit_signal("camera_effect", camera_shake)

func effect_match(effect_chance: int, effect_chance_change: int, effect_rarity: int, effect_rarity_nothing: int, has_effect: bool, multiplier: float, is_damage: bool, camera_shake: int):
	effect_chance = effect_chance_change
	effect_rarity = effect_chance
	effect_rarity_nothing = 100 - effect_chance
	PlayerManager.player.has_bow_poison = true
	PlayerManager.player.piece_multiplier = multiplier
	if is_damage:
		PlayerManager.player.damage2_attack()
	if camera_shake != 0:
		emit_signal("camera_effect", camera_shake)



func process_combo():
	Combo.combo_level += 1
	Combo.check_combo_level()
	combo_level.text = str(Combo.combo_level)
	if Combo.combo_level >= 20:
		Combo.reset_timer(1.50)
	elif Combo.combo_level >= 15:
		Combo.reset_timer(2.15)
	elif Combo.combo_level > 0:
		Combo.reset_timer(2.75)
	
	if Combo.combo_level == 1:
		combo_active = true
		combo_level.visible = true
		combo_level_description.visible = true
		combo_timer.visible = true
		
	elif Combo.combo_level == 5:
		emit_signal("camera_effect", 20)
		explosion_l.color = Color.DARK_ORANGE
		explosion_r.color = Color.DARK_ORANGE
		explosion_l.restart()
		explosion_r.restart()
		combo_level.add_theme_color_override("font_color", Color.DARK_ORANGE)
		combo_level_description.add_theme_color_override("font_color", Color.DARK_ORANGE)
		combo_timer.tint_progress = Color.DARK_ORANGE
		buffs.modulate = Color.DARK_ORANGE
		start_constant_jitter(combo_level, base_position_combo_level)
		start_constant_jitter(combo_level_description, base_position_combo_level_description)
		start_constant_jitter(combo_timer, base_position_combo_timer)
		start_constant_jitter(buffs, base_position_buffs )
	
	elif Combo.combo_level == 10:
		emit_signal("camera_effect", 30)
		explosion_l.color = Color.DARK_RED
		explosion_r.color = Color.DARK_RED
		explosion_l.restart()
		explosion_r.restart()
		combo_level.add_theme_color_override("font_color", Color.DARK_RED)
		combo_level_description.add_theme_color_override("font_color", Color.DARK_RED)
		combo_timer.tint_progress = Color.DARK_RED
		buffs.modulate = Color.DARK_RED
		
	elif Combo.combo_level == 15:
		emit_signal("camera_effect", 35)
		explosion_l.material = shader
		explosion_r.material = shader
		explosion_l.restart()
		explosion_r.restart()
		combo_level.material = shader
		combo_level_description.material = shader
		combo_timer.material = shader
		for child in buffs.get_children():
			child.material = shader

	elif Combo.combo_level == 20:
		emit_signal("camera_effect", 40)
		explosion_l.restart()
		explosion_r.restart()
		
	elif Combo.combo_level == 25:
		emit_signal("camera_effect", 45)
		explosion_l.restart()
		explosion_r.restart()
		
	play_tweens(combo_level)
	play_tweens(combo_level_description)
	play_tweens(combo_timer)
	
func play_tweens(object):
	combo_flash(object)
	tween_squash_and_stretch(object)
	tween_rotation_shake(object)
	tween_random_jitter(object)

func check_buffs():
	$Buffs/Damage.visible = Combo.damage_buff_active
	$Buffs/Damage.text = "Damage x" + str(PlayerManager.player.combo_multiplier)
	$Buffs/DoubleItems.visible = Combo.double_items_buff_active
	if Combo.double_items_level == 1:
		$Buffs/DoubleItems.text = "Double drops chance"
	else:
		$Buffs/DoubleItems.text = "Double drops"
	$Buffs/StatusResistance.visible = Combo.status_resistance_buff_active
		
func check_combo_timer():
	var timer = Combo.timer
	if timer.is_stopped():
		combo_timer.value = 0
		return
	combo_timer.max_value = timer.wait_time
	combo_timer.value = timer.time_left
		
func zero_out_combo():
	if Combo.combo_level == 0 and combo_active:
		stop_constant_jitter(combo_level, base_position_combo_level)
		stop_constant_jitter(combo_level_description, base_position_combo_level_description)
		stop_constant_jitter(combo_timer, base_position_combo_timer)
		combo_level.material = null
		combo_level_description.material = null
		combo_timer.material = null
		explosion_l.material = null
		explosion_r.material = null
		combo_level.text = "0"
		combo_level.visible = false
		combo_level_description.visible = false
		combo_timer.visible = false
		combo_level.add_theme_color_override("font_color", Color.WHITE)
		combo_level_description.add_theme_color_override("font_color", Color.WHITE)
		combo_timer.tint_progress = Color.WHITE
		for child in buffs.get_children():
			child.material = null

		combo_active = false

##Tweens##
func start_constant_jitter(object,orig_position):
	if jitter_tweens.has(object):
		return

	orig_position = object.position

	var tw = create_tween()
	tw.set_loops()

	tw.tween_callback(func():
		var offset = Vector2(
			randf_range(-2, 2),
			randf_range(-2, 2)
		)
		object.position = orig_position + offset
	).set_delay(0.03)
	
	jitter_tweens[object] = tw

func stop_constant_jitter(object, orig_position):
	if not jitter_tweens.has(object):
		return

	var tw = jitter_tweens[object]
	if tw.is_running():
		tw.kill()

	object.position = orig_position
	jitter_tweens.erase(object)

func tween_squash_and_stretch(object):
	var tw = create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.set_trans(Tween.TRANS_BACK)

	tw.tween_property(object, "scale", Vector2(1.7, 0.5), 0.05)
	tw.tween_property(object, "scale", Vector2(0.7, 1.6), 0.05)
	tw.tween_property(object, "scale", Vector2(1.3, 1.3), 0.05)
	tw.tween_property(object, "scale", Vector2(1, 1), 0.06)

func tween_random_jitter(object):
	var tw = create_tween()

	for i in 7:
		var offset = Vector2(
			randf_range(-10, 10),
			randf_range(-10, 10)
		)
		tw.tween_property(object, "position", object.position + offset, 0.02)

	tw.tween_property(object, "position", object.position, 0.04)

func tween_rotation_shake(object):
	var tw = create_tween()
	tw.set_trans(Tween.TRANS_SINE)
	tw.set_ease(Tween.EASE_OUT)

	tw.tween_property(object, "rotation_degrees", -28, 0.04)
	tw.tween_property(object, "rotation_degrees", 3, 0.04)
	tw.tween_property(object, "rotation_degrees", -18, 0.04)
	tw.tween_property(object, "rotation_degrees", -10, 0.04)

func combo_flash(object):
	var tw = create_tween()
	tw.tween_property(object, "modulate", Color(1, 0.2, 0.2, 1), 0.03)
	tw.tween_property(object, "modulate", Color.WHITE, 0.03)

func destroy_matched():
	if LevelManager.level_active == true:
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
#####################################################################################
						##Matches##
						##Gems##
						if all_pieces[i][j].color == "red":
							red_gem_load += 1
							red_gem_gained += 1
							gem_match_sound(red_gem_effect,i,j)
						elif all_pieces[i][j].color == "green":
							green_gem_load += 1
							green_gem_gained += 1
							gem_match_sound(green_gem_effect,i,j)
						elif all_pieces[i][j].color == "blue":
							blue_gem_load += 1
							blue_gem_gained += 1
							gem_match_sound(blue_gem_effect,i,j)
						elif all_pieces[i][j].color == "yellow":
							yellow_gem_load += 1
							yellow_gem_gained += 1
							gem_match_sound(yellow_gem_effect,i,j)
						elif all_pieces[i][j].color == "gold":
							gold_load += 1
							coins_gained += 1
							gem_match_sound(coin_effect,i,j)

						##Attacks##
						##Rogue##
						if all_pieces[i][j].color == "sword":
							sword_load += 1
							tile_match_sound(Sfx.sword)
						elif all_pieces[i][j].color == "bow":
							bow_load += 1
							tile_match_sound(Sfx.bow)
						elif all_pieces[i][j].color == "invisibility":
							invisibility_load += 1
							tile_match_sound(Sfx.invisibility)
						##Barbarian##
						elif all_pieces[i][j].color == "axe":
							axe_load += 1
							tile_match_sound(Sfx.axe)
						elif all_pieces[i][j].color == "mace":
							mace_load += 1
							tile_match_sound(Sfx.mace)
						elif all_pieces[i][j].color == "rage":
							rage_load += 1
							tile_match_sound(Sfx.rage)

						##Shop pieces##
						if all_pieces[i][j].color == "bolt":
							bolt_staff_load += 1
							tile_match_sound(Sfx.electric)
						elif all_pieces[i][j].color == "crossbow":
							crossbow_load += 1
							tile_match_sound(Sfx.bow)
						elif all_pieces[i][j].color == "flail":
							flail_load += 1
							tile_match_sound(Sfx.axe)
						elif all_pieces[i][j].color == "ice":
							ice_staff_load += 1
							tile_match_sound(Sfx.ice)
						elif all_pieces[i][j].color == "maul":
							maul_load += 1
							tile_match_sound(Sfx.mace)
						elif all_pieces[i][j].color == "sickle":
							sickle_load += 1
							tile_match_sound(Sfx.sword)

						##Extras##
						elif all_pieces[i][j].color == "barbarian shield" or all_pieces[i][j].color == "rogue shield" or all_pieces[i][j].color == "shield":
							shield_load += 1
							tile_match_sound(Sfx.shield)
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
##########################################################################
		##Loads##
		##Gems##
		if red_gem_load == 3 or blue_gem_load == 3 or green_gem_load == 3 or yellow_gem_load == 3 or gold_load == 3:
			process_combo()
		elif red_gem_load == 4 or blue_gem_load == 4 or green_gem_load == 4 or yellow_gem_load == 4 or gold_load == 4:
			process_combo()
			emit_signal("camera_effect", 10)
		elif red_gem_load >= 5 or blue_gem_load >= 5 or green_gem_load >= 5 or yellow_gem_load >= 5 or gold_load >= 5:
			process_combo()
			emit_signal("camera_effect", 20)

		##Shield load##
		if shield_load == 3:
			process_combo()
			PlayerManager.player.shield_to_be_loaded = PlayerManager.player.shield_load + PlayerManager.player.upgraded_shield_load
			material_effect(shield_effect, shield_effect_position.x, shield_effect_position.y)
		elif shield_load == 4:
			process_combo()
			PlayerManager.player.shield_to_be_loaded = PlayerManager.player.shield_load + 1 + PlayerManager.player.upgraded_shield_load
			material_effect(shield_effect, shield_effect_position.x, shield_effect_position.y)
			emit_signal("camera_effect", 10)
		elif shield_load >= 5:
			process_combo()
			PlayerManager.player.shield_to_be_loaded = PlayerManager.player.shield_load + 2 + PlayerManager.player.upgraded_shield_load
			material_effect(shield_effect, shield_effect_position.x, shield_effect_position.y)
			emit_signal("camera_effect", 20)
		##Material load##
		if material_load == 3:
			process_combo()
		elif material_load == 4:
			process_combo()
			emit_signal("camera_effect", 10)
		elif material_load >= 5:
			process_combo()
			emit_signal("camera_effect", 20)

		##Shop pieces##

		##Bolt staff##
		if bolt_staff_load == 3:
			damage_4_match(1,Color.YELLOW,RelicManager.bolt_staff_damage,"electric",0)
		elif bolt_staff_load == 4:
			damage_4_match(1.5,Color.YELLOW,RelicManager.bolt_staff_damage,"electric",10)
		elif bolt_staff_load >= 5:
			damage_4_match(2,Color.YELLOW,RelicManager.bolt_staff_damage,"electric",20)
		##Crossbow##
		if crossbow_load == 3:
			damage_4_match(1,Color.TRANSPARENT,RelicManager.crossbow_damage,"bleed",0)
			bow_animation()
		elif crossbow_load == 4:
			damage_4_match(1.5,Color.TRANSPARENT,RelicManager.rossbow_damage,"bleed",10)
			bow_animation()
		elif crossbow_load >= 5:
			damage_4_match(2,Color.TRANSPARENT,RelicManager.rossbow_damage,"bleed",20)
			bow_animation()
		##Flail##
		if flail_load == 3:
			damage_4_match(1,Color.TRANSPARENT,RelicManager.flail,"flail",0)
			mace_animation()
		elif flail_load == 4:
			damage_4_match(1.5,Color.TRANSPARENT,RelicManager.flail,"flail",10)
			mace_animation()
		elif flail_load >= 5:
			damage_4_match(2,Color.TRANSPARENT,RelicManager.flail,"flail",20)
			mace_animation()
		##Ice Staff##
		if ice_staff_load == 3:
			damage_4_match(1,Color.AQUA,RelicManager.ice_staff_damage,"ice",0)
		elif ice_staff_load == 4:
			damage_4_match(1.5,Color.AQUA,RelicManager.ice_staff_damage,"ice",10)
		elif ice_staff_load >= 5:
			damage_4_match(2,Color.AQUA,RelicManager.ice_staff_damage,"ice",20)
		##Maul##
		if maul_load == 3:
			damage_4_match(1,Color.TRANSPARENT,RelicManager.maul_damage,"weak",0)
			mace_animation()
		elif maul_load == 4:
			damage_4_match(1.5,Color.TRANSPARENT,RelicManager.maul_damage,"weak",10)
			mace_animation()
		elif maul_load >= 5:
			damage_4_match(2,Color.TRANSPARENT,RelicManager.maul_damage,"weak",20)
			mace_animation()
		##Sickle##
		if sickle_load == 3:
			damage_4_match(1,Color.TRANSPARENT,RelicManager.sickle_damage,"vulnerable",0)
			sword_animation()
		elif sickle_load == 4:
			damage_4_match(1.5,Color.TRANSPARENT,RelicManager.sickle_damage,"vulnerable",10)
			sword_animation()
		elif sickle_load >= 5:
			damage_4_match(2,Color.TRANSPARENT,RelicManager.sickle_damage,"vulnerable",20)
			sword_animation()
			
		######################################################################
		##Rogue##
		##Sword update#
		if sword_load == 3:
			process_combo()
			PlayerManager.player.piece_multiplier = 1
			sword_animation()
			PlayerManager.player.damage1_attack()
		elif sword_load == 4:
			process_combo()
			PlayerManager.player.piece_multiplier = 1.5
			sword_animation()
			PlayerManager.player.damage1_attack()
			emit_signal("camera_effect", 10)
		elif sword_load >= 5:
			process_combo()
			PlayerManager.player.piece_multiplier = 2
			sword_animation()
			PlayerManager.player.damage1_attack()
			emit_signal("camera_effect", 20)
		##Bow update##
		if bow_load == 3:
			process_combo()
			effect_match(PlayerManager.player.poison_chance,20,PlayerManager.player.poison_rarities["poison"],PlayerManager.player.poison_rarities["nothing"],PlayerManager.player.has_bow_poison,1,true,0)
			bow_animation()
			PlayerManager.player.check_for_poison_arrow = false
		elif bow_load == 4:
			process_combo()
			effect_match(PlayerManager.player.poison_chance,50,PlayerManager.player.poison_rarities["poison"],PlayerManager.player.poison_rarities["nothing"],PlayerManager.player.has_bow_poison,1.5,true,10)
			bow_animation()
			PlayerManager.player.check_for_poison_arrow = false
		elif bow_load >= 5:
			process_combo()
			effect_match(PlayerManager.player.poison_chance,100,PlayerManager.player.poison_rarities["poison"],PlayerManager.player.poison_rarities["nothing"],PlayerManager.player.has_bow_poison,2,true,20)
			bow_animation()
			PlayerManager.player.check_for_poison_arrow = false
		##Invisibility update##
		if invisibility_load == 3:
			process_combo()
			effect_match(PlayerManager.player.invisibility_chance,20,PlayerManager.player.invisibility_rarities["invisibility"],PlayerManager.player.invisibility_rarities["nothing"],PlayerManager.player.has_invisibility,1,false,0)
			PlayerManager.player.handle_invisibility()
		elif invisibility_load == 4:
			process_combo()
			effect_match(PlayerManager.player.invisibility_chance,50,PlayerManager.player.invisibility_rarities["invisibility"],PlayerManager.player.invisibility_rarities["nothing"],PlayerManager.player.has_invisibility,1.5,false,10)
			PlayerManager.player.handle_invisibility()
		elif invisibility_load >= 5:
			process_combo()
			effect_match(PlayerManager.player.invisibility_chance,100,PlayerManager.player.invisibility_rarities["invisibility"],PlayerManager.player.invisibility_rarities["nothing"],PlayerManager.player.has_invisibility,2,false,20)
			PlayerManager.player.handle_invisibility()
		######################################################################
		##Barbarian##
		##Axe update##
		if axe_load == 3:
			process_combo()
			PlayerManager.player.piece_multiplier = 1
			axe_animation()
			PlayerManager.player.damage1_attack()
		elif axe_load == 4:
			process_combo()
			PlayerManager.player.piece_multiplier = 1.5
			axe_animation()
			PlayerManager.player.damage1_attack()
			emit_signal("camera_effect", 10)
		elif axe_load >= 5:
			process_combo()
			PlayerManager.player.piece_multiplier = 2
			axe_animation()
			PlayerManager.player.damage1_attack()
			emit_signal("camera_effect", 20)
		##Mace update##
		if mace_load == 3:
			process_combo()
			effect_match(PlayerManager.player.mace_stunt_chance,10,PlayerManager.player.mace_stunt_rarities["stunt"],PlayerManager.player.mace_stunt_rarities["nothing"],PlayerManager.player.has_mace,1,true,0)
			mace_animation()
		elif mace_load == 4:
			process_combo()
			effect_match(PlayerManager.player.mace_stunt_chance,25,PlayerManager.player.mace_stunt_rarities["stunt"],PlayerManager.player.mace_stunt_rarities["nothing"],PlayerManager.player.has_mace,1.5,true,10)
			mace_animation()
		elif mace_load >= 5:
			process_combo()
			effect_match(PlayerManager.player.mace_stunt_chance,50,PlayerManager.player.mace_stunt_rarities["stunt"],PlayerManager.player.mace_stunt_rarities["nothing"],PlayerManager.player.has_mace,2,true,20)
			mace_animation()
		#Rage update
		if rage_load == 3:
			process_combo()
			PlayerManager.player.handle_rage(0.2)
		elif rage_load == 4:
			process_combo()
			PlayerManager.player.handle_rage(0.4)
			emit_signal("camera_effect", 10)
		elif rage_load >= 5:
			process_combo()
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
	#clone_array = copy_array(all_pieces)
	#for i in width:
		#for j in height:
			#if switch_and_check(Vector2(i,j), Vector2(1,0), clone_array):
				#return false
			#if switch_and_check(Vector2(i,j), Vector2(0,1), clone_array):
				#return false
	#return true
	clone_array = copy_array(all_pieces)

	for i in width:
		for j in height:
			if clone_array[i][j] != null:
				var place = Vector2(i, j)

				for dir in [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]:
					var new_pos = place + dir
					if is_in_grid(new_pos) and clone_array[new_pos.x][new_pos.y] != null:
						switch_pieces(place, dir, clone_array)
						if find_matches(true, clone_array):
							return false
						switch_pieces(place, dir, clone_array) # swap back

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

func _unhandled_input(event): 
	if  event.is_action_pressed("Refresh"):
		_on_shuffle_pressed()

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

func magic_animation(color):
	%MagicAnimatedSprite2D.visible = true
	%MagicAnimatedSprite2D.modulate = color
	%MagicAnimatedSprite2D.play("Magic")
	await %MagicAnimatedSprite2D.animation_finished
	%MagicAnimatedSprite2D.visible = false
	
func _on_shuffle_timer_timeout():
	shuffle_board()


func _on_hint_timer_timeout():
	#generate_hint()
	pass

func scale_tween_object(object,scale_to,scale_back,time):
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property(object,"scale",scale_to,time)
	tween.tween_property(object,"scale",scale_back,time)

func _on_shuffle_pressed():
	Sfx.play_SFX(Sfx.shuffle)
	scale_tween_object($Shuffle,Vector2(2.4,2.4),Vector2(2,2),0.2)
	emit_signal("camera_effect", 10)
	shuffle_board()
	shuffles_left -= 1
	if shuffles_left == 0:
		$Shuffle.visible = false
		make_effect_shuffle(particle_effect, $Shuffle/Sprite2D.position, $Shuffle/TextureRect.modulate)
		make_effect_shuffle(particle_effect, $Shuffle/Sprite2D.position, $Shuffle/TextureRect.modulate)
		make_effect_shuffle(particle_effect, $Shuffle/Sprite2D.position, $Shuffle/TextureRect.modulate)

func _on_zero_out_combo():
	zero_out_combo()
