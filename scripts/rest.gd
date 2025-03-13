extends Node2D


func _ready():
	Music.play_music_rest()
	SaveManager.load_savefile()
	SaveManager.load_autosave()
	LevelManager.level_done += 1
	update_treasures()
	update_materials()


func _process(_delta):
	change_background()

func update_treasures():
	$TopBanner/GemStats/Control/RedLabel.text = ": " + str(PlayerManager.player.total_red_gem)
	$TopBanner/GemStats/Control/BlueLabel.text = ": " + str(PlayerManager.player.total_blue_gem)
	$TopBanner/GemStats/Control/GreenLabel.text = ": " + str(PlayerManager.player.total_green_gem)
	$TopBanner/GemStats/Control/YellowLabel.text = ": " + str(PlayerManager.player.total_yellow_gem)
	$TopBanner/GemStats/Control/CoinsLabel.text = ": " + str(PlayerManager.player.total_coins)
	
func update_materials():
	$TopBanner/Material/WoodLabel.text = ": " + str(PlayerManager.player.total_wood)
	$TopBanner/Material/StoneLabel.text = ": " + str(PlayerManager.player.total_stone)
	$TopBanner/Material/IronLabel.text = ": " + str(PlayerManager.player.total_iron)


func change_background():
	if LevelManager.floor == 1:
		$Background/F1.visible = true
	elif LevelManager.floor == 2:
		$Background/F2.visible = true
	elif LevelManager.floor == 3:
		$Background/F3.visible = true
	elif LevelManager.floor == 4:
		$Background/F4.visible = true	
	
func handle_option():
	PlayerManager.player.heal(15)
	SaveManager.autosave()
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	LevelManager.show_map = true

func _on_button_pressed():
	handle_option()

func _on_button_2_pressed():
	$TopBanner.visible = true
	await get_tree().create_timer(1).timeout
	PlayerManager.player.set_treasure()
	PlayerManager.player.reset_current_treasure()
	update_treasures()
	update_materials()
	SaveManager.savefilesave()
	SaveManager.autosave()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	LevelManager.show_map = true
	
func _on_button_3_pressed():
	$Player_win.visible = true
