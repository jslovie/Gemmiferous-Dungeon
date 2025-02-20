extends Node2D

#Repairs
@export var manor1_repair_price : Vector3
@export var manor2_repair_price : Vector3
@export var manor3_repair_price : Vector3
@export var manor_repair_description : String
@export var church_repair_price : Vector3
@export var church_repair_description : String
@export var tavern_repair_price : Vector3
@export var tavern_repair_description : String
@export var weaponsmith_repair_price : Vector3
@export var weaponsmith_repair_description : String
@export var armourer_repair_price : Vector3
@export var armourer_repair_description : String
@export var sorcerer_repair_price : Vector3
@export var sorcererh_repair_description : String
@export var town_square_repair_price : Vector3
@export var town_square_repair_description : String
@export var farm_repair_price : Vector3
@export var farm_repair_description : String
@export var houses_repair_price : Vector3
@export var houses_repair_description : String
@export var left_watchtower_repair_price : Vector3
@export var left_watchtower_repair_description : String
@export var right_watchtower_repair_price : Vector3
@export var right_watchtower_repair_description : String
@export var woodcutters_camp_repair_price : Vector3
@export var woodcutters_camp_repair_description : String
@export var stone_mine_repair_price : Vector3
@export var stone_mine_repair_description : String
@export var iron_mine_repair_price : Vector3
@export var iron_mine_repair_description : String

#Upgrades
@export var tavern1_upgrade_price : Vector3
@export var tavern2_upgrade_price : Vector3
@export var tavern3_upgrade_price : Vector3
@export var weaponsmith1_upgrade_price : Vector3
@export var weaponsmith2_upgrade_price : Vector3
@export var weaponsmith3_upgrade_price : Vector3
@export var armourer1_upgrade_price : Vector3
@export var armourer2_upgrade_price : Vector3
@export var armourer3_upgrade_price : Vector3
@export var sorcerer1_upgrade_price : Vector3
@export var sorcerer2_upgrade_price : Vector3
@export var sorcerer3_upgrade_price : Vector3
@export var woodcutters_camp1_upgrade_price : Vector3
@export var woodcutters_camp2_upgrade_price : Vector3
@export var woodcutters_camp3_upgrade_price : Vector3
@export var stone_mine1_upgrade_price : Vector3
@export var stone_mine2_upgrade_price : Vector3
@export var stone_mine3_upgrade_price : Vector3
@export var iron_mine1_upgrade_price : Vector3
@export var iron_mine2_upgrade_price : Vector3
@export var iron_mine3_upgrade_price : Vector3
@export var rathaus1_upgrade_price : Vector3
@export var rathaus2_upgrade_price : Vector3
@export var rathaus3_upgrade_price : Vector3
@export var farm1_upgrade_price : Vector3
@export var farm2_upgrade_price : Vector3
@export var farm3_upgrade_price : Vector3
@export var lamp_upgrade_price : Vector3
@export var campfire_upgrade_price : Vector3
@export var houses1_upgrade_price : Vector3
@export var houses2_upgrade_price : Vector3
@export var houses3_upgrade_price : Vector3
@export var houses4_upgrade_price : Vector3

func _process(delta):
	update_text()
	update_checked()
	check_manor_level()
	manor_button()

func update_checked():
	if VillageManager.manor_lvl == 3 and VillageManager.houses_repaired == true:
		$TownUpgrades/VBoxContainer/HousesUpgrade.visible = true
	if VillageManager.manor_lvl == 3:
		$TownRepair/VBoxContainer/Manor/Checked.visible = true
		$TownRepair/VBoxContainer/Manor.disabled = true
		$TownUpgrades/VBoxContainer/CampfireUpgrade.visible = true
		$TownUpgrades/VBoxContainer/LampsUpgrade.visible = true
	if VillageManager.church_repaired == true:
		$TownRepair/VBoxContainer/Church/Checked.visible = true
		$TownRepair/VBoxContainer/Church.disabled = true
	if VillageManager.tavern_repaired == true:
		$TownRepair/VBoxContainer/Tavern/Checked.visible = true
		$TownRepair/VBoxContainer/Tavern.disabled = true
		$TownUpgrades/VBoxContainer/TavernUpgrade.visible = true
	if VillageManager.weaponsmith_repaired == true:
		$TownRepair/VBoxContainer/Weaponsmith/Checked.visible = true
		$TownRepair/VBoxContainer/Weaponsmith.disabled = true
		$TownUpgrades/VBoxContainer/WeaponsmithUpgrade.visible = true
	if VillageManager.armourer_repaired == true:
		$TownRepair/VBoxContainer/Armourer/Checked.visible = true
		$TownRepair/VBoxContainer/Armourer.disabled = true
		$TownUpgrades/VBoxContainer/ArmourerUpgrade.visible = true
	if VillageManager.sorcerer_repaired == true:
		$TownRepair/VBoxContainer/Sorcerer/Checked.visible = true
		$TownRepair/VBoxContainer/Sorcerer.disabled = true
		$TownUpgrades/VBoxContainer/SorcererUpgrade.visible = true
	if VillageManager.town_square_repaired == true:
		$TownRepair/VBoxContainer/TownSquare/Checked.visible = true
		$TownRepair/VBoxContainer/TownSquare.disabled = true
		$TownUpgrades/VBoxContainer/RathausUpgrade.visible = true
	if VillageManager.farm_repaired == true:
		$TownRepair/VBoxContainer/Farm/Checked.visible = true
		$TownRepair/VBoxContainer/Farm.disabled = true
		$TownUpgrades/VBoxContainer/FarmUpgrade.visible = true
	if VillageManager.houses_repaired == true:
		$TownRepair/VBoxContainer/Houses/Checked.visible = true
		$TownUpgrades/VBoxContainer/HousesUpgrade.disabled = true
	if VillageManager.left_watchtower_repaired == true:
		$TownRepair/VBoxContainer/LeftWatchtower/Checked.visible = true
		$TownRepair/VBoxContainer/LeftWatchtower.disabled = true
	if VillageManager.right_watchtower_repaired == true:
		$TownRepair/VBoxContainer/RightWatchtower/Checked.visible = true
		$TownRepair/VBoxContainer/RightWatchtower.disabled = true
	if VillageManager.woodcutters_camp_repaired == true:
		$TownRepair/VBoxContainer/WoodcuttersCamp/Checked.visible = true
		$TownRepair/VBoxContainer/WoodcuttersCamp.disabled = true
		$TownUpgrades/VBoxContainer/WoodcuttersUpgrade.visible = true
	if VillageManager.stone_mine_repaired == true:
		$TownRepair/VBoxContainer/StoneMine/Checked.visible = true
		$TownRepair/VBoxContainer/StoneMine.disabled = true
		$TownUpgrades/VBoxContainer/StoneMineUpgrade.visible = true
	if VillageManager.iron_mine_repaired == true:
		$TownRepair/VBoxContainer/IronMine/Checked.visible = true
		$TownRepair/VBoxContainer/IronMine.disabled = true
		$TownUpgrades/VBoxContainer/IronMineUpgrade.visible = true



func check_enough_material(wood,stone,iron):
	if PlayerManager.player.total_wood >= wood and PlayerManager.player.total_stone >= stone and PlayerManager.player.total_iron >= iron:
		return true
	else:
		return false

func not_enough():
	$Cost/Description.visible = false
	$Cost/NotEnough.visible = true
	await get_tree().create_timer(1).timeout
	$Cost/Description.visible = true
	$Cost/NotEnough.visible = false

func process_cost(wood,stone,iron):
	PlayerManager.player.total_wood -= wood
	PlayerManager.player.total_stone -= stone
	PlayerManager.player.total_iron -= iron
	SaveManager.savefilesave()
	$Cost.visible = false

func _on_enter_the_dungeon_pressed():
	get_tree().change_scene_to_file("res://scenes/character_selection.tscn")

func _on_exit_shop_pressed():
	visible = false


func manor_button():
	if VillageManager.manor_lvl == 0:
		$TownRepair/VBoxContainer/Manor/Label.text = "Repair Manor lvl 1"
	elif VillageManager.manor_lvl == 1:
		$TownRepair/VBoxContainer/Manor/Label.text = "Repair Manor lvl 2"
	elif VillageManager.manor_lvl == 2:
		$TownRepair/VBoxContainer/Manor/Label.text = "Repair Manor lvl 3"

func check_manor_level():
	if VillageManager.manor_lvl == 1:
		$TownRepair/VBoxContainer/Church.visible = true
		$TownRepair/VBoxContainer/Tavern.visible = true
		$TownRepair/VBoxContainer/Weaponsmith.visible = true
		$TownRepair/VBoxContainer/Armourer.visible = true
		$TownRepair/VBoxContainer/Sorcerer.visible = true
	elif VillageManager.manor_lvl == 2:
		$TownRepair/VBoxContainer/Church.visible = true
		$TownRepair/VBoxContainer/Tavern.visible = true
		$TownRepair/VBoxContainer/Weaponsmith.visible = true
		$TownRepair/VBoxContainer/Armourer.visible = true
		$TownRepair/VBoxContainer/Sorcerer.visible = true
		$TownRepair/VBoxContainer/TownSquare.visible = true
		$TownRepair/VBoxContainer/Farm.visible = true
		$TownRepair/VBoxContainer/Houses.visible = true
		$TownRepair/VBoxContainer/LeftWatchtower.visible = true
		$TownRepair/VBoxContainer/RightWatchtower.visible = true
	elif VillageManager.manor_lvl == 2:
		$TownRepair/VBoxContainer/Church.visible = true
		$TownRepair/VBoxContainer/Tavern.visible = true
		$TownRepair/VBoxContainer/Weaponsmith.visible = true
		$TownRepair/VBoxContainer/Armourer.visible = true
		$TownRepair/VBoxContainer/Sorcerer.visible = true
		$TownRepair/VBoxContainer/TownSquare.visible = true
		$TownRepair/VBoxContainer/Farm.visible = true
		$TownRepair/VBoxContainer/Houses.visible = true
		$TownRepair/VBoxContainer/LeftWatchtower.visible = true
		$TownRepair/VBoxContainer/RightWatchtower.visible = true
		$TownRepair/VBoxContainer/WoodcuttersCamp.visible = true
		$TownRepair/VBoxContainer/StoneMine.visible = true
		$TownRepair/VBoxContainer/IronMine.visible = true

#Manor repair
func _on_manor_pressed():
	if VillageManager.manor_lvl == 0:
		if check_enough_material(manor1_repair_price.x,manor1_repair_price.y,manor1_repair_price.z):
			process_cost(manor1_repair_price.x,manor1_repair_price.y,manor1_repair_price.z)
			VillageManager.manor_lvl = 1
			return
		else:
			not_enough()
	if VillageManager.manor_lvl == 1:
		if check_enough_material(manor2_repair_price.x,manor2_repair_price.y,manor2_repair_price.z):
			process_cost(manor2_repair_price.x,manor2_repair_price.y,manor2_repair_price.z)
			VillageManager.manor_lvl = 2
			return
		else:
			not_enough()
	if VillageManager.manor_lvl == 2:
		if check_enough_material(manor3_repair_price.x,manor3_repair_price.y,manor3_repair_price.z):
			process_cost(manor3_repair_price.x,manor3_repair_price.y,manor3_repair_price.z)
			VillageManager.manor_lvl = 3
			return
		else:
			not_enough()
func _on_manor_mouse_entered():
	if VillageManager.manor_lvl == 3:
		$Cost.visible = false
	elif VillageManager.manor_lvl == 0:
		$Cost.visible = true
		%Wood.text = str(manor1_repair_price.x)
		%Stone.text = str(manor1_repair_price.y)
		%Iron.text = str(manor1_repair_price.z)
		$Cost/Description.text = manor_repair_description
	elif VillageManager.manor_lvl == 1:
		$Cost.visible = true
		%Wood.text = str(manor2_repair_price.x)
		%Stone.text = str(manor2_repair_price.y)
		%Iron.text = str(manor2_repair_price.z)
		$Cost/Description.text = manor_repair_description
	elif VillageManager.manor_lvl == 2:
		$Cost.visible = true
		%Wood.text = str(manor3_repair_price.x)
		%Stone.text = str(manor3_repair_price.y)
		%Iron.text = str(manor3_repair_price.z)
		$Cost/Description.text = manor_repair_description
func _on_manor_mouse_exited():
	$Cost.visible = false

#Church repair
func _on_church_pressed():
	if check_enough_material(church_repair_price.x,church_repair_price.y,church_repair_price.z):
		process_cost(church_repair_price.x,church_repair_price.y,church_repair_price.z)
		VillageManager.church_repaired = true
	else:
		not_enough()
func _on_church_mouse_entered():
	if VillageManager.church_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(church_repair_price.x)
		%Stone.text = str(church_repair_price.y)
		%Iron.text = str(church_repair_price.z)
		$Cost/Description.text = church_repair_description
func _on_church_mouse_exited():
	$Cost.visible = false
	
#Tavern repair
func _on_tavern_pressed():
	if check_enough_material(tavern_repair_price.x,tavern_repair_price.y,tavern_repair_price.z):
		process_cost(tavern_repair_price.x,tavern_repair_price.y,tavern_repair_price.z)
		VillageManager.tavern_repaired = true
	else:
		not_enough()
func _on_tavern_mouse_entered():
	if VillageManager.tavern_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(tavern_repair_price.x)
		%Stone.text = str(tavern_repair_price.y)
		%Iron.text = str(tavern_repair_price.z)
		$Cost/Description.text = tavern_repair_description
func _on_tavern_mouse_exited():
	$Cost.visible = false

#Weaponsmith repair
func _on_weaponsmith_pressed():
	if check_enough_material(weaponsmith_repair_price.x,weaponsmith_repair_price.y,weaponsmith_repair_price.z):
		process_cost(weaponsmith_repair_price.x,weaponsmith_repair_price.y,weaponsmith_repair_price.z)
		VillageManager.weaponsmith_repaired = true
	else:
		not_enough()
func _on_weaponsmith_mouse_entered():
	if VillageManager.weaponsmith_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(weaponsmith_repair_price.x)
		%Stone.text = str(weaponsmith_repair_price.y)
		%Iron.text = str(weaponsmith_repair_price.z)
		$Cost/Description.text = weaponsmith_repair_description
func _on_weaponsmith_mouse_exited():
	$Cost.visible = false

#Armourer repair
func _on_armourer_pressed():
	if check_enough_material(armourer_repair_price.x,armourer_repair_price.y,armourer_repair_price.z):
		process_cost(armourer_repair_price.x,armourer_repair_price.y,armourer_repair_price.z)
		VillageManager.armourer_repaired = true
	else:
		not_enough()
func _on_armourer_mouse_entered():
	if VillageManager.armourer_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(armourer_repair_price.x)
		%Stone.text = str(armourer_repair_price.y)
		%Iron.text = str(armourer_repair_price.z)
		$Cost/Description.text = armourer_repair_description
func _on_armourer_mouse_exited():
	$Cost.visible = false

#Sorcerer repair
func _on_sorcerer_pressed():
	if check_enough_material(sorcerer_repair_price.x,sorcerer_repair_price.y,sorcerer_repair_price.z):
		process_cost(sorcerer_repair_price.x,sorcerer_repair_price.y,sorcerer_repair_price.z)
		VillageManager.sorcerer_repaired = true
	else:
		not_enough()
func _on_sorcerer_mouse_entered():
	if VillageManager.sorcerer_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(sorcerer_repair_price.x)
		%Stone.text = str(sorcerer_repair_price.y)
		%Iron.text = str(sorcerer_repair_price.z)
		$Cost/Description.text = sorcererh_repair_description
func _on_sorcerer_mouse_exited():
	$Cost.visible = false

#Town square repair
func _on_town_square_pressed():
	if check_enough_material(town_square_repair_price.x,town_square_repair_price.y,town_square_repair_price.z):
		process_cost(town_square_repair_price.x,town_square_repair_price.y,town_square_repair_price.z)
		VillageManager.town_square_repaired = true
	else:
		not_enough()
func _on_town_square_mouse_entered():
	if VillageManager.town_square_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(town_square_repair_price.x)
		%Stone.text = str(town_square_repair_price.y)
		%Iron.text = str(town_square_repair_price.z)
		$Cost/Description.text = town_square_repair_description
func _on_town_square_mouse_exited():
	$Cost.visible = false

#Farm repair
func _on_farm_pressed():
	if check_enough_material(farm_repair_price.x,farm_repair_price.y,farm_repair_price.z):
		process_cost(farm_repair_price.x,farm_repair_price.y,farm_repair_price.z)
		VillageManager.farm_repaired = true
	else:
		not_enough()
func _on_farm_mouse_entered():
	if VillageManager.farm_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(farm_repair_price.x)
		%Stone.text = str(farm_repair_price.y)
		%Iron.text = str(farm_repair_price.z)
		$Cost/Description.text = farm_repair_description
func _on_farm_mouse_exited():
	$Cost.visible = false

#Houses repair
func _on_houses_pressed():
	if check_enough_material(houses_repair_price.x,houses_repair_price.y,houses_repair_price.z):
		process_cost(houses_repair_price.x,houses_repair_price.y,houses_repair_price.z)
		VillageManager.houses_repaired = true
	else:
		not_enough()
func _on_houses_mouse_entered():
	if VillageManager.houses_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(houses_repair_price.x)
		%Stone.text = str(houses_repair_price.y)
		%Iron.text = str(houses_repair_price.z)
		$Cost/Description.text = houses_repair_description
func _on_houses_mouse_exited():
	$Cost.visible = false

#Left watchtower repair
func _on_left_watchtower_pressed():
	if check_enough_material(left_watchtower_repair_price.x,left_watchtower_repair_price.y,left_watchtower_repair_price.z):
		process_cost(left_watchtower_repair_price.x,left_watchtower_repair_price.y,left_watchtower_repair_price.z)
		VillageManager.left_watchtower_repaired = true
	else:
		not_enough()
func _on_left_watchtower_mouse_entered():
	if VillageManager.left_watchtower_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(left_watchtower_repair_price.x)
		%Stone.text = str(left_watchtower_repair_price.y)
		%Iron.text = str(left_watchtower_repair_price.z)
		$Cost/Description.text = left_watchtower_repair_description
func _on_left_watchtower_mouse_exited():
	$Cost.visible = false

#Right Watchtower
func _on_right_watchtower_pressed():
	if check_enough_material(right_watchtower_repair_price.x,right_watchtower_repair_price.y,right_watchtower_repair_price.z):
		process_cost(right_watchtower_repair_price.x,right_watchtower_repair_price.y,right_watchtower_repair_price.z)
		VillageManager.right_watchtower_repaired = true
	else:
		not_enough()
func _on_right_watchtower_mouse_entered():
	if VillageManager.right_watchtower_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(right_watchtower_repair_price.x)
		%Stone.text = str(right_watchtower_repair_price.y)
		%Iron.text = str(right_watchtower_repair_price.z)
		$Cost/Description.text = right_watchtower_repair_description
func _on_right_watchtower_mouse_exited():
	$Cost.visible = false

#Woodcutters camp build
func _on_woodcutters_camp_pressed():
	if check_enough_material(woodcutters_camp_repair_price.x,woodcutters_camp_repair_price.y,woodcutters_camp_repair_price.z):
		process_cost(woodcutters_camp_repair_price.x,woodcutters_camp_repair_price.y,woodcutters_camp_repair_price.z)
		VillageManager.woodcutters_camp_repaired = true
		VillageManager.wood_timer()
	else:
		not_enough()
func _on_woodcutters_camp_mouse_entered():
	if VillageManager.woodcutters_camp_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(woodcutters_camp_repair_price.x)
		%Stone.text = str(woodcutters_camp_repair_price.y)
		%Iron.text = str(woodcutters_camp_repair_price.z)
		$Cost/Description.text = woodcutters_camp_repair_description
func _on_woodcutters_camp_focus_exited():
	$Cost.visible = false

#Stone mine build
func _on_stone_mine_pressed():
	if check_enough_material(stone_mine_repair_price.x,stone_mine_repair_price.y,stone_mine_repair_price.z):
		process_cost(stone_mine_repair_price.x,stone_mine_repair_price.y,stone_mine_repair_price.z)
		VillageManager.stone_mine_repaired = true
		VillageManager.stone_timer()
	else:
		not_enough()
func _on_stone_mine_mouse_entered():
	if VillageManager.stone_mine_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(stone_mine_repair_price.x)
		%Stone.text = str(stone_mine_repair_price.y)
		%Iron.text = str(stone_mine_repair_price.z)
		$Cost/Description.text = stone_mine_repair_description
func _on_stone_mine_mouse_exited():
	$Cost.visible = false

#Iron mine build
func _on_iron_mine_pressed():
	if check_enough_material(iron_mine_repair_price.x,iron_mine_repair_price.y,iron_mine_repair_price.z):
		process_cost(iron_mine_repair_price.x,iron_mine_repair_price.y,iron_mine_repair_price.z)
		VillageManager.iron_mine_repaired = true
		VillageManager.iron_timer()
	else:
		not_enough()
func _on_iron_mine_mouse_entered():
	if VillageManager.iron_mine_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(iron_mine_repair_price.x)
		%Stone.text = str(iron_mine_repair_price.y)
		%Iron.text = str(iron_mine_repair_price.z)
		$Cost/Description.text = iron_mine_repair_description
func _on_iron_mine_mouse_exited():
	$Cost.visible = false

func update_text():
	$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Label.text = "Upgrade Weaponsmith lvl " + str(VillageManager.weaponsmith_lvl)
	if VillageManager.weaponsmith_lvl > 3:
		$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Label.text = "Upgrade Weaponsmith"


#############################################################################################################################
##Upgrades##

#Tavern upgrade
func _on_tavern_upgrade_pressed():
	pass # Replace with function body.
func _on_tavern_upgrade_mouse_entered():
	pass # Replace with function body.
func _on_tavern_upgrade_mouse_exited():
	pass # Replace with function body.

#Weaponsmith upgrade
func _on_weaponsmith_upgrade_pressed():
	pass # Replace with function body.
func _on_weaponsmith_upgrade_mouse_entered():
	pass # Replace with function body.
func _on_weaponsmith_upgrade_mouse_exited():
	pass # Replace with function body.

#Armourer upgrade
func _on_armourer_upgrade_pressed():
	pass # Replace with function body.
func _on_armourer_upgrade_mouse_entered():
	pass # Replace with function body.
func _on_armourer_upgrade_mouse_exited():
	pass # Replace with function body.

#Sorcere upgrade
func _on_sorcerer_upgrade_pressed():
	pass # Replace with function body.
func _on_sorcerer_upgrade_mouse_entered():
	pass # Replace with function body.
func _on_sorcerer_upgrade_mouse_exited():
	pass # Replace with function body.

#Woodcutters upgrade
func _on_woodcutters_upgrade_pressed():
	pass # Replace with function body.
func _on_woodcutters_upgrade_mouse_entered():
	pass # Replace with function body.
func _on_woodcutters_upgrade_mouse_exited():
	pass # Replace with function body.

#Stone mine upgrade
func _on_stone_mine_upgrade_pressed():
	pass # Replace with function body.
func _on_stone_mine_upgrade_mouse_entered():
	pass # Replace with function body.
func _on_stone_mine_upgrade_mouse_exited():
	pass # Replace with function body.

#Iron upgrade
func _on_iron_mine_upgrade_pressed():
	pass # Replace with function body.
func _on_iron_mine_upgrade_mouse_entered():
	pass # Replace with function body.
func _on_iron_mine_upgrade_mouse_exited():
	pass # Replace with function body.

#Rathaus upgrade
func _on_rathaus_upgrade_pressed():
	pass # Replace with function body.
func _on_rathaus_upgrade_mouse_entered():
	pass # Replace with function body.
func _on_rathaus_upgrade_mouse_exited():
	pass # Replace with function body.

#Farm upgrade
func _on_farm_upgrade_pressed():
	pass # Replace with function body.
func _on_farm_upgrade_mouse_entered():
	pass # Replace with function body.
func _on_farm_upgrade_mouse_exited():
	pass # Replace with function body.

#Lamp upgrade
func _on_lamps_upgrade_pressed():
	pass # Replace with function body.
func _on_lamps_upgrade_mouse_entered():
	pass # Replace with function body.
func _on_lamps_upgrade_mouse_exited():
	pass # Replace with function body.

#Campfire upgrade
func _on_campfire_upgrade_pressed():
	pass # Replace with function body.
func _on_campfire_upgrade_mouse_entered():
	pass # Replace with function body.
func _on_campfire_upgrade_mouse_exited():
	pass # Replace with function body.

#Houses upgrade
func _on_houses_upgrade_pressed():
	pass # Replace with function body.
func _on_houses_upgrade_mouse_entered():
	pass # Replace with function body.
func _on_houses_upgrade_mouse_exited():
	pass # Replace with function body.
