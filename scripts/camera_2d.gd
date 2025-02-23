extends Camera2D

#
#
#func camera_effect(amount):
	#
	#var screen_kick_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	#screen_kick_tween.tween_property(self,"zoom", Vector2(amount,amount), 0.1)
	#screen_kick_tween.tween_property(self,"zoom", Vector2(1,1), 0.1)
#
#

@export var max_shake: float = 10.0
@export var shake_fade: float = 10.0

var _shake_strength: float = 0.0

func trigger_shake(amount):
	max_shake = amount
	_shake_strength = max_shake
	
func _process(delta):
	if _shake_strength > 0:
		_shake_strength = lerp(_shake_strength, 0.0, shake_fade * delta)
		offset = Vector2(randf_range(-_shake_strength, _shake_strength), randf_range(-_shake_strength, _shake_strength))
		
func _on_grid_camera_effect(amount):
	trigger_shake(amount)
