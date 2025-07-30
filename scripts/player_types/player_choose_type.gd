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
	Sfx.play_SFX(Sfx.button_confirm)
	assign_stats()
	SaveManager.autosave()
	Transition.transition()
	if is_tutorial:
		LevelManager.in_tutorial_level = true
		DungeonMap.show_tutorial()
		DungeonMapMobile.show_tutorial()
	else:
		DungeonMap.choose_random_f()
		DungeonMapMobile.choose_random_f()
	await get_tree().create_timer(0.5).timeout
	RelicManager.reset_pieces_relics()
	LevelManager.switch_to_dungeon_map_timeless()


func _on_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
