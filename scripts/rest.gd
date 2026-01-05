extends Node2D

@onready var run_time = $RunTime/RunTimeLabel

func _ready():
	change_background()
	Music.play_music_rest()
	SaveManager.load_savefile()
	SaveManager.load_autosave()
	LevelManager.level_done += 1
	update_loot_materials()
	update_loot_treasures()
	PlayerManager.player.update_player_texture()
	
func _process(_delta):
	update_healthbars()
	check_in_tutorial()
	check_run_time()
	
func check_run_time():
	run_time.text = "Run Time:" + "\n" + str(RunStats.run_timer)
	
func update_healthbars():
	#Player healthbar
	%PlayerHealth.value = PlayerManager.player.health
	%PlayerHealth.max_value = PlayerManager.player.max_health
	%PlayerHealthLabel.text = str(PlayerManager.player.health)

func update_loot_treasures():
	$Gems/HBoxContainer/RedGem.text = ": " + str(PlayerManager.player.red_gem)
	$Gems/HBoxContainer/BlueGem.text = ": " + str(PlayerManager.player.blue_gem)
	$Gems/HBoxContainer/GreenGem.text = ": " + str(PlayerManager.player.green_gem)
	$Gems/HBoxContainer/YellowGem.text = ": " + str(PlayerManager.player.yellow_gem)
	$Material/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.coins)
	
func update_loot_materials():
	$Material/HBoxContainer/Wood.text = ": " + str(PlayerManager.player.wood)
	$Material/HBoxContainer/Stone.text = ": " + str(PlayerManager.player.stone)
	$Material/HBoxContainer/Iron.text = ": " + str(PlayerManager.player.iron)

func update_treasures():
	$Gems/HBoxContainer/RedGem.text = ": " + str(PlayerManager.player.total_red_gem)
	$Gems/HBoxContainer/BlueGem.text = ": " + str(PlayerManager.player.total_blue_gem)
	$Gems/HBoxContainer/GreenGem.text = ": " + str(PlayerManager.player.total_green_gem)
	$Gems/HBoxContainer/YellowGem.text = ": " + str(PlayerManager.player.total_yellow_gem)
	$Material/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.total_coins)
	
func update_materials():
	$Material/HBoxContainer/Wood.text = ": " + str(PlayerManager.player.total_wood)
	$Material/HBoxContainer/Stone.text = ": " + str(PlayerManager.player.total_stone)
	$Material/HBoxContainer/Iron.text = ": " + str(PlayerManager.player.total_iron)

func check_in_tutorial():
	if LevelManager.in_tutorial_level:
		$Control/Panel/VBoxContainer/Button2.visible = false
		$Control/Panel/VBoxContainer/Button3.visible = false
		$TutorialText.visible = true
		
func change_background():
	var floors = {
		1: $Background/F1,
		2: $Background/F2,
		3: $Background/F3,
		4: $Background/F4
	}
	for floor in floors.values():
		floor.visible = false
	
	if LevelManager.floor in floors:
		var active = floors[LevelManager.floor]
		active.visible = true
		
		for room in active.get_children():
			room.visible = false
		var random_number = randi_range(0,active.get_child_count() -1)
		active.get_child(random_number).visible = true
	
func handle_heal():
	PlayerManager.player.heal(15)
	SaveManager.autosave()
	LevelManager.switch_to_dungeon_map_timeless()

func handle_loot_to_manor():
	update_materials()
	update_treasures()
	await get_tree().create_timer(1).timeout
	halve_loot()
	PlayerManager.player.set_treasure()
	#PlayerManager.player.reset_current_treasure()
	$Material/HBoxContainer/Wood.add_theme_color_override("font_color",Color.GREEN)
	$Material/HBoxContainer/Stone.add_theme_color_override("font_color",Color.GREEN)
	$Material/HBoxContainer/Iron.add_theme_color_override("font_color",Color.GREEN)
	$Gems/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.GREEN)
	$Gems/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.GREEN)
	$Gems/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.GREEN)
	$Gems/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.GREEN)
	$Material/HBoxContainer/Coin.add_theme_color_override("font_color",Color.GREEN)
	update_treasures()
	update_materials()
	SaveManager.savefilesave()
	SaveManager.autosave()
	await get_tree().create_timer(0.5).timeout
	$Material/HBoxContainer/Wood.add_theme_color_override("font_color",Color.WHITE)
	$Material/HBoxContainer/Stone.add_theme_color_override("font_color",Color.WHITE)
	$Material/HBoxContainer/Iron.add_theme_color_override("font_color",Color.WHITE)
	$Gems/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.WHITE)
	$Gems/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.WHITE)
	$Gems/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.WHITE)
	$Gems/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.WHITE)
	$Material/HBoxContainer/Coin.add_theme_color_override("font_color",Color.WHITE)
	await get_tree().create_timer(1).timeout
	LevelManager.switch_to_dungeon_map_timeless()

func halve_loot():
	PlayerManager.player.red_gem = round(PlayerManager.player.red_gem / 2)
	PlayerManager.player.blue_gem = round(PlayerManager.player.blue_gem / 2)
	PlayerManager.player.green_gem = round(PlayerManager.player.green_gem / 2)
	PlayerManager.player.yellow_gem = round(PlayerManager.player.yellow_gem / 2)
	PlayerManager.player.coins = round(PlayerManager.player.coins / 2)
	PlayerManager.player.wood = round(PlayerManager.player.wood / 2)
	PlayerManager.player.stone = round(PlayerManager.player.stone / 2)
	PlayerManager.player.iron = round(PlayerManager.player.iron / 2)

func handle_end():
	PlayerManager.player.set_treasure()
	move_tween($Player_win,Vector2(981,533),0.8)
	$Control.visible = false
	
func _on_button_pressed():
	handle_heal()
	$Control/Panel/VBoxContainer.visible = false
	Sfx.play_SFX(Sfx.button_confirm)
func _on_button_2_pressed():
	handle_loot_to_manor()
	$Control/Panel/VBoxContainer.visible = false
	Sfx.play_SFX(Sfx.button_confirm)
func _on_button_3_pressed():
	handle_end()
	$Control/Panel/VBoxContainer.visible = false
	Sfx.play_SFX(Sfx.button_confirm)

func _on_button_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	$Control/Panel/VBoxContainer/Button/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_button_2_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	$Control/Panel/VBoxContainer/Button2/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_button_3_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	$Control/Panel/VBoxContainer/Button3/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_button_mouse_exited():
	$Control/Panel/VBoxContainer/Button/Label.add_theme_color_override("font_color", Color.WHITE)
func _on_button_2_mouse_exited():
	$Control/Panel/VBoxContainer/Button2/Label.add_theme_color_override("font_color", Color.WHITE)
func _on_button_3_mouse_exited():
	$Control/Panel/VBoxContainer/Button3/Label.add_theme_color_override("font_color", Color.WHITE)

func move_tween(object,pos,time):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property(object,"position",pos,time)
