extends Node2D

var timesup = false

func _ready():
	SaveManager.load_autosave()
	PlayerManager.player.update_player_texture()
	%Timer.timer_start()
	LevelManager.treasure_timesup = false
	$Chest/ChestClosed.visible = false
	get_tree().paused = true
	
func _process(_delta):
	update_healthbars()
	update_shields()
	change_background()
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
