extends TextureButton


@export var type: PlayerType
@export var is_tutorial: bool

func assign_stats():
	PlayerManager.player.type = type.type
	PlayerManager.player.health = type.health
	PlayerManager.player.max_health = type.max_health
	PlayerManager.player.shield = type.shield
	PlayerManager.player.type_action1 = type.type_action1
	PlayerManager.player.type_action2 = type.type_action2
	PlayerManager.player.type_action3 = type.type_action3
	SaveManager.save_resource(type.starting_relic, type.starting_relic.resource_naming)
	RelicManager.current_relics.append(type.starting_relic)
	
	
func _on_pressed():
	assign_stats()
	SaveManager.autosave()
	Transition.transition()
	if is_tutorial:
		LevelManager.in_tutorial_level = true
		DungeonMap.show_tutorial()
	await get_tree().create_timer(0.5).timeout
	LevelManager.show_map = true
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
