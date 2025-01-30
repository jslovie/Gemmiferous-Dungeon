extends Control

func _process(delta):
	update_treasures()
	update_materials()
	
func update_treasures():
	$Gems/GemsNumbers/RedGemNumber.text = ": " + str(PlayerManager.player.red_gem)
	$Gems/GemsNumbers/GreenGemNumber.text = ": " + str(PlayerManager.player.green_gem)
	$Gems/GemsNumbers/BlueGemNumber.text = ": " + str(PlayerManager.player.blue_gem)
	$Gems/GemsNumbers/YellowGemNumber.text = ": " + str(PlayerManager.player.yellow_gem)
	$Gems/GemsNumbers/CoinNumber.text = ": " + str(PlayerManager.player.coins)	

func update_materials():
	$Material/WoodLabel.text = ": " + str(PlayerManager.player.wood)
	$Material/StoneLabel.text = ": " + str(PlayerManager.player.stone)
	$Material/IronLabel.text = ": " + str(PlayerManager.player.iron)

func _on_exit_pressed():
	PlayerManager.player.set_treasure()
	SaveManager.savefilesave()
	get_tree().change_scene_to_file("res://scenes/village.tscn")
