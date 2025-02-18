extends Node2D

@export var church_repair_price : Vector3
@export var tavern_repair_price : Vector3
@export var weaponsmith_repair_price : Vector3
@export var armourer_repair_price : Vector3
@export var sorcerer_repair_price : Vector3
@export var town_square_repair_price : Vector3
@export var farm_repair_price : Vector3
@export var houses_repair_price : Vector3
@export var left_watchtower_repair_price : Vector3
@export var right_watchtower_repair_price : Vector3
@export var woodcutters_camp_repair_price : Vector3
@export var stone_mine_repair_price : Vector3
@export var iron_mine_repair_price : Vector3

func _process(delta):
	update_text()
	update_buttons()

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

func _on_enter_the_dungeon_pressed():
	get_tree().change_scene_to_file("res://scenes/character_selection.tscn")

func _on_exit_shop_pressed():
	visible = false


func _on_weaponsmith_upgrade_pressed():
	VillageManager.weaponsmith_lvl += 1


#Church
func _on_church_pressed():
	if check_enough_material(church_repair_price.x,church_repair_price.y,church_repair_price.z):
		process_cost(church_repair_price.x,church_repair_price.y,church_repair_price.z)
		VillageManager.church_repaired = true
		$Cost.visible = false
		$TownRepair/VBoxContainer/Church.disabled = true
		$TownRepair/VBoxContainer/Church/Checked.visible = true
		print("has enough")
		print(PlayerManager.player.total_iron)
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
		$Cost/Description.text = "Get your people some place to pray"
func _on_church_mouse_exited():
	$Cost.visible = false
	
#Tavern
func _on_tavern_pressed():
	if check_enough_material(tavern_repair_price.x,tavern_repair_price.y,tavern_repair_price.z):
		process_cost(tavern_repair_price.x,tavern_repair_price.y,tavern_repair_price.z)
		


func _on_tavern_mouse_entered():
	pass # Replace with function body.


func _on_tavern_mouse_exited():
	pass # Replace with function body.
