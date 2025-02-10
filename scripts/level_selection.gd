extends TextureButton

@export var type : String
@export var level : int
@export var path : String
@export var enemy_type : String
@export var level_complete : bool





func _ready():
	select_icon()
	select_enemy()


func _process(_delta):
	available_level()
	check_level_done()

func select_icon():
	if type == "Enemy":
		var texture = load("res://assets/32rogues/Icons/Enemy.png")
		$".".texture_normal = texture
		$".".texture_hover = null
		$".".texture_disabled = texture
	elif type == "Treasure":
		var texture = load("res://assets/32rogues/Icons/Treasure.png")
		$".".texture_normal = texture
		$".".texture_hover = null
		$".".texture_disabled = texture
	elif type == "Random Event":
		var texture = load("res://assets/32rogues/Icons/Random Event.png")
		$".".texture_normal = texture
		$".".texture_hover = null
		$".".texture_disabled = texture
	elif type == "Elite Enemy":
		var texture = load("res://assets/32rogues/Icons/Elite Enemy.png")
		$".".texture_normal = texture
		$".".texture_hover = null
		$".".texture_disabled = texture
	elif type == "Rest":
		var texture = load("res://assets/32rogues/Icons/Rest.png")
		$".".texture_normal = texture
		$".".texture_hover = null
		$".".texture_disabled = texture
	elif type == "Boss":
		var texture = load("res://assets/32rogues/Icons/Boss.png")
		$".".texture_normal = texture
		$".".texture_hover = null
		$".".texture_disabled = texture
		
func select_hover_icon():
	if type == "Enemy":
		var texture = load("res://assets/32rogues/Icons/Enemy.png")
		var texture_h = load("res://assets/32rogues/Icons/Enemy_highlighted.png")
		$".".texture_normal = texture
		$".".texture_hover = texture_h
		$".".texture_disabled = texture
	elif type == "Treasure":
		var texture = load("res://assets/32rogues/Icons/Treasure.png")
		var texture_h = load("res://assets/32rogues/Icons/Treasure_highlighted.png")
		$".".texture_normal = texture
		$".".texture_hover = texture_h
		$".".texture_disabled = texture
	elif type == "Random Event":
		var texture = load("res://assets/32rogues/Icons/Random Event.png")
		var texture_h = load("res://assets/32rogues/Icons/Random Event_highlighted.png")
		$".".texture_normal = texture
		$".".texture_hover = texture_h
		$".".texture_disabled = texture
	elif type == "Elite Enemy":
		var texture = load("res://assets/32rogues/Icons/Elite Enemy.png")
		var texture_h = load("res://assets/32rogues/Icons/Elite Enemy_highlighted.png")
		$".".texture_normal = texture
		$".".texture_hover = texture_h
		$".".texture_disabled = texture
	elif type == "Rest":
		var texture = load("res://assets/32rogues/Icons/Rest.png")
		var texture_h = load("res://assets/32rogues/Icons/Rest_highlighted.png")
		$".".texture_normal = texture
		$".".texture_hover = texture_h
		$".".texture_disabled = texture
	elif type == "Boss":
		var texture = load("res://assets/32rogues/Icons/Boss.png")
		var texture_h = load("res://assets/32rogues/Icons/Boss_highlighted.png")
		$".".texture_normal = texture
		$".".texture_hover = texture_h
		$".".texture_disabled = texture

func select_enemy():
	if LevelManager.floor == 1:
		if type == "Enemy":
			if level == 1 or 2 or 3:
				var random = randi_range(1, 3)
				if random == 1:
					enemy_type = "Spider"
				elif random == 2:
					enemy_type = "Rat"
				elif random == 3:
					enemy_type = "Wolf"
			elif level == 4 or 5:
				var random = randi_range(1, 7)
				if random == 1:
					enemy_type = "Spider"
				elif random == 2:
					enemy_type = "Rat"
				elif random == 3:
					enemy_type = "Wolf"
				elif random == 4:
					enemy_type = "Zombie"
				elif random == 5:
					enemy_type = "Ghoul"
				elif random == 6:
					enemy_type = "Lamprey"
				elif random == 7:
					enemy_type = "Crone"
			elif level == 6 or 7 or 8 or 9:
				var random = randi_range(1, 4)
				if random == 1:
					enemy_type = "Zombie"
				elif random == 2:
					enemy_type = "Ghoul"
				elif random == 3:
					enemy_type = "Lamprey"
				elif random == 4:
					enemy_type = "Crone"
		elif type == "Elite Enemy":
			var random = randi_range(1, 3)
			if random == 1:
				enemy_type = "Hag"
			elif random == 2:
				enemy_type = "Ghost"
			elif random == 3:
				enemy_type = "Ghost Warrior"
		elif type == "Boss":
			enemy_type = "Demon Boss"
	elif LevelManager.floor == 2:
		if type == "Enemy":
			if level == 11 or 12 or 13:
				var random = randi_range(1, 3)
				if random == 1:
					enemy_type = "Ratten"
				elif random == 2:
					enemy_type = "Rattena"
				elif random == 3:
					enemy_type = "Shroom"
			elif level == 14 or 15:
				var random = randi_range(1, 7)
				if random == 1:
					enemy_type = "Ratten"
				elif random == 2:
					enemy_type = "Rattena"
				elif random == 3:
					enemy_type = "Shroom"
				elif random == 4:
					enemy_type = "Gnome"
				elif random == 5:
					enemy_type = "Ghoul"
				elif random == 6:
					enemy_type = "Warewolf"
				elif random == 7:
					enemy_type = "Gator"
			elif level == 16 or 17 or 18 or 19 or 20 or 21 or 22 or 23:
				var random = randi_range(1, 4)
				if random == 1:
					enemy_type = "Gotten"
				elif random == 2:
					enemy_type = "Ghoul"
				elif random == 3:
					enemy_type = "Warewolf"
				elif random == 4:
					enemy_type = "Gator"
		elif type == "Elite Enemy":
			var random = randi_range(1, 3)
			if random == 1:
				enemy_type = "Medusa"
			elif random == 2:
				enemy_type = "Minotaur"
			elif random == 3:
				enemy_type = "Leshen"
		elif type == "Boss":
			enemy_type = "Dragon Boss"
	elif LevelManager.floor == 3:
		if type == "Enemy":
			if level == 24 or 25 or 26 or 27:
				var random = randi_range(1, 3)
				if random == 1:
					enemy_type = "Skeleton"
				elif random == 2:
					enemy_type = "Skeleton Archer"
				elif random == 3:
					enemy_type = "Skeleton Mage"
			elif level == 28 or 29 or 30:
				var random = randi_range(1, 7)
				if random == 1:
					enemy_type = "Skeleton"
				elif random == 2:
					enemy_type = "Skeleton Archer"
				elif random == 3:
					enemy_type = "Skeleton Mage"
				elif random == 4:
					enemy_type = "Mystic"
				elif random == 5:
					enemy_type = "Ghost Warrior"
				elif random == 6:
					enemy_type = "Ghost Warrior"
				elif random == 7:
					enemy_type = "Hag"
			elif level == 31 or 32 or 33 or 34 or 35 or 36 or 37 or 38 or 39:
				var random = randi_range(1, 4)
				if random == 1:
					enemy_type = "Priest"
				elif random == 2:
					enemy_type = "Mystic"
				elif random == 3:
					enemy_type = "Ghost Warrior"
				elif random == 4:
					enemy_type = "Hag"
		elif type == "Elite Enemy":
			var random = randi_range(1, 3)
			if random == 1:
				enemy_type = "Sly"
			elif random == 2:
				enemy_type = "Mystery"
			elif random == 3:
				enemy_type = "Wraith"
		elif type == "Boss":
			enemy_type = "Basilisk"
	elif LevelManager.floor == 4:
		if type == "Enemy":
			if level == 40 or 41 or 42:
				var random = randi_range(1, 2)
				if random == 1:
					enemy_type = "Formicidae"
				elif random == 2:
					enemy_type = "Divine"
			elif level == 43 or 44 or 45:
				var random = randi_range(1, 5)
				if random == 1:
					enemy_type = "Formicidae"
				elif random == 2:
					enemy_type = "Divine"
				elif random == 3:
					enemy_type = "Centipeda"
				elif random == 4:
					enemy_type = "Nemean"
				elif random == 5:
					enemy_type = "Torment"
			elif level == 46 or 47 or 48 or 49 or 50:
				var random = randi_range(1, 3)
				if random == 1:
					enemy_type = "Centipeda"
				elif random == 2:
					enemy_type = "Nemean"
				elif random == 3:
					enemy_type = "Torment"
		elif type == "Elite Enemy":
			var random = randi_range(1, 4)
			if random == 1:
				enemy_type = "Haidomyrmecinae"
			elif random == 2:
				enemy_type = "Angel"
			elif random == 3:
				enemy_type = "Microchaetus"
			elif random == 4:
				enemy_type = "Torment Us"
		elif type == "Boss":
			enemy_type = "Devil Boss"
			
	print(enemy_type)
	
func select_type():
	LevelManager.show_map = false
	LevelManager.type = type
	Loading.loading_1s()
	if type == "Enemy":
		EnemyManager.type = enemy_type
		get_tree().change_scene_to_file("res://scenes/dungeons/enemy_selection.tscn")
	
	elif type == "Elite Enemy":
		EnemyManager.type = enemy_type
		get_tree().change_scene_to_file("res://scenes/dungeons/enemy_selection.tscn")
	
	elif type == "Boss":
		EnemyManager.type = enemy_type
		get_tree().change_scene_to_file("res://scenes/dungeons/enemy_selection.tscn")
	
	elif type == "Treasure":
		get_tree().change_scene_to_file("res://scenes/treasure.tscn")
	
	elif type == "Rest":
		get_tree().change_scene_to_file("res://scenes/dungeons/rest.tscn")
		
	elif type == "Random Event":
		get_tree().change_scene_to_file("res://scenes/dungeons/random_event.tscn")


func chose_path():
	LevelManager.chosen_path = path
	print(LevelManager.chosen_path)
	
func check_level_done():
	if LevelManager.level_done >= level:
		$LevelDone.visible = true
		disabled = true
	else:
		$LevelDone.visible = false
		disabled = false

func available_level():
	if LevelManager.available_level == level and path == "ABC":
		disabled = false
		select_hover_icon()
	elif LevelManager.available_level == level and LevelManager.chosen_path == "ABC":
		disabled = false
		select_hover_icon()
	elif LevelManager.available_level == level and LevelManager.chosen_path == "A" and path == "ABCA" or LevelManager.available_level == level and LevelManager.chosen_path == "B" and path == "ABCA":
		disabled = false
		select_hover_icon()
	elif LevelManager.available_level == level and LevelManager.chosen_path == "ABCA" and path == "A" or LevelManager.available_level == level and LevelManager.chosen_path == "ABCA" and path == "B":
		disabled = false
		select_hover_icon()
	elif LevelManager.available_level == level and LevelManager.chosen_path == "C" and path == "ABCB" or LevelManager.available_level == level and LevelManager.chosen_path == "D" and path == "ABCB":
		disabled = false
		select_hover_icon()
	elif LevelManager.available_level == level and LevelManager.chosen_path == "ABCB" and path == "C" or LevelManager.available_level == level and LevelManager.chosen_path == "ABCB" and path == "D":
		disabled = false
		select_hover_icon()
	elif LevelManager.available_level == level and LevelManager.chosen_path == path:
		disabled = false
		select_hover_icon()
	else:
		disabled = true
		$".".texture_hover = null
		
func update_available_level():
	LevelManager.available_level = level + 1
	
		
		
		
func _on_pressed():
	chose_path()
	check_level_done()
	update_available_level()
	select_type()
