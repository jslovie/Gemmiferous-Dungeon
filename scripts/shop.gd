extends Node2D


@export var shop_name : String


func _ready():
	$ShopNameLabel.text = shop_name
	
func _process(_delta):
	update_level()

func _on_exit_shop_pressed():
	visible = false


func _on_card_game_pressed():
	get_tree().change_scene_to_file("res://scenes/card_game/card_game.tscn")


func _on_upgrade_pressed():
	pass

func update_level():
	if shop_name == "Weaponsmith":
		$Level.text = "Level: " + str(VillageManager.weaponsmith_lvl)
