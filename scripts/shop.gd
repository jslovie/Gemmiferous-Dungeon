extends Node2D


@export var shop_name : String


func _ready():
	$ShopNameLabel.text = shop_name
	


func _on_exit_shop_pressed():
	visible = false


func _on_card_game_pressed():
	get_tree().change_scene_to_file("res://scenes/card_game/card_game.tscn")


func _on_upgrade_pressed():
	pass
