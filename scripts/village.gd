extends Node2D


func _ready():
	SaveManager.load_savefile()
	update_treasures()
	update_materials()

func _process(delta):
	update_treasures()
	update_materials()

func update_treasures():
	$GemStats/Control/RedLabel.text = ": " + str(PlayerManager.player.total_red_gem)
	$GemStats/Control/BlueLabel.text = ": " + str(PlayerManager.player.total_blue_gem)
	$GemStats/Control/GreenLabel.text = ": " + str(PlayerManager.player.total_green_gem)
	$GemStats/Control/YellowLabel.text = ": " + str(PlayerManager.player.total_yellow_gem)
	$GemStats/Control/CoinsLabel.text = ": " + str(PlayerManager.player.total_coins)
	
func update_materials():
	$Material/WoodLabel.text = ": " + str(PlayerManager.player.total_wood)
	$Material/StoneLabel.text = ": " + str(PlayerManager.player.total_stone)
	$Material/IronLabel.text = ": " + str(PlayerManager.player.total_iron)


func _on_manor_pressed():
	get_tree().change_scene_to_file("res://scenes/character_selection.tscn")


func _on_taverm_pressed():
	get_tree().change_scene_to_file("res://scenes/card_game/card_game.tscn")


func _on_weaponsmith_pressed():
	$WeaponsmithShop.visible = true
