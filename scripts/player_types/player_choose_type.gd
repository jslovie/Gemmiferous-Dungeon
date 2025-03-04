extends TextureButton


@export var type: PlayerType

func assign_stats():
	PlayerManager.player.type = type.type
	PlayerManager.player.health = type.health
	PlayerManager.player.max_health = type.max_health
	PlayerManager.player.shield = type.shield
	PlayerManager.player.type_action1 = type.type_action1
	PlayerManager.player.type_action2 = type.type_action2
	PlayerManager.player.type_action3 = type.type_action3
	
func _on_pressed():
	assign_stats()
	SaveManager.autosave()
	Transition.transition()
	await get_tree().create_timer(0.5).timeout
	LevelManager.show_map = true
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
