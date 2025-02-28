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
var manor_lvl = 0
var tavern_lvl = 1
var weaponsmith_lvl = 1
var armourer_lvl = 1
var sorcerer_lvl = 1
var woodcutters_lvl = 1
var stone_mine_lvl = 1
var iron_mine_lvl = 1
var rathaus_lvl = 1
var farm_lvl = 1
var build_houses = 0

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
var lamps_built = false
var campfire_built = false

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
	#timers()
	pass

func _process(_delta):
	woodcutters_timer()
	stone_miners_timer()
	iron_miners_timer()

func start_timers():
	wood_timer()
	stone_timer()
	iron_timer()

func wood_timer():
	if woodcutters_camp_repaired == true:
		add_child(woodcutter_timer)
		woodcutter_timer.start(22)
		woodcutter_timer.autostart = true
		woodcutter_timer.one_shot = false
		woodcutter_timer.connect("timeout", _on_woodcutters_timeout)

func stone_timer():
	if woodcutters_camp_repaired == true:
		add_child(stone_mine_timer)
		stone_mine_timer.start(40)
		stone_mine_timer.autostart = true
		stone_mine_timer.one_shot = false
		stone_mine_timer.connect("timeout", _on_stone_miner_timeout)

func iron_timer():
	if woodcutters_camp_repaired == true:
		add_child(iron_mine_timer)
		iron_mine_timer.start(55)
		iron_mine_timer.autostart = true
		iron_mine_timer.one_shot = false
		iron_mine_timer.connect("timeout", _on_iron_miner_timeout)

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
	
	

func set_village_stats(manor_lvl_data, tavern_lvl_data, weaponsmith_lvl_data, armourer_lvl_data, sorcerer_lvl_data, woodcutters_lvl_data, stone_mine_lvl_data, iron_mine_lvl_data, rathaus_lvl_data, 
						farm_lvl_data, build_houses_data, church_repaired_data, tavern_repaired_data, weaponsmith_repaired_data, armourer_repaired_data,sorcerer_repaired_data, town_square_repaired_data, 
						farm_repaired_data, houses_repaired_data, left_watchtower_repaired_data, right_watchtower_repaired_data, woodcutters_camp_repaired_data, stone_mine_repaired_data, iron_mine_repaired_data, 
						lamps_built_data, campfire_built_data, axe_item_lvl_data, mace_item_lvl_data, sword_item_lvl_data, bow_item_lvl_data,):
	manor_lvl = manor_lvl_data
	tavern_lvl = tavern_lvl_data
	weaponsmith_lvl = weaponsmith_lvl_data
	armourer_lvl = armourer_lvl_data
	sorcerer_lvl = sorcerer_lvl_data
	woodcutters_lvl = woodcutters_lvl_data
	stone_mine_lvl = stone_mine_lvl_data
	iron_mine_lvl = iron_mine_lvl_data
	rathaus_lvl = rathaus_lvl_data
	farm_lvl = farm_lvl_data
	build_houses = build_houses_data
	church_repaired = church_repaired_data
	tavern_repaired = tavern_repaired_data
	weaponsmith_repaired = weaponsmith_repaired_data
	armourer_repaired = armourer_repaired_data
	sorcerer_repaired = sorcerer_repaired_data
	town_square_repaired = town_square_repaired_data
	farm_repaired = farm_repaired_data
	houses_repaired = houses_repaired_data
	left_watchtower_repaired = left_watchtower_repaired_data
	right_watchtower_repaired = right_watchtower_repaired_data
	woodcutters_camp_repaired = woodcutters_camp_repaired_data
	stone_mine_repaired = stone_mine_repaired_data
	iron_mine_repaired = iron_mine_repaired_data
	lamps_built = lamps_built_data
	campfire_built = campfire_built_data
	axe_item_lvl = axe_item_lvl_data
	mace_item_lvl = mace_item_lvl_data
	sword_item_lvl = sword_item_lvl_data
	bow_item_lvl = bow_item_lvl_data

func reset_village_stats():
	#Building levels
	manor_lvl = 0
	tavern_lvl = 1
	weaponsmith_lvl = 1
	armourer_lvl = 1
	sorcerer_lvl = 1
	woodcutters_lvl = 1
	stone_mine_lvl = 1
	iron_mine_lvl = 1
	rathaus_lvl = 1
	farm_lvl = 1
	build_houses = 0
	#Buildings state
	church_repaired = false
	tavern_repaired = false
	weaponsmith_repaired = false
	armourer_repaired = false
	sorcerer_repaired = false
	town_square_repaired = false
	farm_repaired = false
	houses_repaired = false
	left_watchtower_repaired = false
	right_watchtower_repaired = false
	woodcutters_camp_repaired = false
	stone_mine_repaired = false
	iron_mine_repaired = false
	lamps_built = false
	campfire_built = false
	#Item levels
	axe_item_lvl = 1
	mace_item_lvl = 1
	sword_item_lvl = 1
	bow_item_lvl = 1
	longsword_lvl = 1
	dagger_item_lvl = 1
	spell_spear_lvl = 1
	holy_stuff_lvl = 1
	holy_amulet_lvl = 1
	invisibility_ring_lvl = 1
	rage_ring_lvl = 1
