extends Node2D


func _ready():
	SaveManager.load_autosave()

func _process(_delta):
	update_healthbars()
	update_shields()
	resolution_screen()
	
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

func resolution_screen():
	if EnemyManager.enemy.status == "dead":
		%Resolution.visible = true
		%ResolutionText.text = "foe vanquished!"
		%EnemyHealth.visible = false
	elif PlayerManager.player.status == "dead":
		%Resolution.visible = true
		%ResolutionText.text = "You died!"
		%PlayerHealth.visible = false
