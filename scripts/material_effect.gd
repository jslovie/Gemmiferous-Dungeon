extends Sprite2D

@export var type: String

var reward = 1

func _ready():
	if LevelManager.is_mobile:
		tween_material_mobile()
	else:
		tween_material()
	update_texture()
	
	
func _physics_process(delta):
	rotation_set(delta)
	reward_up()

func reward_up():
	if LevelManager.floor == 1:
		reward = 1
	elif LevelManager.floor == 2:
		reward = 2
	elif LevelManager.floor == 3:
		reward = 3
	elif LevelManager.floor == 4:
		reward = 4
		
func rotation_set(delta):
	if type == "Shield" or "Red Gem" or "Blue Gem" or "Green Gem" or "Yellow Gem" or "Coin" or "Red Gem T" or "Blue Gem T" or "Green Gem T" or "Yellow Gem T" or "Coin T":
		rotation += -8 * delta
	else:
		rotation += 8 * delta

func update_texture():
	if type == "Shield":
		if SaveManager.autosave_data.player_data.type == "Rogue":
			texture = load("res://assets/32rogues/pieces/shieldv2.png")
		elif SaveManager.autosave_data.player_data.type == "Barbarian":
			texture = load("res://assets/32rogues/pieces/barbarian_shield.png")
		

func create_tween_to_move(pos: Vector2, time):
	var move_tween = create_tween()
	move_tween.tween_property(self, "position", pos, time)

func tween_material():
	if type == "Wood":
		create_tween_to_move(Vector2(807,3),0.8)
	elif type == "Stone":
		create_tween_to_move(Vector2(968,3),0.8)
	elif type == "Iron":
		create_tween_to_move(Vector2(1130,3),0.8)
	elif type == "Shield":
		create_tween_to_move(Vector2(-92,1002),0.5)
	elif type == "Red Gem":
		create_tween_to_move(Vector2(-630,4),0.8)
	elif type == "Blue Gem":
		create_tween_to_move(Vector2(-467,4),0.8)
	elif type == "Green Gem":
		create_tween_to_move(Vector2(-306,4),0.8)
	elif type == "Yellow Gem":
		create_tween_to_move(Vector2(-143,3),0.8)
	elif type == "Coin":
		create_tween_to_move(Vector2(647,4),1)
	elif type == "Red Gem T":
		create_tween_to_move(Vector2(-630,4),0.8)
	elif type == "Blue Gem T":
		create_tween_to_move(Vector2(-467,4),0.8)
	elif type == "Green Gem T":
		create_tween_to_move(Vector2(-306,4),0.8)
	elif type == "Yellow Gem T":
		create_tween_to_move(Vector2(-143,4),0.8)
	elif type == "Coin T":
		create_tween_to_move(Vector2(647,4),0.8)

func tween_material_mobile():
	if type == "Wood":
		create_tween_to_move(Vector2(17,-218),0.8)
	elif type == "Stone":
		create_tween_to_move(Vector2(285,-235),0.8)
	elif type == "Iron":
		create_tween_to_move(Vector2(553,-220),0.8)
	elif type == "Shield":
		create_tween_to_move(Vector2(469,1158),0.2)
	elif type == "Red Gem":
		create_tween_to_move(Vector2(-266,221),0.8)
	elif type == "Blue Gem":
		create_tween_to_move(Vector2(-251,675),0.8)
	elif type == "Green Gem":
		create_tween_to_move(Vector2(830,231),0.8)
	elif type == "Yellow Gem":
		create_tween_to_move(Vector2(833,695),0.8)
	elif type == "Coin":
		create_tween_to_move(Vector2(89,1160),0.8)
	elif type == "Red Gem T":
		create_tween_to_move(Vector2(-266,221),0.8)
	elif type == "Blue Gem T":
		create_tween_to_move(Vector2(-251,675),0.8)
	elif type == "Green Gem T":
		create_tween_to_move(Vector2(830,231),0.8)
	elif type == "Yellow Gem T":
		create_tween_to_move(Vector2(833,695),0.8)
	elif type == "Coin T":
		create_tween_to_move(Vector2(89,1160),0.8)


func _on_area_2d_area_entered(area):
	if area.is_in_group("Effect"):
		if type == "Wood":
			PlayerManager.player.wood += 1
		elif type == "Stone":
			PlayerManager.player.stone += 1
		elif type == "Iron":
			PlayerManager.player.iron += 1
		elif type == "Red Gem":
			PlayerManager.player.red_gem += reward
			LevelManager.spinning = false
		elif type == "Blue Gem":
			PlayerManager.player.blue_gem += reward
			LevelManager.spinning = false
		elif type == "Green Gem":
			PlayerManager.player.green_gem += reward
			LevelManager.spinning = false
		elif type == "Yellow Gem":
			PlayerManager.player.yellow_gem += reward
			LevelManager.spinning = false
		elif type == "Red Gem T":
			PlayerManager.player.red_gem += reward
			LevelManager.spinning = false
		elif type == "Blue Gem T":
			PlayerManager.player.blue_gem += reward
			LevelManager.spinning = false
		elif type == "Green Gem T":
			PlayerManager.player.green_gem += reward
			LevelManager.spinning = false
		elif type == "Yellow Gem T":
			PlayerManager.player.yellow_gem += reward
			LevelManager.spinning = false
		elif type == "Coin T":
			PlayerManager.player.coins += 1
		
			
			
			
			
		queue_free()
