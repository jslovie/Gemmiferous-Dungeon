extends Node2D


@export var color: String
@export var naming: String
@export var background_color: Vector3
@onready var texture_rect = $TextureRect

var particle_effect = preload("res://scenes/pieces/particle.tscn")

var matched = false

func _ready():
	texture_rect.texture = load("res://assets/32rogues/pieces/bordernew2.png")
	texture_rect.connect("gui_input", on_piece_clicked)

func _process(_delta):
	outline()

func move(target):
	var tween = create_tween()
	tween.tween_property(self, "position", target,0.6).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)

func dim():
	var sprite = $Sprite2D
	sprite.modulate.a = 0.5

func play_sound():
	$AudioStreamPlayer.play()

func make_effect(effect, color):
	var current = effect.instantiate()
	current.position = $ParticleOrigin.position
	add_child(current)
	current.color = Color(color.x, color.y, color.z)

func outline():
	if LevelManager.in_game == true:
		#if Input.is_action_pressed("ui_touch"):
			#$Outline.visible = true
		if Input.is_action_just_released("ui_touch"):
			$Outline.visible = false

func on_piece_clicked(event):
	if event is InputEventMouseButton:
		if RelicManager.in_tile_remove == true:
			if event.pressed:
				Sfx.play_SFX(Sfx.confirm_book)
				if PlayerManager.player.type == "Rogue":
					if len(RelicManager.rogue_pieces) > 5:
						for i in RelicManager.remove_dict:
							if str(i) == naming:
								var index = RelicManager.remove_dict[i]

								$TextureRect.visible = false
								$Sprite2D.visible = false
								make_effect(particle_effect, background_color)
								await get_tree().create_timer(1).timeout
								RelicManager.rogue_pieces.remove_at(index)
								SignalBus.remove_tile.emit()
								queue_free()
					else:
						SignalBus.minimum_tiles.emit()
				elif PlayerManager.player.type == "Barbarian":
					if len(RelicManager.barbarian_pieces) > 5:
						for i in RelicManager.remove_dict:
							if str(i) == naming:
								var index = RelicManager.remove_dict[i]
								RelicManager.barbarian_pieces.remove_at(index)
								SignalBus.remove_tile.emit()
								$TextureRect.visible = false
								$Sprite2D.visible = false
								make_effect(particle_effect, background_color)
								get_tree().create_timer(1).timeout
								queue_free()
					else:
						SignalBus.minimum_tiles.emit()
		elif LevelManager.in_game == true:
			if event.pressed:
				$Outline.visible = true

func _on_texture_rect_mouse_entered():
	if RelicManager.in_tile_remove:
		Sfx.play_SFX(Sfx.in_game_hover)
