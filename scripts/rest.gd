extends Node2D


func _ready():
	Music.play_music_rest()
	SaveManager.load_savefile()
	SaveManager.load_autosave()
	LevelManager.level_done += 1
	update_loot_materials()
	update_loot_treasures()
	PlayerManager.player.update_player_texture()
	
func _process(_delta):
	change_background()
	update_healthbars()
	
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


func change_background():
	if LevelManager.floor == 1:
		$Background/F1.visible = true
	elif LevelManager.floor == 2:
		$Background/F2.visible = true
	elif LevelManager.floor == 3:
		$Background/F3.visible = true
	elif LevelManager.floor == 4:
		$Background/F4.visible = true
	
func handle_heal():
	PlayerManager.player.heal(15)
	SaveManager.autosave()
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	LevelManager.show_map = true

func handle_loot_to_manor():
	update_materials()
	update_treasures()
	await get_tree().create_timer(1).timeout
	PlayerManager.player.set_treasure()
	PlayerManager.player.reset_current_treasure()
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
	
func handle_end():
	$Player_win.visible = true
	
func _on_button_pressed():
	handle_heal()

func _on_button_2_pressed():
	handle_loot_to_manor()

func _on_button_3_pressed():
	handle_end()
