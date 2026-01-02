extends TextureRect

@onready var row = $Row

const MOVE: int = 8
const TURN: int = -120

var spinning: bool = false
var result = null

var rng = RandomNumberGenerator.new()
var random_value: int = 0


func _handle_pulled():
	rng.randomize()
	random_value = 4 * rng.randi_range(30,60)
	
	for i in random_value:
		if round(row.position.y) >= 0:
			row.position.y = TURN
		else:
			var tween = create_tween()
			tween.tween_property(row,"position",Vector2(row.position.x,row.position.y + MOVE),0.01)
			await tween.finished
	
	row.position.y = int(row.position.y )
	
	if row.position.y == -96:
		result = "yellow"
	elif row.position.y == -64:
		result = "green"
	elif row.position.y == -32:
		result = "red"
	elif row.position.y == 0:
		result = "blue"
	$"..".load_result()
	spinning = false
