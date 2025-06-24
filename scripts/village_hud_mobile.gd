extends CanvasLayer


func _ready():
	visible = false

func _process(delta):
	check_visibility()

func check_visibility():
	if LevelManager.in_village and LevelManager.is_mobile:
		visible = true
	else:
		visible = false
	
	if VillageManager.in_shop:
		$Control/Home.visible = false
	else:
		$Control/Home.visible = true
	
	
func update_village_hud_mobile():
	total_gems_check()
	total_material_check()
	update_materials()
	update_treasures()
	
func total_material_check():
	if PlayerManager.player.total_wood >= 999:
		$Control/Material/HBoxContainer/Wood.add_theme_color_override("font_color",Color.RED)
	else:
		$Control/Material/HBoxContainer/Wood.add_theme_color_override("font_color",Color.WHITE)
	if PlayerManager.player.total_stone >= 999:
		$Control/Material/HBoxContainer/Stone.add_theme_color_override("font_color",Color.RED)
	else:
		$Control/Material/HBoxContainer/Stone.add_theme_color_override("font_color",Color.WHITE)
	if PlayerManager.player.total_iron >= 999:
		$Control/Material/HBoxContainer/Iron.add_theme_color_override("font_color",Color.RED)
	else:
		$Control/Material/HBoxContainer/Iron.add_theme_color_override("font_color",Color.WHITE)

func total_gems_check():
	if PlayerManager.player.total_red_gem >= 999:
		$Control/Gems/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.RED)
	else:
		$Control/Gems/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.WHITE)
	if PlayerManager.player.total_blue_gem >= 999:
		$Control/Gems/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.RED)
	else:
		$Control/Gems/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.WHITE)
	if PlayerManager.player.total_green_gem >= 999:
		$Control/Gems/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.RED)
	else:
		$Control/Gems/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.WHITE)
	if PlayerManager.player.total_yellow_gem >= 999:
		$Control/Gems/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.RED)
	else:
		$Control/Gems/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.WHITE)
	if PlayerManager.player.total_coins >= 999:
		$Control/Material/HBoxContainer/Coin.add_theme_color_override("font_color",Color.RED)
	else:
		$Control/Material/HBoxContainer/Coin.add_theme_color_override("font_color",Color.WHITE)
		
func update_treasures():
	$Control/Gems/HBoxContainer/RedGem.text = ": " + str(PlayerManager.player.total_red_gem)
	$Control/Gems/HBoxContainer/BlueGem.text = ": " + str(PlayerManager.player.total_blue_gem)
	$Control/Gems/HBoxContainer/GreenGem.text = ": " + str(PlayerManager.player.total_green_gem)
	$Control/Gems/HBoxContainer/YellowGem.text = ": " + str(PlayerManager.player.total_yellow_gem)
	$Control/Material/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.total_coins)
	
func update_materials():
	$Control/Material/HBoxContainer/Wood.text = ": " + str(PlayerManager.player.total_wood)
	$Control/Material/HBoxContainer/Stone.text = ": " + str(PlayerManager.player.total_stone)
	$Control/Material/HBoxContainer/Iron.text = ": " + str(PlayerManager.player.total_iron)


func _on_home_pressed():
	if LevelManager.in_card_game:
		LevelManager.back_to_village()
	else:
		LevelManager.main_menu()
