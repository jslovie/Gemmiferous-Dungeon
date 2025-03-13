extends Node2D


func _ready():
	Music.play_music_selection()
	SaveManager.load_savefile()

func _process(delta):
	update_treasures()
	update_materials()
	total_gems_check()
	total_material_check()

func update_treasures():
	$Gems/HBoxContainer/RedGem.text = ": " + str(PlayerManager.player.total_red_gem)
	$Gems/HBoxContainer/BlueGem.text = ": " + str(PlayerManager.player.total_blue_gem)
	$Gems/HBoxContainer/GreenGem.text = ": " + str(PlayerManager.player.total_green_gem)
	$Gems/HBoxContainer/YellowGem.text = ": " + str(PlayerManager.player.total_yellow_gem)
	$Gems/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.total_coins)
	
func update_materials():
	$Material/HBoxContainer/Wood.text = ": " + str(PlayerManager.player.total_wood)
	$Material/HBoxContainer/Stone.text = ": " + str(PlayerManager.player.total_stone)
	$Material/HBoxContainer/Iron.text = ": " + str(PlayerManager.player.total_iron)

func total_material_check():
	if PlayerManager.player.total_wood >= 999:
		$Material/HBoxContainer/Wood.add_theme_color_override("font_color",Color.RED)
	else:
		$Material/HBoxContainer/Wood.add_theme_color_override("font_color",Color.WHITE)
	if PlayerManager.player.total_stone >= 999:
		$Material/HBoxContainer/Stone.add_theme_color_override("font_color",Color.RED)
	else:
		$Material/HBoxContainer/Stone.add_theme_color_override("font_color",Color.WHITE)
	if PlayerManager.player.total_iron >= 999:
		$Material/HBoxContainer/Iron.add_theme_color_override("font_color",Color.RED)
	else:
		$Material/HBoxContainer/Iron.add_theme_color_override("font_color",Color.WHITE)

func total_gems_check():
	if PlayerManager.player.total_red_gem >= 999:
		$Gems/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.RED)
	else:
		$Gems/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.WHITE)
	if PlayerManager.player.total_blue_gem >= 999:
		$Gems/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.RED)
	else:
		$Gems/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.WHITE)
	if PlayerManager.player.total_green_gem >= 999:
		$Gems/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.RED)
	else:
		$Gems/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.WHITE)
	if PlayerManager.player.total_yellow_gem >= 999:
		$Gems/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.RED)
	else:
		$Gems/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.WHITE)
	if PlayerManager.player.total_coins >= 999:
		$Gems/HBoxContainer/Coin.add_theme_color_override("font_color",Color.RED)
	else:
		$Gems/HBoxContainer/Coin.add_theme_color_override("font_color",Color.WHITE)

func _on_back_button_pressed():
	$Background/DoorClosed.visible = true
	Transition.transition()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/village.tscn")

func _on_back_button_mouse_entered():
	$Back/BackButton/Label.add_theme_color_override("font_color", Color.ORANGE_RED)

func _on_back_button_mouse_exited():
	$Back/BackButton/Label.add_theme_color_override("font_color", Color.WHITE)
