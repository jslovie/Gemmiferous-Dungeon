extends TextureButton

@export var type : String
@export var level : int
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
		%Icon.texture = texture
	elif type == "Treasure":
		var texture = load("res://assets/32rogues/Icons/Treasure.png")
		%Icon.texture = texture
	elif type == "Random Event":
		var texture = load("res://assets/32rogues/Icons/Random Event.png")
		%Icon.texture = texture
	elif type == "Elite Enemy":
		var texture = load("res://assets/32rogues/Icons/Elite Enemy.png")
		%Icon.texture = texture
	elif type == "Rest":
		var texture = load("res://assets/32rogues/Icons/Rest.png")
		%Icon.texture = texture
	elif type == "Boss":
		var texture = load("res://assets/32rogues/Icons/Boss.png")
		%Icon.texture = texture
		
func select_enemy():
	if type == "Enemy":
		if level == 1 or 2 or 3 or 4 or 5:
			var random = randi_range(1, 4)
			if random == 1:
				enemy_type = "Zombie"
			elif random == 2:
				enemy_type = "Spider"
			elif random == 3:
				enemy_type = "Ghoul"
			elif random == 4:
				enemy_type = "Rat"
		elif level == 6 or 7 or 8:
			var random = randi_range(1, 3)
			if random == 1:
				enemy_type = "Skeleton Mage"
			elif random == 2:
				enemy_type = "Skeleton"
			elif random == 3:
				enemy_type = "Skeleton Archer"

	elif type == "Elite Enemy":
		var random = randi_range(1, 3)
		if random == 1:
			enemy_type = "Hag"
		elif random == 2:
			enemy_type = "Ghost"
		elif random == 3:
			enemy_type = "Ghost Warrior"
			
	elif type == "Boss":
		var random = randi_range(1, 3)
		if random == 1:
			enemy_type = "Demon Boss"
		elif random == 2:
			enemy_type = "Dragon Boss"
		elif random == 3:
			enemy_type = "Devil Boss"
		
func select_type():
	LevelManager.show_map = false
	LevelManager.type = type
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
		
func check_level_done():
	if LevelManager.level_done >= level:
		$LevelDone.visible = true
		disabled = true
	else:
		$LevelDone.visible = false
		disabled = false

func available_level():
	if LevelManager.available_level == level:
		disabled = false
	else:
		disabled = true
		
func update_available_level():
	LevelManager.available_level = level + 1
	
		
		
		
func _on_pressed():
	check_level_done()
	update_available_level()
	select_type()
