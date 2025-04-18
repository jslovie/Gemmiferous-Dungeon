extends Node2D

@onready var relic_handler = %RelicHandler

const RESOURCE_PATH = "user://resources/"

var treasure_timeout_min = 10
var treasure_timeout_max = 20

func _ready():
	LevelManager.level_active = true
	SaveManager.load_autosave()
	SaveManager.load_savefile()
	PlayerManager.player.update_player_texture()
	change_background()
	update_treasures_bar()
	update_total_treasures_bar()
	$Chest.visible = false
	if LevelManager.type == "Treasure":
		$EnemyTypeLabel.text = "Treasure"
		$Enemy.queue_free()
		%EnemyHealth.visible = false
		$Chest.visible = true
		LevelManager.treasure_timesup = false
		$TreasureTimer.start(randi_range(treasure_timeout_min, treasure_timeout_max))
	else:
		$EnemyTypeLabel.text = EnemyManager.enemy.type
	update_healthbars()
	update_shields()
	update_rage()
	$EnemyTypeLabel/Timer.timer_start()
	$Hud.visible = false
	$SlotMachine.visible = false
	$PlayerDied.visible = false
	$Player_win.visible = false
	$MaterialTotal.visible = false
	$GemsTotal.visible = false
	wait_time()
	load_relics()
	
func _process(_delta):
	update_healthbars()
	update_shields()
	resolution_screen()
	update_rage()
	handle_win()
	check_enemy_debuff()
	update_treasures_bar()
	update_relic_description()

func load_relics():
	var dir = DirAccess.open(RESOURCE_PATH)
	for file in dir.get_files():
		relic_handler.add_relic(SaveManager.load_resource(file))

func update_relic_description():
	$RelicName.text = RelicManager.relic_name
	$RelicDescription.text = RelicManager.relic_description
	if LevelManager.level_active == false:
		$RelicName.visible = false
		$RelicDescription.visible = false
		
func change_background():
	if LevelManager.floor == 1:
		$Background/F1.visible = true
	elif LevelManager.floor == 2:
		$Background/F2.visible = true
	elif LevelManager.floor == 3:
		$Background/F3.visible = true
	elif LevelManager.floor == 4:
		$Background/F4.visible = true

func update_treasures_bar():
	$Material/HBoxContainer/Wood.text = ": " + str(PlayerManager.player.wood)
	$Material/HBoxContainer/Stone.text = ": " + str(PlayerManager.player.stone)
	$Material/HBoxContainer/Iron.text = ": " + str(PlayerManager.player.iron)
	$Gems/HBoxContainer/RedGem.text = ": " + str(PlayerManager.player.red_gem)
	$Gems/HBoxContainer/BlueGem.text = ": " + str(PlayerManager.player.blue_gem)
	$Gems/HBoxContainer/GreenGem.text = ": " + str(PlayerManager.player.green_gem)
	$Gems/HBoxContainer/YellowGem.text = ": " + str(PlayerManager.player.yellow_gem)
	$Material/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.coins)
	
func update_total_treasures_bar():
	$MaterialTotal/HBoxContainer/Wood.text = ": " + str(PlayerManager.player.total_wood)
	$MaterialTotal/HBoxContainer/Stone.text = ": " + str(PlayerManager.player.total_stone)
	$MaterialTotal/HBoxContainer/Iron.text = ": " + str(PlayerManager.player.total_iron)
	$GemsTotal/HBoxContainer/RedGem.text = ": " + str(PlayerManager.player.total_red_gem)
	$GemsTotal/HBoxContainer/BlueGem.text = ": " + str(PlayerManager.player.total_blue_gem)
	$GemsTotal/HBoxContainer/GreenGem.text = ": " + str(PlayerManager.player.total_green_gem)
	$GemsTotal/HBoxContainer/YellowGem.text = ": " + str(PlayerManager.player.total_yellow_gem)
	$MaterialTotal/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.total_coins)
	
func wait_time():
	$WaitTime.visible = true
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
	$Hud.visible = true
	if PlayerManager.player.type != "Barbarian":
		%PlayerRage.visible = false
	
func resolution_screen():
	if LevelManager.type == "Treasure":
		if LevelManager.treasure_timesup == true:
			%Resolution.visible = true
			%ResolutionText.text = "time's up!"
	else:
		if EnemyManager.enemy.status == "dead":
			%Resolution.visible = true
			%ResolutionText.text = "foe vanquished!"
			%EnemyHealth.visible = false
			$SlotMachine.visible = true
			var tween = create_tween()
			tween.tween_property($SlotMachine, "position", Vector2(287,664), 0.1)
		elif PlayerManager.player.status == "dead":
			%Resolution.visible = true
			%ResolutionText.text = ""
			%PlayerHealth.visible = false
			$Material.visible = false
			$Gems.visible = false
			relic_handler.visible = false
			var tween = create_tween()
			$PlayerDied.visible = true
			tween.tween_property($PlayerDied, "position", Vector2(285,514), 0.1)
			Music.play_music_game_over()

		
func handle_win():
	if LevelManager.handle_winning == true:
		%Resolution.visible = false
		$SlotMachine.visible = false
		$Player_win.visible = true

func check_enemy_debuff():
	if PlayerManager.player.bleed_active == true:
		$Hud/EnemyHealth/HBoxContainer/Bleed.visible = true
	else:
		$Hud/EnemyHealth/HBoxContainer/Bleed.visible = false
	if PlayerManager.player.poison_active == true:
		$Hud/EnemyHealth/HBoxContainer/Poison.visible = true
	else:
		$Hud/EnemyHealth/HBoxContainer/Poison.visible = false
	if PlayerManager.player.ice_active == true:
		$Hud/EnemyHealth/HBoxContainer/Ice.visible = true
	else:
		$Hud/EnemyHealth/HBoxContainer/Ice.visible = false

	if PlayerManager.player.fire_active == true:
		$Hud/EnemyHealth/HBoxContainer/Fire.visible = true
	else:
		$Hud/EnemyHealth/HBoxContainer/Fire.visible = false

	if PlayerManager.player.electric_active == true:
		$Hud/EnemyHealth/HBoxContainer/Electric.visible = true
	else:
		$Hud/EnemyHealth/HBoxContainer/Electric.visible = false
	if PlayerManager.player.stun_active == true:
		$Hud/EnemyHealth/HBoxContainer/Stun.visible = true
	else:
		$Hud/EnemyHealth/HBoxContainer/Stun.visible = false
	if PlayerManager.player.weak_active == true:
		$Hud/EnemyHealth/HBoxContainer/Weak.visible = true
	else:
		$Hud/EnemyHealth/HBoxContainer/Weak.visible = false
	if PlayerManager.player.vulnerable_active == true:
		$Hud/EnemyHealth/HBoxContainer/Vulnerable.visible = true
	else:
		$Hud/EnemyHealth/HBoxContainer/Vulnerable.visible = false
	if PlayerManager.player.frail_active == true:
		$Hud/EnemyHealth/HBoxContainer/Frail.visible = true
	else:
		$Hud/EnemyHealth/HBoxContainer/Frail.visible = false

func _on_wait_time_timer_timeout():
	get_tree().paused = false
	$WaitTime.visible = false
	


func _on_button_pressed():
	PlayerManager.player.heal(15)


func _on_wood_area_2d_area_entered(_area):
	$Material/HBoxContainer/Wood.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Material/HBoxContainer/Wood.add_theme_color_override("font_color",Color.WHITE)
func _on_stone_area_2d_area_entered(_area):
	$Material/HBoxContainer/Stone.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Material/HBoxContainer/Stone.add_theme_color_override("font_color",Color.WHITE)
func _on_iron_area_2d_area_entered(_area):
	$Material/HBoxContainer/Iron.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Material/HBoxContainer/Iron.add_theme_color_override("font_color",Color.WHITE)
func _on_red_gem_area_2d_area_entered(_area):
	$Gems/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Gems/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.WHITE)
func _on_blue_gem_area_2d_area_entered(_area):
	$Gems/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Gems/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.WHITE)
func _on_greem_gem_area_2d_area_entered(_area):
	$Gems/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Gems/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.WHITE)
func _on_yellow_gem_area_2d_area_entered(_area):
	$Gems/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Gems/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.WHITE)
func _on_coin_area_2d_area_entered(_area):
	$Material/HBoxContainer/Coin.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(0.5).timeout
	$Material/HBoxContainer/Coin.add_theme_color_override("font_color",Color.WHITE)


func _on_shield_area_entered(_area):
	PlayerManager.player.shield_up(PlayerManager.player.shield_to_be_loaded)


func color_change():
	if PlayerManager.player.wood_died > 0:
		$MaterialTotal/HBoxContainer/Wood.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.stone_died > 0:
		$MaterialTotal/HBoxContainer/Stone.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.iron_died > 0:
		$MaterialTotal/HBoxContainer/Iron.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.red_gem_died > 0:
		$GemsTotal/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.blue_gem_died > 0:
		$GemsTotal/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.green_gem_died > 0:
		$GemsTotal/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.yellow_gem_died > 0:
		$GemsTotal/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.coins_died > 0:
		$MaterialTotal/HBoxContainer/Coin.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(1).timeout
	$MaterialTotal/HBoxContainer/Wood.add_theme_color_override("font_color",Color.WHITE)
	$MaterialTotal/HBoxContainer/Stone.add_theme_color_override("font_color",Color.WHITE)
	$MaterialTotal/HBoxContainer/Iron.add_theme_color_override("font_color",Color.WHITE)
	$GemsTotal/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.WHITE)
	$GemsTotal/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.WHITE)
	$GemsTotal/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.WHITE)
	$GemsTotal/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.WHITE)
	$MaterialTotal/HBoxContainer/Coin.add_theme_color_override("font_color",Color.WHITE)	
	
func color_change_on_win():
	if PlayerManager.player.wood > 0:
		$MaterialTotal/HBoxContainer/Wood.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.stone > 0:
		$MaterialTotal/HBoxContainer/Stone.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.iron > 0:
		$MaterialTotal/HBoxContainer/Iron.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.red_gem > 0:
		$GemsTotal/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.blue_gem > 0:
		$GemsTotal/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.green_gem > 0:
		$GemsTotal/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.yellow_gem > 0:
		$GemsTotal/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.GREEN)
	if PlayerManager.player.coins > 0:
		$MaterialTotal/HBoxContainer/Coin.add_theme_color_override("font_color",Color.GREEN)
	await get_tree().create_timer(1).timeout
	$MaterialTotal/HBoxContainer/Wood.add_theme_color_override("font_color",Color.WHITE)
	$MaterialTotal/HBoxContainer/Stone.add_theme_color_override("font_color",Color.WHITE)
	$MaterialTotal/HBoxContainer/Iron.add_theme_color_override("font_color",Color.WHITE)
	$GemsTotal/HBoxContainer/RedGem.add_theme_color_override("font_color",Color.WHITE)
	$GemsTotal/HBoxContainer/BlueGem.add_theme_color_override("font_color",Color.WHITE)
	$GemsTotal/HBoxContainer/GreenGem.add_theme_color_override("font_color",Color.WHITE)
	$GemsTotal/HBoxContainer/YellowGem.add_theme_color_override("font_color",Color.WHITE)
	$MaterialTotal/HBoxContainer/Coin.add_theme_color_override("font_color",Color.WHITE)	

func pause():
	$Pause.visible = true

func unpause():
	$Pause.visible = false


func _on_player_died_update_total_bar():
	$MaterialTotal.visible = true
	$GemsTotal.visible = true
	$Material.visible = false
	$Gems.visible = false
	await get_tree().create_timer(1).timeout
	update_total_treasures_bar()
	color_change()


func _on_treasure_timer_timeout():
	LevelManager.level_active = false
	LevelManager.treasure_timesup = true
	Music.dim_music()
	$Chest/ChestClosed.visible = true
	LevelManager.switch_to_dungeon_map()
	await get_tree().create_timer(3).timeout
	Music.music_to_normal()
	

func tween_size():
	var tween = create_tween()
	tween.tween_property($Home,"size", Vector2(2.2,2.2),0.5)
	await get_tree().create_timer(0.5).timeout
	tween.stop()
	tween.tween_property($Home,"size", Vector2(2,2),0.5)

func _on_home_pressed():
	tween_size()
	pause()

func _on_back_pressed():
	unpause()

func _on_menu_pressed():
	LevelManager.back_to_village()

func _on_menu_mouse_entered():
	$Pause/Progress.visible = true

func _on_menu_mouse_exited():
	$Pause/Progress.visible = false

func _on_home_mouse_entered():
	$Home/TextureRect.modulate = Color(0.537, 0.558, 0.828)

func _on_home_mouse_exited():
	$Home/TextureRect.modulate = Color(0.369, 0.38, 0.675)

func _on_shuffle_mouse_entered():
	$Grid/Shuffle/TextureRect.modulate = Color(0.537, 0.558, 0.828)

func _on_shuffle_mouse_exited():
	$Grid/Shuffle/TextureRect.modulate = Color(0.369, 0.38, 0.675)


func _on_player_win_update_total_bar():
	$MaterialTotal.visible = true
	$GemsTotal.visible = true
	$Material.visible = false
	$Gems.visible = false
	await get_tree().create_timer(1).timeout
	update_total_treasures_bar()
	color_change_on_win()
