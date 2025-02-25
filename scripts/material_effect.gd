extends Sprite2D

@export var type: String


func _ready():
	tween_material()
	update_texture()
	
	
func _physics_process(delta):
	if type == "Shield" or "Red Gem" or "Blue Gem" or "Green Gem" or "Yellow Gem" or "Coin":
		rotation += -8 * delta
	else:
		rotation += 8 * delta

func update_texture():
	if type == "Shield":
		if SaveManager.autosave_data.player_data.type == "Rogue":
			texture = load("res://assets/32rogues/pieces/shieldv2.png")
		elif SaveManager.autosave_data.player_data.type == "Barbarian":
			texture = load("res://assets/32rogues/pieces/barbarian_shield.png")
		

func tween_material():
	if type == "Wood":
		var move_tween = create_tween()
		move_tween.tween_property(self, "position", Vector2(807,3), 0.8)
	elif type == "Stone":
		var move_tween = create_tween()
		move_tween.tween_property(self, "position", Vector2(968,3), 0.8)
	elif type == "Iron":
		var move_tween = create_tween()
		move_tween.tween_property(self, "position", Vector2(1130,3), 0.8)
	elif type == "Shield":
		var move_tween = create_tween()
		move_tween.tween_property(self, "position", Vector2(-92,1002), 0.5)
	elif type == "Red Gem":
		var move_tween = create_tween()
		move_tween.tween_property(self, "position", Vector2(-630,4), 0.8)
	elif type == "Blue Gem":
		var move_tween = create_tween()
		move_tween.tween_property(self, "position", Vector2(-467,4), 0.8)
	elif type == "Green Gem":
		var move_tween = create_tween()
		move_tween.tween_property(self, "position", Vector2(-306,4), 0.8)
	elif type == "Yellow Gem":
		var move_tween = create_tween()
		move_tween.tween_property(self, "position", Vector2(-143,4), 0.8)
	elif type == "Coin":
		var move_tween = create_tween()
		move_tween.tween_property(self, "position", Vector2(19,4), 1)

	
func _on_area_2d_area_entered(area):
	if area.is_in_group("Effect"):
		if type == "Wood":
			PlayerManager.player.wood += 1
		elif type == "Stone":
			PlayerManager.player.stone += 1
		elif type == "Iron":
			PlayerManager.player.iron += 1
		elif type == "Red Gem":
			PlayerManager.player.red_gem += 1
		elif type == "Blue Gem":
			PlayerManager.player.blue_gem += 1	
		elif type == "Green Gem":
			PlayerManager.player.green_gem += 1	
		elif type == "Yellow Gem":
			PlayerManager.player.yellow_gem += 1	
			
			
			
			
			
			
		queue_free()
