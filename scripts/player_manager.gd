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

func set_player_stats(type_action1x,type_action1y, type_action2x,type_action2y, type_action3x, type_action3y, health, max_health, shield, shield_load, 
					  coins, type, red_gem, green_gem, blue_gem, yellow_gem, wood, stone, iron):
	player.type_action1.x = type_action1x
	player.type_action1.y = type_action1y
	player.type_action2.x = type_action2x
	player.type_action2.y = type_action2y
	player.type_action3.x = type_action3x
	player.type_action3.y = type_action3y
	player.health = health
	player.max_health = max_health
	player.shield = shield
	player.shield_load = shield_load
	player.coins = coins
	player.type = type
	player.red_gem = red_gem
	player.green_gem = green_gem
	player.blue_gem = blue_gem
	player.yellow_gem = yellow_gem
	player.wood = wood
	player.stone = stone
	player.iron = iron
	
func set_savefile_stats(total_coins, total_green_gem, total_red_gem, total_blue_gem, total_yellow_gem, 
	total_wood, total_stone, total_iron, upgraded_axe_damage_x, upgraded_axe_damage_y):
		
	player.total_coins = total_coins
	player.total_green_gem = total_green_gem
	player.total_red_gem = total_red_gem
	player.total_blue_gem = total_blue_gem
	player.total_yellow_gem = total_yellow_gem
	player.total_wood = total_wood
	player.total_stone = total_stone
	player.total_iron = total_iron
	player.upgraded_axe_damage.x = upgraded_axe_damage_x
	player.upgraded_axe_damage.y = upgraded_axe_damage_y
