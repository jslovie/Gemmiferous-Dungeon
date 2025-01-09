extends Node2D

var timesup = false

func _ready():
	SaveManager.load_autosave()

func _process(delta):
	#update_healthbars()
	#update_shields()
	update_collectibles()
	#resolution_screen()
	
func update_healthbars():
	#Player healthbar
	%PlayerHealth.value = PlayerManager.player.health
	%PlayerHealth.max_value = PlayerManager.player.max_health
	%PlayerHealthLabel.text = str(PlayerManager.player.health)
	#Enemy healthbar
	#%EnemyHealth.value = EnemyManager.enemy.health
	#%EnemyHealth.max_value = EnemyManager.enemy.max_health
	#%EnemyHealthLabel.text = str(EnemyManager.enemy.health)
	
func update_shields():
	#Player shield
	if PlayerManager.player.shield == 0:
		%PlayerShield.visible = false
		%PlayerShieldLabel.visible = false
	else:
		%PlayerShield.visible = true
		%PlayerShieldLabel.visible = true
		%PlayerShieldLabel.text = str(PlayerManager.player.shield)
		
	##Enemy shield
	#if EnemyManager.enemy.shield == 0:
		#%EnemyShield.visible = false
		#%EnemyShieldLabel.visible = false
	#else:
		#%EnemyShield.visible = true
		#%EnemyShieldLabel.visible = true
		#%EnemyShieldLabel.text = str(EnemyManager.enemy.shield)

func update_collectibles():
	%CoinsCounter.text = "Coins: " + str(PlayerManager.player.coins)
	#if EnemyManager.enemy.status == "alive":
		#%XPCounter.text = "XP: " + str(PlayerManager.player.xp)

func resolution_screen():
	if timesup == true:
		%Resolution.visible = true
		%ResolutionText.text = "Time's Up!"


func _on_times_up_grid_timeout():
	timesup = true
	resolution_screen()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	LevelManager.show_map = true
