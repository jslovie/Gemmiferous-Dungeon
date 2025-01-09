extends TextureButton

@export var type : String
@export var level : int
@export var enemy_type : String
@export var level_complete : bool


var level_done = false



func _ready():
	select_icon()
	select_enemy()


func _process(delta):
	available_level()

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

func select_enemy():
	if type == "Enemy":
		if level == 1:
			var random = randi_range(1, 2)
			if random == 1:
				enemy_type = "Skeleton"
			elif random == 2:
				enemy_type = "Spider"
		elif level == 2 or 3:
			var random = randi_range(1, 3)
			if random == 1:
				enemy_type = "Skeleton Mage"
			elif random == 2:
				enemy_type = "Skeleton"
			elif random == 3:
				enemy_type = "Skeleton Archer"
			
				
	elif type == "Elite Enemy":
		enemy_type = "Skeleton Mage"
		
		
func select_type():
	LevelManager.show_map = false
	if type == "Enemy":
		EnemyManager.enemy_type = enemy_type
		get_tree().change_scene_to_file("res://scenes/dungeons/enemy_selection.tscn")
	
	elif type == "Elite Enemy":
		EnemyManager.enemy_type = enemy_type
		get_tree().change_scene_to_file("res://scenes/dungeons/enemy_selection.tscn")
	
	elif type == "Rest":
		get_tree().change_scene_to_file("res://scenes/dungeons/rest.tscn")
		
	elif type == "Random Event":
		get_tree().change_scene_to_file("res://scenes/dungeons/random_event.tscn")
		
func check_level_done():
	if level_done == true:
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
	if level == 10:
		LevelManager.available_level = 1
	else:
		LevelManager.available_level = level + 1
	
		
		
		
func _on_pressed():
	level_done = true
	check_level_done()
	update_available_level()
	select_type()
