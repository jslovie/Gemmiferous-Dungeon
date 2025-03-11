extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var texture_rect = $TextureRect

var SizeTween : Tween

func _ready():
	setup(sprite_2d.texture, texture_rect.texture, texture_rect.modulate)

func setup(new_sprite, new_rect, rect_modulate):
	sprite_2d.texture = new_sprite
	texture_rect.texture = new_rect
	texture_rect.modulate = rect_modulate
	slowly_larger_and_dimmer()

func slowly_larger_and_dimmer():
	SizeTween = create_tween()
	SizeTween.set_loops()
	SizeTween.parallel().tween_property(texture_rect, "scale", Vector2(1.5,1.5), 2.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	SizeTween.parallel().tween_property(texture_rect, "modulate", Color(1,1,1,0.2), 2.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	SizeTween.tween_property(texture_rect, "scale", Vector2(1.0,1.0), 0.01)
	SizeTween.tween_property(texture_rect, "modulate", Color(1,1,1,1), 0.01)
	SizeTween.play()
