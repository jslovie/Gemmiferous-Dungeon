extends Node2D


@export var shop_name : String
@onready var exit_shop = $ExitShop


func _ready():
	$ShopNameLabel.text = shop_name
	
func _process(_delta):
	update_level()

func _on_exit_shop_pressed():
	SaveManager.savefilesave()
	exit_door()


func _on_card_game_pressed():
	Transition.transition()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/card_game/card_game.tscn")
	VillageManager.in_shop = false

func exit_door():
	Sfx.play_SFX(Sfx.door_close)
	VillageManager.in_shop = false
	exit_shop.texture_normal = load("res://assets/32rogues/doors/exitdoor-opened.png")
	exit_shop.texture_hover = load("res://assets/32rogues/doors/exitdoor-opened.png")
	var tween = create_tween()
	tween.tween_property(exit_shop,"scale",Vector2(4,4),0.1)
	tween.tween_property(exit_shop,"scale",Vector2(3,3),0.1)
	await get_tree().create_timer(0.5).timeout
	visible = false
	exit_shop.texture_normal = load("res://assets/32rogues/doors/exitdoor.png")
	exit_shop.texture_hover = load("res://assets/32rogues/doors/exitdoor-highlighted.png")
	
func update_level():
	if shop_name == "Weaponsmith":
		$Level.text = "Level: " + str(VillageManager.weaponsmith_lvl)
