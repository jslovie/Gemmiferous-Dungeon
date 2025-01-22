extends Node

const PLAYER = preload("res://scenes/player.tscn")

var player : Player


#var sword_damage = 3.0
#var magic_damage = 3.0
#var bow_damage = 3.0
#var health = 50
#var max_health = 50
#var shield = 0
#var shield_load = 0
#var xp = 0
#var coins = 0


#func _ready():
	#get_viewport().size = DisplayServer.screen_get_size()


#func update_stats():
	#var p : Player = PlayerManager.player
	#sword_damage = p.sword_damage
	#magic_damage = p.magic_damage
	#bow_damage = p.bow_damage
	#health = p.health
	#max_health = p.max_health
	#shield = p.shield
	#shield_load = p.shield_load
	#xp = p.xp
	#coins = p.coins

func set_player_stats(type_action1, type_action2, type_action3, health, max_health, shield, shield_load, 
					  coins, materials, type, red_gem, green_gem, blue_gem, yellow_gem):
	player.type_action1 = type_action1
	player.type_action2 = type_action2
	player.type_action3 = type_action3
	player.health = health
	player.max_health = max_health
	player.shield = shield
	player.shield_load = shield_load
	player.coins = coins
	player.materials = materials
	player.type = type
	player.red_gem = red_gem
	player.green_gem = green_gem
	player.blue_gem = blue_gem
	player.yellow_gem = yellow_gem
	
	
	
	
	
