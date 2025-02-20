extends Node2D

#Repairs
@export var Manor1_repair_price : Vector3
@export var Manor2_repair_price : Vector3
@export var Manor3_repair_price : Vector3
@export var Manor_repair_description : String
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


func _process(delta):
	update_text()
	update_buttons()
	update_checked()

func update_checked():
	if VillageManager.church_repaired == true:
		$TownRepair/VBoxContainer/Church/Checked.visible = true
	if VillageManager.tavern_repaired == true:
		$TownRepair/VBoxContainer/Tavern/Checked.visible = true
	if VillageManager.weaponsmith_repaired == true:
		$TownRepair/VBoxContainer/Weaponsmith/Checked.visible = true
	if VillageManager.armourer_repaired == true:
		$TownRepair/VBoxContainer/Armourer/Checked.visible = true
	if VillageManager.sorcerer_repaired == true:
		$TownRepair/VBoxContainer/Sorcerer/Checked.visible = true
	if VillageManager.town_square_repaired == true:
		$TownRepair/VBoxContainer/TownSquare/Checked.visible = true
	if VillageManager.farm_repaired == true:
		$TownRepair/VBoxContainer/Farm/Checked.visible = true
	if VillageManager.houses_repaired == true:
		$TownRepair/VBoxContainer/Houses/Checked.visible = true
	if VillageManager.left_watchtower_repaired == true:
		$TownRepair/VBoxContainer/LeftWatchtower/Checked.visible = true
	if VillageManager.right_watchtower_repaired == true:
		$TownRepair/VBoxContainer/RightWatchtower/Checked.visible = true
	if VillageManager.woodcutters_camp_repaired == true:
		$TownRepair/VBoxContainer/WoodcuttersCamp/Checked.visible = true
	if VillageManager.stone_mine_repaired == true:
		$TownRepair/VBoxContainer/StoneMine/Checked.visible = true
	if VillageManager.iron_mine_repaired == true:
		$TownRepair/VBoxContainer/IronMine/Checked.visible = true

func update_text():
	$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Label.text = "Upgrade Weaponsmith lvl " + str(VillageManager.weaponsmith_lvl)
	if VillageManager.weaponsmith_lvl > 3:
		$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Label.text = "Upgrade Weaponsmith"

func update_buttons():
	if VillageManager.weaponsmith_lvl > 3:
		$TownUpgrades/VBoxContainer/WeaponsmithUpgrade.disabled
		$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Checked.visible = true

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


func _on_weaponsmith_upgrade_pressed():
	VillageManager.weaponsmith_lvl += 1

#Manor repair
func _on_manor_pressed():
	if VillageManager.manor_lvl == 0:
		if check_enough_material(church_repair_price.x,church_repair_price.y,church_repair_price.z):
			process_cost(church_repair_price.x,church_repair_price.y,church_repair_price.z)
			VillageManager.church_repaired = true
		else:
			not_enough()
	
	
	
	
	
func _on_manor_mouse_entered():
	pass # Replace with function body.
func _on_manor_mouse_exited():
	pass # Replace with function body.


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
