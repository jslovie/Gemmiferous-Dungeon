extends Node2D


var tutorial_position = Vector2(-16,-7)
var rogue_position = Vector2(-602,-7)
var barbarian_position = Vector2(-1193,-7)
var holy_position = Vector2(-1759,-7)
var spellblade_position = Vector2(-2338,-7)
var knight_position = Vector2(-2875,-7)


func _ready():
	Music.play_music_selection()
	SaveManager.load_savefile()
	$NotAvailable.add_theme_color_override("font_color",Color.DARK_ORANGE)
	
func _process(_delta):
	update_treasures()
	update_materials()
	total_gems_check()
	total_material_check()
	check_unlocked()
	check_pause()
	description_check_mobile()
	unlock_check_mobile()
	if LevelManager.is_mobile:
		$Selection/TutotialBanner.visible = true
		$Selection/TutorialLabel.visible = true
	
func check_pause():
	if LevelManager.is_mobile:
		if LevelManager.in_pause:
			$RightArrow.visible = false
			$LeftArrow.visible = false
			$Play.visible = false
		else:
			$RightArrow.visible = true
			$LeftArrow.visible = true
			$Play.visible = true
	
func check_unlocked():
	if PlayerManager.player.rogue_unlocked == false:
		$Selection/RogueType.disabled = true
		$Selection/LockRogue.visible = true
		$Selection/RogueType.modulate = Color(0.369, 0.369, 0.369)
	if PlayerManager.player.barbarian_unlocked == false:
		$Selection/BarbarianType.disabled = true
		$Selection/LockBarbarian.visible = true
		$Selection/BarbarianType.modulate = Color(0.369, 0.369, 0.369)
	

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
	if PlayerManager.player.rogue_unlocked == false:
		$Unlock.text = "Complete tutorial level to unlock!"
		$Unlock.visible = true

func _on_rogue_type_mouse_exited():
	$DescriptionRogue.visible = false
	$Unlock.visible = false

func _on_barbarian_type_mouse_entered():
	$DescriptionBarbarian.visible = true
	if PlayerManager.player.barbarian_unlocked == false:
		$Unlock.text = "Beat first boss to unlock!"
		$Unlock.visible = true
		
func _on_barbarian_type_mouse_exited():
	$DescriptionBarbarian.visible = false
	$Unlock.visible = false

func _on_home_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	$Pause.visible = true
	LevelManager.in_pause = true

func _on_back_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	$Pause.visible = false
	LevelManager.in_pause = false

func _on_menu_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	LevelManager.in_pause = false
	LevelManager.back_to_village()

func _on_menu_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	$Pause/Progress.visible = true
	
func _on_menu_mouse_exited():
	$Pause/Progress.visible = false


func _on_holy_type_mouse_entered():
	if LevelManager.is_demo:
		$NotAvailable.visible = true
func _on_holy_type_mouse_exited():
	if LevelManager.is_demo:
		$NotAvailable.visible = false
func _on_spellblade_type_mouse_entered():
	if LevelManager.is_demo:
		$NotAvailable.visible = true
func _on_spellblade_type_mouse_exited():
	if LevelManager.is_demo:
		$NotAvailable.visible = false
func _on_knight_type_mouse_entered():
	if LevelManager.is_demo:
		$NotAvailable.visible = true
func _on_knight_type_mouse_exited():
	if LevelManager.is_demo:
		$NotAvailable.visible = false


func _on_tutorial_type_mouse_entered():
	$Selection/TutotialBanner.visible = true
	$Selection/TutorialLabel.visible = true
	if LevelManager.tutorial_completed:
		$Unlock.text = "Tutorial completed: Halved rewards for playing"
		$Unlock.visible = true
func _on_tutorial_type_mouse_exited():
	if LevelManager.is_mobile:
		pass
	else:	
		$Selection/TutotialBanner.visible = false
		$Selection/TutorialLabel.visible = false
	$Unlock.visible = false

func description_check_mobile():
	if LevelManager.is_mobile:
		if $Selection.position == tutorial_position or $Selection.position == rogue_position:
			$DescriptionRogue.visible = true
		else:
			$DescriptionRogue.visible = false
		if $Selection.position == barbarian_position:
			$DescriptionBarbarian.visible = true
		else:
			$DescriptionBarbarian.visible = false

func unlock_check_mobile():
	if LevelManager.is_mobile:
		if $Selection.position == rogue_position:
			if PlayerManager.player.rogue_unlocked == false:
				$Unlock.text = "Complete tutorial level to unlock!"
				$Unlock.visible = true
				$Banner3.visible = true
	
		elif $Selection.position == barbarian_position:
			if PlayerManager.player.barbarian_unlocked == false:
				$Unlock.text = "Beat first boss to unlock!"
				$Unlock.visible = true
				$Banner.visible = true
		else:
			$Unlock.visible = false
			$Banner.visible = false
			$Banner3.visible = false
			
		if $Selection.position == holy_position:
			$NotAvailable.visible = true
			$Banner2.visible = true
		elif $Selection.position == spellblade_position:
			$NotAvailable.visible = true
			$Banner2.visible = true
		elif $Selection.position == knight_position:
			$NotAvailable.visible = true
			$Banner2.visible = true
		else:
			$NotAvailable.visible = false
			$Banner2.visible = false

func move_tween(pos,time):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property($Selection,"position",pos,time)

func process_move(pos):
	$LeftArrow.disabled = true
	$RightArrow.disabled = true
	$Play.disabled = true
	await get_tree().create_timer(0.6).timeout
	$Selection.position = pos
	$LeftArrow.disabled = false
	$RightArrow.disabled = false
	$Play.disabled = false

func _on_play_pressed():
	if $Selection.position == tutorial_position:
		$Selection/TutorialType._on_pressed()
	elif $Selection.position == rogue_position:
		if PlayerManager.player.rogue_unlocked == true:
			$Selection/RogueType._on_pressed()
	elif $Selection.position == barbarian_position:
		if PlayerManager.player.barbarian_unlocked == true:
			$Selection/BarbarianType._on_pressed()
	elif $Selection.position == holy_position:
		if PlayerManager.player.holy_unlocked == true:
			$Selection/HolyType._on_pressed()
	elif $Selection.position == spellblade_position:
		if PlayerManager.player.spellblade_unlocked == true:
			$Selection/SpellbladeType._on_pressed()
	elif $Selection.position == knight_position:
		if PlayerManager.player.knight_unlocked == true:
			$Selection/KnightType._on_pressed()


func _on_right_arrow_pressed():
	if $Selection.position == tutorial_position:
		move_tween(rogue_position,0.5)
		process_move(rogue_position)
	elif $Selection.position == rogue_position:
		move_tween(barbarian_position,0.5)
		process_move(barbarian_position)
	elif $Selection.position == barbarian_position:
		move_tween(holy_position,0.5)
		process_move(holy_position)
	elif $Selection.position == holy_position:
		move_tween(spellblade_position,0.5)
		process_move(spellblade_position)
	elif $Selection.position == spellblade_position:
		move_tween(knight_position,0.5)
		process_move(knight_position)
	elif $Selection.position == knight_position:
		move_tween(tutorial_position,0.5)
		process_move(tutorial_position)
	else:
		print($Selection.position)

func _on_left_arrow_pressed():
	if $Selection.position == tutorial_position:
		move_tween(knight_position,0.5)
		process_move(knight_position)
	elif $Selection.position == rogue_position:
		move_tween(tutorial_position,0.5)
		process_move(tutorial_position)
	elif $Selection.position == barbarian_position:
		move_tween(rogue_position,0.5)
		process_move(rogue_position)
	elif $Selection.position == holy_position:
		move_tween(barbarian_position,0.5)
		process_move(barbarian_position)
	elif $Selection.position == spellblade_position:
		move_tween(holy_position,0.5)
		process_move(holy_position)
	elif $Selection.position == knight_position:
		move_tween(spellblade_position,0.5)
		process_move(spellblade_position)
	else:
		print($Selection.position)


func _on_home_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
func _on_back_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
