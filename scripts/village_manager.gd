extends Node

#Facility timers
var wood_m
var wood_s
var wood_time_left = 30
var stone_m
var stone_s
var stone_time_left = 30
var iron_m
var iron_s
var iron_time_left = 30


#Village workers
var wood_collected = 0
var stone_collected = 0
var iron_collected = 0

#Building levels
var tavern_lvl = 1
var weaponsmith_lvl = 1
var armourer_lvl = 1

#Buildings state
var church_repaired = false
var tavern_repaired = false
var weaponsmith_repaired = false
var armourer_repaired = false
var sorcerer_repaired = false
var town_square_repaired = false
var farm_repaired = false
var houses_repaired = false
var left_watchtower_repaired = false
var right_watchtower_repaired = false
var woodcutters_camp_repaired = false
var stone_mine_repaired = false
var iron_mine_repaired = false

#Item levels
var axe_item_lvl = 1
var mace_item_lvl = 1
var sword_item_lvl = 1
var bow_item_lvl = 1
var longsword_lvl = 1
var dagger_item_lvl = 1
var spell_spear_lvl = 1
var holy_stuff_lvl = 1
var holy_amulet_lvl = 1
var invisibility_ring_lvl = 1
var rage_ring_lvl = 1


var woodcutter_timer = Timer.new()
var stone_mine_timer = Timer.new()
var iron_mine_timer = Timer.new()

func _ready():
	timers()

func timers():
	add_child(woodcutter_timer)
	woodcutter_timer.start(22)
	woodcutter_timer.autostart = true
	woodcutter_timer.one_shot = false
	woodcutter_timer.connect("timeout", _on_woodcutters_timeout)
	add_child(stone_mine_timer)
	stone_mine_timer.start(40)
	stone_mine_timer.autostart = true
	stone_mine_timer.one_shot = false
	stone_mine_timer.connect("timeout", _on_stone_miner_timeout)
	add_child(iron_mine_timer)
	iron_mine_timer.start(55)
	iron_mine_timer.autostart = true
	iron_mine_timer.one_shot = false
	iron_mine_timer.connect("timeout", _on_iron_miner_timeout)
	
func _process(_delta):
	woodcutters_timer()
	stone_miners_timer()
	iron_miners_timer()

func woodcutters_timer():
	wood_m = int(woodcutter_timer.time_left / 60)
	wood_s = int(woodcutter_timer.time_left) - wood_m * 60

func stone_miners_timer():
	stone_m = int(stone_mine_timer.time_left / 60)
	stone_s = int(stone_mine_timer.time_left) - stone_m * 60

func iron_miners_timer():
	iron_m = int(iron_mine_timer.time_left / 60)
	iron_s = int(iron_mine_timer.time_left) - iron_m * 60

func _on_woodcutters_timeout():
	wood_collected += 1
	
func _on_stone_miner_timeout():
	stone_collected += 1

func _on_iron_miner_timeout():
	iron_collected += 1
	
	

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
