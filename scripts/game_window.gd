extends Node2D

@onready var relic_handler = %RelicHandler

const RESOURCE_PATH = "user://resources/"

var particle_effect = preload("res://scenes/pieces/particle.tscn")

var treasure_timeout_min = 15
var treasure_timeout_max = 20

var last_whole: int = -1

var pauses = 3
var pause_game

func _ready():
	LevelManager.level_active = true
	SaveManager.load_autosave()
	SaveManager.load_savefile()
	PlayerManager.player.update_player_texture()
	change_background()
	update_treasures_bar()
	update_total_treasures_bar()
	%Resolution.visible = false
	$Desktop/Chest.visible = false
	setup_treasure()
	update_healthbars()
	update_shields()
	update_rage()
	$Desktop/EnemyTypeLabel/Timer.timer_start()
	$Desktop/Hud.visible = false
	$SlotMachine.visible = false
	$Desktop/MaterialTotal.visible = false
	$Desktop/GemsTotal.visible = false
	wait_time()
	PlayerManager.player.shield += PlayerManager.player.upgraded_shield_init
	load_relics()
	RelicManager.set_ui($Desktop/RelicName,$Desktop/RelicDescription)
	
func _process(_delta):
	update_healthbars()
	update_shields()
	resolution_screen()
	update_rage()
	handle_win()
	check_enemy_debuff()
	check_player_debuff()
	update_treasures_bar()
	update_relic_description()
	update_action_timer()
	trigger_scale()
	update_pauses()
	
func load_relics():
	var dir = DirAccess.open(RESOURCE_PATH)
	for file in dir.get_files():
		relic_handler.add_relic(SaveManager.load_resource(file))

func setup_treasure():
	if LevelManager.type == "Treasure":
		$Desktop/Chest/ChestCloseDetection/CollisionShape2D.disabled = false
		$TurnsDescription/CollisionShape2D.disabled = true
		$Desktop/EnemyTypeLabel.text = "Treasure"
		$Desktop/Enemy.queue_free()
		%EnemyHealth.visible = false
		$Desktop/Chest.visible = true
		LevelManager.treasure_timesup = false
		var time_left = randi_range(treasure_timeout_min, treasure_timeout_max)
		$Desktop/TreasureTimer.start(time_left + 0.4)
		
	else:
		$Desktop/EnemyTypeLabel.text = EnemyManager.enemy.type

func trigger_scale():
	var t = int(ceil($Desktop/TreasureTimer.time_left - 0.5))
	if t != last_whole:
		last_whole = t
		scale_tween()

func scale_tween():
	var tween = create_tween()
	tween.tween_property($Desktop/Chest/ActionTimer,"scale",Vector2(0.15,0.15),0.05).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property($Desktop/Chest/ActionTimer,"scale",Vector2(0.10,0.10),0.05).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

func update_action_timer():
	$Desktop/Chest/ActionTimer.text = int_to_roman(round($Desktop/TreasureTimer.time_left))

func int_to_roman(value: int) -> String:
	var roman_map = [
		[1000, "M"], [900, "CM"], [500, "D"], [400, "CD"],
		[100, "C"], [90, "XC"], [50, "L"], [40, "XL"],
		[10, "X"], [9, "IX"], [5, "V"], [4, "IV"], [1, "I"]
	]
	var result := ""
	for pair in roman_map:
		var val: int = pair[0]
		var sym: String = pair[1]
		while value >= val:
			value -= val
			result += sym
	return result

func update_relic_description():
	$Desktop/RelicName.text = RelicManager.relic_name
	$Desktop/RelicDescription.text = RelicManager.relic_description
	if LevelManager.level_active == false:
		$Desktop/RelicName.visible = false
		$Desktop/RelicDescription.visible = false
	if LevelManager.is_mobile:
		if RelicManager.hide_stats:
			$Desktop/Gems.visible = false
			$Desktop/Material.visible = false
			%PlayerHealth.visible = false
		else:
			$Desktop/Gems.visible = true
			$Desktop/Material.visible = true
			%PlayerHealth.visible = true
		

func change_background():
	if LevelManager.floor == 1:
		$Desktop/Background/F1.visible = true
	elif LevelManager.floor == 2:
		$Desktop/Background/F2.visible = true
	elif LevelManager.floor == 3:
		$Desktop/Background/F3.visible = true
	elif LevelManager.floor == 4:
		$Desktop/Background/F4.visible = true

func update_treasures_bar():
	$Desktop/Material/HBoxContainer/Wood.text = ": " + str(PlayerManager.player.wood)
	$Desktop/Material/HBoxContainer/Stone.text = ": " + str(PlayerManager.player.stone)
	$Desktop/Material/HBoxContainer/Iron.text = ": " + str(PlayerManager.player.iron)
	$Desktop/Gems/HBoxContainer/RedGem.text = ": " + str(PlayerManager.player.red_gem)
	$Desktop/Gems/HBoxContainer/BlueGem.text = ": " + str(PlayerManager.player.blue_gem)
	$Desktop/Gems/HBoxContainer/GreenGem.text = ": " + str(PlayerManager.player.green_gem)
	$Desktop/Gems/HBoxContainer/YellowGem.text = ": " + str(PlayerManager.player.yellow_gem)
	$Desktop/Material/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.coins)
	
func update_total_treasures_bar():
	$Desktop/MaterialTotal/HBoxContainer/Wood.text = ": " + str(PlayerManager.player.total_wood)
	$Desktop/MaterialTotal/HBoxContainer/Stone.text = ": " + str(PlayerManager.player.total_stone)
	$Desktop/MaterialTotal/HBoxContainer/Iron.text = ": " + str(PlayerManager.player.total_iron)
	$Desktop/GemsTotal/HBoxContainer/RedGem.text = ": " + str(PlayerManager.player.total_red_gem)
	$Desktop/GemsTotal/HBoxContainer/BlueGem.text = ": " + str(PlayerManager.player.total_blue_gem)
	$Desktop/GemsTotal/HBoxContainer/GreenGem.text = ": " + str(PlayerManager.player.total_green_gem)
	$Desktop/GemsTotal/HBoxContainer/YellowGem.text = ": " + str(PlayerManager.player.total_yellow_gem)
	$Desktop/MaterialTotal/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.total_coins)
	
func wait_time():
	$Desktop/WaitTime.visible = true
	%WaitTimeTimer.start(3)
	get_tree().paused = true
	if LevelManager.type == "Treasure":
		Music.play_music_treasure()
	elif LevelManager.type == "Elite Enemy":
		Music.play_music_combat_elite()
	elif LevelManager.type == "Boss":
		Music.play_music_boss()
	else:
		Music.play_music_combat()
	
func update_healthbars():
	#Player healthbar
	%PlayerHealth.value = PlayerManager.player.health
	%PlayerHealth.max_value = PlayerManager.player.max_health
	%PlayerHealthLabel.text = str(PlayerManager.player.health)
	if LevelManager.type == "Treasure":
		pass
	else:
		#Enemy healthbar
		%EnemyHealth.value = EnemyManager.enemy.health
		%EnemyHealth.max_value = EnemyManager.enemy.max_health
		%EnemyHealthLabel.text = str(EnemyManager.enemy.health)
	
func update_shields():
	#Player shield
	if PlayerManager.player.shield == 0:
		%PlayerShield.visible = false
		%PlayerShieldLabel.visible = false
	else:
		%PlayerShield.visible = true
		%PlayerShieldLabel.visible = true
		%PlayerShieldLabel.text = str(PlayerManager.player.shield)
	if LevelManager.type == "Treasure":
		pass
	else:
		#Enemy shield
		if EnemyManager.enemy.shield == 0:
			%EnemyShield.visible = false
			%EnemyShieldLabel.visible = false
		else:
			%EnemyShield.visible = true
			%EnemyShieldLabel.visible = true
			%EnemyShieldLabel.text = str(EnemyManager.enemy.shield)

func update_rage():
	%PlayerRage.value = PlayerManager.player.rage
	if PlayerManager.player.type != "Barbarian":
		%PlayerRage.visible = false

func update_result():
	$Desktop/Resolution/Result/Labels/RedGem.text = ": " + str($Grid.red_gem_gained)
	$Desktop/Resolution/Result/Labels/BlueGem.text = ": " + str($Grid.blue_gem_gained)
	$Desktop/Resolution/Result/Labels/GreenGem.text = ": " + str($Grid.green_gem_gained)
	$Desktop/Resolution/Result/Labels/YellowGem.text = ": " + str($Grid.yellow_gem_gained)
	$Desktop/Resolution/Result/Labels/Coins.text = ": " + str($Grid.coins_gained)
	

func resolution_screen():
	if LevelManager.type == "Treasure":
		if LevelManager.treasure_timesup == true:
			%Resolution.visible = true
			%ResolutionText.text = "time's up!"
			$Desktop/Chest/ActionTimer.visible = false
			await get_tree().create_timer(1).timeout
			if LevelManager.is_mobile:
				%Continue.visible = false
				$ContinueMobile.visible = true
			else:
				%Continue.visible = true
				$ContinueMobile.visible = false
			update_result()
			move_tween(%Result,Vector2(993,601),0.8)
			move_tween(%Continue,Vector2(1097,950),0.8)
			
	else:
		if EnemyManager.enemy.status == "dead":
			$Desktop/Hud.visible = false
			%Resolution.visible = true
			%ResolutionText.text = "foe vanquished!"
			%EnemyHealth.visible = false
			$SlotMachine.visible = true
			var tween = create_tween()
			if LevelManager.is_mobile:
				tween.tween_property($SlotMachine, "position", Vector2(288,459), 0.1)
			else:
				tween.tween_property($SlotMachine, "position", Vector2(287,664), 0.1)
		elif PlayerManager.player.status == "dead":
			$Desktop/Hud.visible = false
			%Resolution.visible = true
			%ResolutionText.text = ""
			%PlayerHealth.visible = false
			move_tween($Desktop/Material,Vector2(843,-123),0.8)
			move_tween($Desktop/Gems,Vector2(843,-123),0.8)
			#$Desktop/Material.visible = false
			#$Desktop/Gems.visible = false
			relic_handler.visible = false
			var tween = create_tween()
			move_tween($PlayerDied,Vector2(285,514),0.8)
			Music.play_music_game_over()
		else:
			$Desktop/Hud.visible = true

		
func handle_win():
	if LevelManager.handle_winning == true:
		%Resolution.visible = false
		$SlotMachine.visible = false
		move_tween($Player_win,Vector2(285,514),0.8)
		move_tween($Desktop/Material,Vector2(843,-123),0.8)
		move_tween($Desktop/Gems,Vector2(843,-123),0.8)
		move_tween($Desktop/MaterialTotal,Vector2(843,-34),0.8)
		move_tween($Desktop/GemsTotal,Vector2(-596,-34),0.8)

func check_enemy_debuff():
	if PlayerManager.player.bleed_active == true:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Bleed.visible = true
	else:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Bleed.visible = false
	if PlayerManager.player.poison_active == true:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Poison.visible = true
	else:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Poison.visible = false
	if PlayerManager.player.ice_active == true:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Ice.visible = true
	else:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Ice.visible = false

	if PlayerManager.player.fire_active == true:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Fire.visible = true
	else:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Fire.visible = false

	if PlayerManager.player.electric_active == true:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Electric.visible = true
	else:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Electric.visible = false
	if PlayerManager.player.stun_active == true:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Stun.visible = true
	else:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Stun.visible = false
	if PlayerManager.player.weak_active == true:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Weak.visible = true
	else:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Weak.visible = false
	if PlayerManager.player.vulnerable_active == true:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Vulnerable.visible = true
	else:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Vulnerable.visible = false
	if PlayerManager.player.frail_active == true:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Frail.visible = true
	else:
		$Desktop/Hud/EnemyHealth/HBoxContainer/Frail.visible = false

func check_player_debuff():
	if PlayerManager.player.is_invisible == true:
		$Desktop/Hud/EnemyHealth/HBoxContainerPlayer/Invisibility.visible = true
	else:
		$Desktop/Hud/EnemyHealth/HBoxContainerPlayer/Invisibility.visible = false

func _on_wait_time_timer_timeout():
	get_tree().paused = false
	$Desktop/WaitTime.visible = false
	


func _on_button_pressed():
	PlayerManager.player.heal(15)


func _on_wood_area_2d_area_entered(_area):
	$Desktop/Material/HBoxContainer/Wood.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Desktop/Material/HBoxContainer/Wood.add_theme_color_override("font_color",Color.WHITE)
func _on_stone_area_2d_area_entered(_area):
	$Desktop/Material/HBoxContainer/Stone.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Desktop/Material/HBoxContainer/Stone.add_theme_color_override("font_color",Color.WHITE)
func _on_iron_area_2d_area_entered(_area):
	$Desktop/Material/HBoxContainer/Iron.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Desktop/Material/HBoxContainer/Iron.add_theme_color_override("font_color",Color.WHITE)
func _on_red_gem_area_2d_area_entered(_area):
	$Desktop/Gems/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Desktop/Gems/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.WHITE)
func _on_blue_gem_area_2d_area_entered(_area):
	$Desktop/Gems/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Desktop/Gems/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.WHITE)
func _on_greem_gem_area_2d_area_entered(_area):
	$Desktop/Gems/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Desktop/Gems/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.WHITE)
func _on_yellow_gem_area_2d_area_entered(_area):
	$Desktop/Gems/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Desktop/Gems/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.WHITE)
func _on_coin_area_2d_area_entered(_area):
	$Desktop/Material/HBoxContainer/Coin.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Desktop/Material/HBoxContainer/Coin.add_theme_color_override("font_color",Color.WHITE)


func _on_shield_area_entered(_area):
	PlayerManager.player.shield_up(PlayerManager.player.shield_to_be_loaded)


func color_change():
	if PlayerManager.player.wood_died > 0:
		$Desktop/MaterialTotal/HBoxContainer/Wood.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.stone_died > 0:
		$Desktop/MaterialTotal/HBoxContainer/Stone.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.iron_died > 0:
		$Desktop/MaterialTotal/HBoxContainer/Iron.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.red_gem_died > 0:
		$Desktop/GemsTotal/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.blue_gem_died > 0:
		$Desktop/GemsTotal/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.green_gem_died > 0:
		$Desktop/GemsTotal/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.yellow_gem_died > 0:
		$Desktop/GemsTotal/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.coins_died > 0:
		$Desktop/MaterialTotal/HBoxContainer/Coin.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(1).timeout
	$Desktop/MaterialTotal/HBoxContainer/Wood.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/MaterialTotal/HBoxContainer/Stone.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/MaterialTotal/HBoxContainer/Iron.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/GemsTotal/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/GemsTotal/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/GemsTotal/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/GemsTotal/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/MaterialTotal/HBoxContainer/Coin.add_theme_color_override("font_color",Color.WHITE)	
	
func color_change_on_win():
	if PlayerManager.player.wood > 0:
		$Desktop/MaterialTotal/HBoxContainer/Wood.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.stone > 0:
		$Desktop/MaterialTotal/HBoxContainer/Stone.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.iron > 0:
		$Desktop/MaterialTotal/HBoxContainer/Iron.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.red_gem > 0:
		$Desktop/GemsTotal/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.blue_gem > 0:
		$Desktop/GemsTotal/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.green_gem > 0:
		$Desktop/GemsTotal/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.yellow_gem > 0:
		$Desktop/GemsTotal/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.coins > 0:
		$Desktop/MaterialTotal/HBoxContainer/Coin.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(1).timeout
	$Desktop/MaterialTotal/HBoxContainer/Wood.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/MaterialTotal/HBoxContainer/Stone.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/MaterialTotal/HBoxContainer/Iron.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/GemsTotal/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/GemsTotal/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/GemsTotal/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/GemsTotal/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.WHITE)
	$Desktop/MaterialTotal/HBoxContainer/Coin.add_theme_color_override("font_color",Color.WHITE)	

func pause():
	$Pause.visible = true
	get_tree().paused = true


func unpause():
	if pause_game:
		$Pause.visible = false
	else:
		$Pause.visible = false
		get_tree().paused = false

func _on_player_died_update_total_bar():
	RelicManager.hide_stats = true
	$Desktop/MaterialTotal.visible = true
	$Desktop/GemsTotal.visible = true
	move_tween($Desktop/MaterialTotal,Vector2(843,-34),0.8)
	move_tween($Desktop/GemsTotal,Vector2(-596,-34),0.8)
	await get_tree().create_timer(1.4).timeout
	update_total_treasures_bar()
	color_change()


func _on_treasure_timer_timeout():
	LevelManager.timer_stop = true
	LevelManager.level_active = false
	LevelManager.treasure_timesup = true
	Music.dim_music()
	$Desktop/Chest/ChestClosed.visible = true
	#LevelManager.switch_to_dungeon_map()
	#await get_tree().create_timer(3).timeout
	#Music.music_to_normal()

func update_pauses():
	$Desktop/PauseGame/PauseLabel.text = "x" + str(pauses)

func scale_tween_object(object,scale_to,scale_back,time):
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property(object,"scale",scale_to,time)
	tween.tween_property(object,"scale",scale_back,time)

func make_effect(effect, pos, color):
	var current = effect.instantiate()
	current.position = pos
	add_child(current)
	current.color = color

func _on_home_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	scale_tween_object($Desktop/Home,Vector2(2.4,2.4),Vector2(2,2),0.2)
	pause()

func _on_back_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	$Pause/Back/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
	$Pause/Progress.visible = true
	$Pause/Progress.text = "Press Back to return to the game"
func _on_back_mouse_exited():
	$Pause/Back/Label.add_theme_color_override("font_color", Color.WHITE)
	$Pause/Progress.visible = false
	
func _on_back_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	unpause()

func _on_menu_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	LevelManager.back_to_village()

func _on_menu_mouse_entered():
	$Pause/Menu/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
	Sfx.play_SFX(Sfx.in_game_hover)
	$Pause/Progress.visible = true
	$Pause/Progress.text = "Press Exit to return to the village 
	Please note all loot and progress will be lost"
func _on_menu_mouse_exited():
	$Pause/Menu/Label.add_theme_color_override("font_color", Color.WHITE)
	$Pause/Progress.visible = false

func _on_home_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	RelicManager.relic_name = "Press to open Menu"
	$Desktop/Home/TextureRect.modulate = Color(0.537, 0.558, 0.828)

func _on_home_mouse_exited():
	RelicManager.relic_name = ""
	$Desktop/Home/TextureRect.modulate = Color(0.369, 0.38, 0.675)

func _on_shuffle_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	RelicManager.relic_name = "Press to Shuffle the board"
	$Grid/Shuffle/TextureRect.modulate = Color(0.537, 0.558, 0.828)

func _on_shuffle_mouse_exited():
	RelicManager.relic_name = ""
	$Grid/Shuffle/TextureRect.modulate = Color(0.369, 0.38, 0.675)


func _on_player_win_update_total_bar():
	RelicManager.hide_stats = true
	$Desktop/MaterialTotal.visible = true
	$Desktop/GemsTotal.visible = true
	$Desktop/Material.visible = false
	$Desktop/Gems.visible = false
	await get_tree().create_timer(1).timeout
	update_total_treasures_bar()
	color_change_on_win()


func _on_continue_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	Music.music_to_normal()
	LevelManager.switch_to_dungeon_map_timeless()
func _on_continue_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	$Desktop/Resolution/Continue/ContinueLabel.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_continue_mouse_exited():
	$Desktop/Resolution/Continue/ContinueLabel.add_theme_color_override("font_color", Color.WHITE)


func _on_continue_mobile_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	Music.music_to_normal()
	LevelManager.switch_to_dungeon_map_timeless()
func _on_continue_mobile_mouse_entered():
	$ContinueMobile/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_continue_mobile_mouse_exited():
	$ContinueMobile/Label.add_theme_color_override("font_color", Color.WHITE)

func move_tween(object,pos,time):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property(object,"position",pos,time)


func _on_turns_description_mouse_entered():
	RelicManager.relic_name = "Seconds until enemy action"
func _on_turns_description_mouse_exited():
	RelicManager.relic_name = ""

func _on_pause_game_pressed():
	if pauses <= 0:
		return
	Sfx.play_SFX(Sfx.button_confirm)
	scale_tween_object($Desktop/PauseGame,Vector2(2.4,2.4),Vector2(2,2),0.2)
	if pause_game:
		pause_game = false
		$Desktop/PauseGame/Sprite2D.texture = load("res://assets/32rogues/pieces/pause.png")
		await get_tree().process_frame
		get_tree().paused = false
		pauses -= 1
		if pauses == 0:
			$Desktop/PauseGame.visible = false
			make_effect(particle_effect,$Desktop/PauseGame.position,$Desktop/PauseGame/TextureRect.modulate)
			make_effect(particle_effect,$Desktop/PauseGame.position,$Desktop/PauseGame/TextureRect.modulate)
			make_effect(particle_effect,$Desktop/PauseGame.position,$Desktop/PauseGame/TextureRect.modulate)
	else:
		pause_game = true
		$Desktop/PauseGame/Sprite2D.texture = load("res://assets/32rogues/pieces/play.png")
		await get_tree().process_frame
		get_tree().paused = true
	
func _on_pause_game_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	$Desktop/PauseGame/TextureRect.modulate = Color(0.537, 0.558, 0.828)
	if pause_game:
		RelicManager.relic_name = "Press to Resume the game"
	else:
		RelicManager.relic_name = "Press to Pause and think"
func _on_pause_game_mouse_exited():
	$Desktop/PauseGame/TextureRect.modulate = Color(0.369, 0.38, 0.675)
	RelicManager.relic_name = ""


func _on_chest_close_detection_mouse_entered():
	RelicManager.relic_name = "Seconds until chest closes"
func _on_chest_close_detection_mouse_exited():
	RelicManager.relic_name = ""
