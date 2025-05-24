extends Camera2D

@export var zoom_speed : float
@export var pan_speed : float
@export var rotation_speed : float

@export var can_pan : bool
@export var can_zoom : bool
@export var can_rotate : bool

var touch_points: Dictionary = {}

func _input(event):
	if event is InputEventScreenTouch:
		handle_touch(event)
	if event is InputEventScreenDrag:
		handle_drag(event)
		pass
		
func handle_touch(event: InputEventScreenTouch):
	if event.pressed:
		touch_points[event.index] = event.position
	else:
		touch_points.erase(event.index)
		
func handle_drag(event: InputEventScreenDrag):
	touch_points[event.index] = event.position
	
	if touch_points.size() == 1:
		if can_pan:
			global_position -= event.relative.rotated(rotation) * pan_speed
