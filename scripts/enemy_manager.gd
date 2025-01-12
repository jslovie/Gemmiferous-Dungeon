extends Node

const ENEMY = preload("res://scenes/enemies/enemy.tscn")


var enemy : Enemy

var type : String
var health : float
var health_increase : float
var max_health : float
var shield : float
var shield_increase : int
var damage : float
var coin_worth : int
var hit_multiplier : int
var action_delay : float
var blood_type : String

#var enemy_type : String

func print_test():
	print("inside of Enemy Manager")
	print(health)
	print(health_increase)
	print(max_health)
	print(shield_increase)
	print("Action delay is: " + str(action_delay))
	print(blood_type)
