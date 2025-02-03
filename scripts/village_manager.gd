extends Node

#Facility timers
var wood_m
var wood_s
var wood_time_left = 30
var stone_m
var stone_s
var iron_m
var iron_s


#Village workers
var wood_collected = 0
var stone_collected = 0
var iron_collected = 0

#Building levels
var tavern_lvl = 1
var weaponsmith_lvl = 1
var armourer_lvl = 1

#Item levels
var axe_item_lvl = 1


func set_village_stats(tavern_lvl_data, weaponsmith_lvl_data, armourer_lvl_data, axe_item_lvl_data):
	tavern_lvl = tavern_lvl_data
	weaponsmith_lvl = weaponsmith_lvl_data
	armourer_lvl = armourer_lvl_data
	axe_item_lvl = axe_item_lvl_data

func reset_village_stats():
	tavern_lvl = 1
	weaponsmith_lvl = 1
	armourer_lvl = 1
	axe_item_lvl = 1
