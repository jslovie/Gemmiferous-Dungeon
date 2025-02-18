extends Node2D

@export var color: String

var matched = false

func move(target):
	var tween = create_tween()
	tween.tween_property(self, "position", target,0.6).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)

func dim():
	var sprite = $Sprite2D
	sprite.modulate.a = 0.5
