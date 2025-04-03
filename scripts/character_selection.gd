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
	$Material/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.total_coins)
	
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
		$Material/HBoxContainer/Coin.add_theme_color_override("font_color",Color.RED)
	else:
		$Material/HBoxContainer/Coin.add_theme_color_override("font_color",Color.WHITE)


func _on_rogue_type_mouse_entered():
	$DescriptionRogue.visible = true

func _on_rogue_type_mouse_exited():
	$DescriptionRogue.visible = false

func _on_barbarian_type_mouse_entered():
	$DescriptionBarbarian.visible = true

func _on_barbarian_type_mouse_exited():
	$DescriptionBarbarian.visible = false


func _on_home_pressed():
	$Pause.visible = true

func _on_back_pressed():
	$Pause.visible = false

func _on_menu_pressed():
	LevelManager.back_to_village()

func _on_menu_mouse_entered():
	$Pause/Progress.visible = true
	
func _on_menu_mouse_exited():
	$Pause/Progress.visible = false
