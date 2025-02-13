extends TextureRect

@onready var row = $Row

const MOVE = 8
const TURN = -120

var spinning = false
var result = null

var time_interval = 0.005
var rng = RandomNumberGenerator.new()
var random_value = 0

func _ready():
	rng.randomize()
	
	
func _handle_pulled():
	random_value = 60 * rng.randi_range(2,8)
	for i in random_value:
		if round(row.position.y) >= 0:
			row.position.y = TURN
		else:
			row.position.y += MOVE
		
		await get_tree().create_timer(time_interval).timeout
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
