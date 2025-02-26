extends Node2D

var timesup = false

func _ready():
	change_background()
	SaveManager.load_autosave()
	PlayerManager.player.update_player_texture()
	%Timer.timer_start()
	LevelManager.treasure_timesup = false
	$Chest/ChestClosed.visible = false
	wait_time()
	get_tree().paused = true
	
func _process(_delta):
	update_healthbars()
	update_shields()
	change_background()
	update_material_bar()
	%Countdown.text = str(%TimesUp.time_left)

func change_background():
	if LevelManager.floor == 1:
		$Background/F1.visible = true
	elif LevelManager.floor == 2:
		$Background/F2.visible = true
	elif LevelManager.floor == 3:
		$Background/F3.visible = true
	elif LevelManager.floor == 4:
		$Background/F4.visible = true

func wait_time():
	$WaitTime.visible = true
	%WaitTimeTimer.start(5)
	get_tree().paused = true

func update_material_bar():
	$Material/HBoxContainer/Wood.text = ": " + str(PlayerManager.player.wood)
	$Material/HBoxContainer/Stone.text = ": " + str(PlayerManager.player.stone)
	$Material/HBoxContainer/Iron.text = ": " + str(PlayerManager.player.iron)
	$Gems/HBoxContainer/RedGem.text = ": " + str(PlayerManager.player.red_gem)
	$Gems/HBoxContainer/BlueGem.text = ": " + str(PlayerManager.player.blue_gem)
	$Gems/HBoxContainer/GreenGem.text = ": " + str(PlayerManager.player.green_gem)
	$Gems/HBoxContainer/YellowGem.text = ": " + str(PlayerManager.player.yellow_gem)
	$Gems/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.coins)
	
func update_healthbars():
	%PlayerHealth.value = PlayerManager.player.health
	%PlayerHealth.max_value = PlayerManager.player.max_health
	%PlayerHealthLabel.text = str(PlayerManager.player.health)

	
func update_shields():
	if PlayerManager.player.shield == 0:
		%PlayerShield.visible = false
		%PlayerShieldLabel.visible = false
	else:
		%PlayerShield.visible = true
		%PlayerShieldLabel.visible = true
		%PlayerShieldLabel.text = str(PlayerManager.player.shield)
	

func resolution_screen():
	if timesup == true:
		%Resolution.visible = true
		%ResolutionText.text = "Time's Up!"



func _on_times_up_grid_timeout():
	timesup = true
	LevelManager.treasure_timesup = true
	resolution_screen()
	$Chest/ChestClosed.visible = true
	LevelManager.level_done += 1
	SaveManager.autosave()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	LevelManager.show_map = true


func _on_wait_time_timer_timeout():
	get_tree().paused = false
	$WaitTime.visible = false


func _on_red_gem_area_2d_area_entered(_area):
	PlayerManager.player.red_gem_up(1)
	$Gems/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Gems/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.WHITE)
func _on_blue_gem_area_2d_area_entered(_area):
	PlayerManager.player.blue_gem_up(1)
	$Gems/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Gems/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.WHITE)
func _on_greem_gem_area_2d_area_entered(_area):
	PlayerManager.player.green_gem_up(1)
	$Gems/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Gems/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.WHITE)
func _on_yellow_gem_area_2d_area_entered(_area):
	PlayerManager.player.yellow_gem_up(1)
	$Gems/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Gems/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.WHITE)
func _on_coin_area_2d_area_entered(_area):
	PlayerManager.player.coins_up()
	$Gems/HBoxContainer/Coin.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Gems/HBoxContainer/Coin.add_theme_color_override("font_color",Color.WHITE)
