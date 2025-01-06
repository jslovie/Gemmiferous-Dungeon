extends Button

@export var type : String
@export var level : int
@export var enemy_type : String

var level_done = false


func _ready():
	select_icon()
	select_enemy()


func _process(delta):
	pass

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
	if level == 1:
		var random = randi_range(1, 2)
		if random == 1:
			enemy_type = "Skeleton"
		elif random == 2:
			enemy_type = "Spider"

func select_type():
	PlayerManager.show_map = false
	if type == "Enemy":
		EnemyManager.enemy_type = enemy_type
		get_tree().change_scene_to_file("res://scenes/dungeons/enemy_selection.tscn")
		
		
func check_level_done():
	if level_done == true:
		$LevelDone.visible = true
		disabled = true
	else:
		$LevelDone.visible = false
		disabled = false
		
func _on_pressed():
	level_done = true
	check_level_done()
	select_type()
