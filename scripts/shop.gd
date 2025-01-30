extends Node2D


@export var shop_name : String


func _ready():
	$ShopNameLabel.text = shop_name
	
	

func _on_exit_shop_pressed():
	visible = false
