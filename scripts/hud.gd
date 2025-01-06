extends Control

func _process(delta):
	update_hud()
	
func update_hud():
	#Health update
	%PlayerHealth.value = PlayerManager.health
	%PlayerHealth.max_value = PlayerManager.max_health
	%PlayerHealthLabel.text = str(PlayerManager.health)
	
	#Shield update
	if PlayerManager.shield == 0:
		%PlayerShield.visible = false
		%PlayerShieldLabel.visible = false
	else:
		%PlayerShield.visible = true
		%PlayerShieldLabel.visible = true
		%PlayerShieldLabel.text = str(PlayerManager.shield)
