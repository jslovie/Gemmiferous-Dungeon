extends Node2D



func _ready():
	SaveManager.load_autosave()
	SaveManager.load_savefile()
	PlayerManager.player.update_player_texture()
	$EnemyTypeLabel.text = EnemyManager.enemy.type
	update_healthbars()
	update_shields()
	update_rage()
	$EnemyTypeLabel/Timer.timer_start()
	wait_time()
	$Hud.visible = false
	$SlotMachine.visible = false
	$PlayerDied.visible = false
	$Player_win.visible = false
	
func _process(_delta):
	update_healthbars()
	update_shields()
	resolution_screen()
	update_rage()
	handle_win()

func wait_time():
	$WaitTime.visible = true
	%WaitTimeTimer.start(5)
	get_tree().paused = true
	
func update_healthbars():
	#Player healthbar
	%PlayerHealth.value = PlayerManager.player.health
	%PlayerHealth.max_value = PlayerManager.player.max_health
	%PlayerHealthLabel.text = str(PlayerManager.player.health)
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
		var tween = create_tween()
		$PlayerDied.visible = true
		tween.tween_property($PlayerDied, "position", Vector2(285,514), 0.1)

func handle_win():
	if LevelManager.handle_winning == true:
		%Resolution.visible = false
		$SlotMachine.visible = false
		$Player_win.visible = true

func _on_wait_time_timer_timeout():
	get_tree().paused = false
	$WaitTime.visible = false
	


func _on_button_pressed():
	PlayerManager.player.heal(15)
