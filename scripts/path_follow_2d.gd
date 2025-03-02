extends PathFollow2D

@export var type : String

var speed = 0.02

func _process(delta):
	progress_ratio += delta * speed
