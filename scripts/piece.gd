extends Node2D

@export var color: String
@export var naming: String
@export var background_color: Vector3
@onready var texture_rect = $TextureRect

var matched = false

func _ready():
	texture_rect.connect("gui_input", on_piece_clicked)

func move(target):
	var tween = create_tween()
	tween.tween_property(self, "position", target,0.6).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)

func dim():
	var sprite = $Sprite2D
	sprite.modulate.a = 0.5

func play_sound():
	$AudioStreamPlayer.play()

func on_piece_clicked(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if RelicManager.in_tile_remove == true:
				if PlayerManager.player.type == "Rogue":
					if len(RelicManager.rogue_pieces) > 5:
						print("remove tile")
					else:
						print("minimum 5 tiles")
				elif PlayerManager.player.type == "Barbarian":
					if len(RelicManager.barbarian_pieces) > 5:
						print("remove tile")
					else:
						print("minimum 5 tiles")
