extends Camera2D

@export var zoom_speed : float
@export var pan_speed : float
@export var rotation_speed : float

@export var can_pan : bool
@export var can_zoom : bool
@export var can_rotate : bool

var touch_points: Dictionary = {}
var start_distance
var start_zoom

func _input(event):
	if event is InputEventScreenTouch:
		if LevelManager.is_mobile:
			handle_touch(event)
	if event is InputEventScreenDrag:
		if LevelManager.is_mobile:
			handle_drag(event)
		pass
		
func handle_touch(event: InputEventScreenTouch):
	if event.pressed:
		touch_points[event.index] = event.position
	else:
		touch_points.erase(event.index)
		
	if touch_points.size() == 2:
		var touch_point_positions = touch_points.values()
		start_distance = touch_point_positions[0].distance_to(touch_point_positions[1])
		
		start_zoom = zoom
	elif touch_points.size() < 2:
		start_distance = 0
	
func handle_drag(event: InputEventScreenDrag):
	touch_points[event.index] = event.position
	
	if touch_points.size() == 1:
		if can_pan:
			global_position -= event.relative.rotated(rotation) * pan_speed
	elif  touch_points.size() == 2:
		var touch_points_position = touch_points.values()
		var current_dist = touch_points_position[0].distance_to(touch_points_position[1])
		
		var zoom_factor = start_distance / current_dist
		if can_zoom:
			zoom = start_zoom / zoom_factor
		limit_zoom(zoom)
		
func limit_zoom(new_zoom):
	if new_zoom.x < 6:
		zoom.x = 6
	if new_zoom.y < 6:
		zoom.y = 6
	if new_zoom.x > 15:
		zoom.x = 15
	if new_zoom.y > 15:
		zoom.y = 15
