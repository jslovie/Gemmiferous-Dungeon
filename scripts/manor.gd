extends Node2D

signal move_tween(name: String)

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
@export var weaponsmith1_upgrade_price : Vector3
@export var weaponsmith2_upgrade_price : Vector3
@export var armourer1_upgrade_price : Vector3
@export var armourer2_upgrade_price : Vector3
@export var sorcerer1_upgrade_price : Vector3
@export var sorcerer2_upgrade_price : Vector3
@export var woodcutters_camp1_upgrade_price : Vector3
@export var woodcutters_camp2_upgrade_price : Vector3
@export var woodcutters_camp3_upgrade_price : Vector3
@export var woodcutters_camp4_upgrade_price : Vector3
@export var stone_mine1_upgrade_price : Vector3
@export var stone_mine2_upgrade_price : Vector3
@export var stone_mine3_upgrade_price : Vector3
@export var stone_mine4_upgrade_price : Vector3
@export var iron_mine1_upgrade_price : Vector3
@export var iron_mine2_upgrade_price : Vector3
@export var iron_mine3_upgrade_price : Vector3
@export var iron_mine4_upgrade_price : Vector3
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

@onready var exit_shop = $ExitShop
@onready var enter_dungeon = $BookFrontPage/EnterDungeon
@onready var village_management = $BookFrontPage/VillageManagement
@onready var exit_shop_front_page = $BookFrontPage/ExitShopFrontPage


func _process(_delta):
	update_upgrade_text()
	update_checked()
	manor_button()
	check_manor_level()


func update_checked():
	if VillageManager.manor_lvl == 3 and VillageManager.houses_repaired == true:
		if LevelManager.is_demo == true:
			pass
		else:
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
		if LevelManager.is_demo == true:
			pass
		else:
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
		if LevelManager.is_demo == true:
			pass
		else:
			$TownUpgrades/VBoxContainer/RathausUpgrade.visible = true
	if VillageManager.farm_repaired == true:
		$TownRepair/VBoxContainer/Farm/Checked.visible = true
		$TownRepair/VBoxContainer/Farm.disabled = true
		if LevelManager.is_demo == true:
			pass
		else:
			$TownUpgrades/VBoxContainer/FarmUpgrade.visible = true
	if VillageManager.houses_repaired == true:
		$TownRepair/VBoxContainer/Houses/Checked.visible = true
		$TownRepair/VBoxContainer/Houses.disabled = true
	if VillageManager.left_watchtower_repaired == true:
		$TownRepair/VBoxContainer/LeftWatchtower/Checked.visible = true
		$TownRepair/VBoxContainer/LeftWatchtower.disabled = true
	if VillageManager.right_watchtower_repaired == true:
		$TownRepair/VBoxContainer/RightWatchtower/Checked.visible = true
		$TownRepair/VBoxContainer/RightWatchtower.disabled = true
	if VillageManager.woodcutters_camp_repaired == true:
		$TownRepair/VBoxContainer/WoodcuttersCamp/Checked.visible = true
		$TownRepair/VBoxContainer/WoodcuttersCamp.disabled = true
		if LevelManager.is_demo == true:
			pass
		else:
			$TownUpgrades/VBoxContainer/WoodcuttersUpgrade.visible = true
	if VillageManager.stone_mine_repaired == true:
		$TownRepair/VBoxContainer/StoneMine/Checked.visible = true
		$TownRepair/VBoxContainer/StoneMine.disabled = true
		if LevelManager.is_demo == true:
			pass
		else:
			$TownUpgrades/VBoxContainer/StoneMineUpgrade.visible = true
	if VillageManager.iron_mine_repaired == true:
		$TownRepair/VBoxContainer/IronMine/Checked.visible = true
		$TownRepair/VBoxContainer/IronMine.disabled = true
		if LevelManager.is_demo == true:
			pass
		else:
			$TownUpgrades/VBoxContainer/IronMineUpgrade.visible = true
	if VillageManager.tavern_lvl == 3:
		$TownUpgrades/VBoxContainer/TavernUpgrade/Checked.visible = true
		$TownUpgrades/VBoxContainer/TavernUpgrade.disabled = true
	if VillageManager.weaponsmith_lvl == 3:
		$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Checked.visible = true
		$TownUpgrades/VBoxContainer/WeaponsmithUpgrade.disabled = true
	if VillageManager.armourer_lvl == 3:
		$TownUpgrades/VBoxContainer/ArmourerUpgrade/Checked.visible = true
		$TownUpgrades/VBoxContainer/ArmourerUpgrade.disabled = true
	if VillageManager.sorcerer_lvl == 3:
		$TownUpgrades/VBoxContainer/SorcererUpgrade/Checked.visible = true
		$TownUpgrades/VBoxContainer/SorcererUpgrade.disabled = true
	if VillageManager.woodcutters_lvl == 5:
		$TownUpgrades/VBoxContainer/WoodcuttersUpgrade/Checked.visible = true
		$TownUpgrades/VBoxContainer/WoodcuttersUpgrade.disabled = true
	if VillageManager.stone_mine_lvl == 5:
		$TownUpgrades/VBoxContainer/StoneMineUpgrade/Checked.visible = true
		$TownUpgrades/VBoxContainer/StoneMineUpgrade.disabled = true
	if VillageManager.iron_mine_lvl == 5:
		$TownUpgrades/VBoxContainer/IronMineUpgrade/Checked.visible = true
		$TownUpgrades/VBoxContainer/IronMineUpgrade.disabled = true
	if VillageManager.rathaus_lvl == 3:
		$TownUpgrades/VBoxContainer/RathausUpgrade/Checked.visible = true
		$TownUpgrades/VBoxContainer/RathausUpgrade.disabled = true
	if VillageManager.farm_lvl == 3:
		$TownUpgrades/VBoxContainer/FarmUpgrade/Checked.visible = true
		$TownUpgrades/VBoxContainer/FarmUpgrade.disabled = true
	if VillageManager.campfire_built == true:
		$TownUpgrades/VBoxContainer/CampfireUpgrade/Checked.visible = true
		$TownUpgrades/VBoxContainer/CampfireUpgrade.disabled = true
	if VillageManager.lamps_built == true:
		$TownUpgrades/VBoxContainer/LampsUpgrade/Checked.visible = true
		$TownUpgrades/VBoxContainer/LampsUpgrade.disabled = true
	if VillageManager.build_houses == 4:
		$TownUpgrades/VBoxContainer/HousesUpgrade/Checked.visible = true
		$TownUpgrades/VBoxContainer/HousesUpgrade.disabled = true

func check_enough_material(wood,stone,iron):
	if PlayerManager.player.total_wood >= wood and PlayerManager.player.total_stone >= stone and PlayerManager.player.total_iron >= iron:
		return true
	else:
		return false

func not_enough():
	Sfx.play_SFX(Sfx.decline_book)
	$Cost/Description.visible = false
	$Cost/NotEnough.visible = true
	await get_tree().create_timer(1).timeout
	$Cost/Description.visible = true
	$Cost/NotEnough.visible = false

func process_cost(wood,stone,iron):
	Sfx.play_SFX(Sfx.confirm_book)
	PlayerManager.player.total_wood -= wood
	PlayerManager.player.total_stone -= stone
	PlayerManager.player.total_iron -= iron
	SaveManager.savefilesave()
	VillageHudMobile.update_village_hud_mobile()
	$Cost.visible = false


func _on_exit_shop_pressed():
	SaveManager.savefilesave()
	exit_door()

func _on_village_management_pressed():
	Sfx.play_SFX(Sfx.open_book)
	village_management_book()
	await get_tree().create_timer(0.5).timeout
	if LevelManager.is_mobile:
		get_parent().village_management_entered()

func _on_enter_dungeon_pressed():
	Sfx.play_SFX(Sfx.enter_dungeon)
	enter_dungeon_door()

func _on_exit_shop_front_page_pressed():
	exit_door_front_page()


func village_management_book():
	village_management.texture_normal = load("res://assets/32rogues/doors/book-opened.png")
	village_management.texture_hover = load("res://assets/32rogues/doors/book-opened.png")
	var tween = create_tween()
	tween.tween_property(village_management,"scale",Vector2(8,8),0.1)
	tween.tween_property(village_management,"scale",Vector2(7,7),0.1)
	await get_tree().create_timer(0.5).timeout
	$BookFrontPage.visible = false
	village_management.texture_normal = load("res://assets/32rogues/doors/book.png")
	village_management.texture_hover = load("res://assets/32rogues/doors/book-highlighted.png")
	
func enter_dungeon_door():
	VillageManager.in_shop = false
	LevelManager.in_village = false
	LevelManager.in_tutorial_level = false
	enter_dungeon.texture_normal = load("res://assets/32rogues/doors/cell-opened.png")
	enter_dungeon.texture_hover = load("res://assets/32rogues/doors/cell-opened.png")
	var tween = create_tween()
	tween.tween_property(enter_dungeon,"scale",Vector2(6,6),0.1)
	tween.tween_property(enter_dungeon,"scale",Vector2(5,5),0.1)
	await get_tree().create_timer(0.5).timeout
	SaveManager.savefilesave()
	LevelManager.reset()
	SaveManager.remove_resources()
	RelicManager.reset_pieces_relics()
	Transition.transition()
	await get_tree().create_timer(0.5).timeout
	if LevelManager.is_mobile:
		get_tree().change_scene_to_file("res://scenes/character_selection_mobile.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/character_selection.tscn")


func exit_door():
	Sfx.play_SFX(Sfx.door_close)
	exit_shop.texture_normal = load("res://assets/32rogues/doors/exitdoor-opened.png")
	exit_shop.texture_hover = load("res://assets/32rogues/doors/exitdoor-opened.png")
	var tween = create_tween()
	tween.tween_property(exit_shop,"scale",Vector2(4,4),0.1)
	tween.tween_property(exit_shop,"scale",Vector2(3,3),0.1)
	await get_tree().create_timer(0.5).timeout
	$BookFrontPage.visible = true
	exit_shop.texture_normal = load("res://assets/32rogues/doors/exitdoor.png")
	exit_shop.texture_hover = load("res://assets/32rogues/doors/exitdoor-highlighted.png")
	

func exit_door_front_page():
	Sfx.play_SFX(Sfx.manor_close)
	VillageManager.in_shop = false
	exit_shop_front_page.texture_normal = load("res://assets/32rogues/doors/exitdoor-opened.png")
	exit_shop_front_page.texture_hover = load("res://assets/32rogues/doors/exitdoor-opened.png")
	var tween = create_tween()
	tween.tween_property(exit_shop_front_page,"scale",Vector2(4,4),0.1)
	tween.tween_property(exit_shop_front_page,"scale",Vector2(3,3),0.1)
	await get_tree().create_timer(0.5).timeout
	emit_signal("move_tween","Manor")
	exit_shop_front_page.texture_normal = load("res://assets/32rogues/doors/exitdoor.png")
	exit_shop_front_page.texture_hover = load("res://assets/32rogues/doors/exitdoor-highlighted.png")

func manor_button():
	if VillageManager.manor_lvl == 0:
		$TownRepair/VBoxContainer/Manor/Label.text = "Repair Manor lvl 1"
	elif VillageManager.manor_lvl == 1:
		$TownRepair/VBoxContainer/Manor/Label.text = "Repair Manor lvl 2"
	elif VillageManager.manor_lvl == 2:
		$TownRepair/VBoxContainer/Manor/Label.text = "Repair Manor lvl 3"
	elif VillageManager.manor_lvl == 3:
		$TownRepair/VBoxContainer/Manor/Label.text = "Repair Manor"

func check_manor_level():
	if LevelManager.is_demo == true:
		if VillageManager.manor_lvl == 1:
			$TownRepair/VBoxContainer/Church.visible = true
			$TownRepair/VBoxContainer/Tavern.visible = true
			$TownRepair/VBoxContainer/Weaponsmith.visible = true
			$TownRepair/VBoxContainer/Armourer.visible = true
		elif VillageManager.manor_lvl == 2:
			$TownRepair/VBoxContainer/Church.visible = true
			$TownRepair/VBoxContainer/Tavern.visible = true
			$TownRepair/VBoxContainer/Weaponsmith.visible = true
			$TownRepair/VBoxContainer/Armourer.visible = true
			$TownRepair/VBoxContainer/TownSquare.visible = true
			$TownRepair/VBoxContainer/Farm.visible = true
			$TownRepair/VBoxContainer/Houses.visible = true
			$TownRepair/VBoxContainer/WoodcuttersCamp.visible = true
			$TownRepair/VBoxContainer/StoneMine.visible = true
			$TownRepair/VBoxContainer/IronMine.visible = true
		elif VillageManager.manor_lvl == 3:
			$TownRepair/VBoxContainer/Church.visible = true
			$TownRepair/VBoxContainer/Tavern.visible = true
			$TownRepair/VBoxContainer/Weaponsmith.visible = true
			$TownRepair/VBoxContainer/Armourer.visible = true
			$TownRepair/VBoxContainer/TownSquare.visible = true
			$TownRepair/VBoxContainer/Farm.visible = true
			$TownRepair/VBoxContainer/Houses.visible = true
			$TownRepair/VBoxContainer/WoodcuttersCamp.visible = true
			$TownRepair/VBoxContainer/StoneMine.visible = true
			$TownRepair/VBoxContainer/IronMine.visible = true
			
	else:
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
		elif VillageManager.manor_lvl == 3:
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
			_on_manor_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.manor_lvl == 1:
		if check_enough_material(manor2_repair_price.x,manor2_repair_price.y,manor2_repair_price.z):
			process_cost(manor2_repair_price.x,manor2_repair_price.y,manor2_repair_price.z)
			VillageManager.manor_lvl = 2
			_on_manor_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.manor_lvl == 2:
		if check_enough_material(manor3_repair_price.x,manor3_repair_price.y,manor3_repair_price.z):
			process_cost(manor3_repair_price.x,manor3_repair_price.y,manor3_repair_price.z)
			VillageManager.manor_lvl = 3
			_on_manor_mouse_entered()
			$TownRepair/VBoxContainer/Manor/Label.add_theme_color_override("font_color", Color.BLACK)
			return
		else:
			not_enough()
func _on_manor_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/Manor/Checked.visible == false:
		$TownRepair/VBoxContainer/Manor/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
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
	$TownRepair/VBoxContainer/Manor/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Church repair
func _on_church_pressed():
	if check_enough_material(church_repair_price.x,church_repair_price.y,church_repair_price.z):
		process_cost(church_repair_price.x,church_repair_price.y,church_repair_price.z)
		VillageManager.church_repaired = true
		$TownRepair/VBoxContainer/Church/Label.add_theme_color_override("font_color", Color.BLACK)
	else:
		not_enough()
func _on_church_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/Church/Checked.visible == false:
		$TownRepair/VBoxContainer/Church/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.church_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(church_repair_price.x)
		%Stone.text = str(church_repair_price.y)
		%Iron.text = str(church_repair_price.z)
		$Cost/Description.text = church_repair_description
func _on_church_mouse_exited():
	$TownRepair/VBoxContainer/Church/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false
	
#Tavern repair
func _on_tavern_pressed():
	if check_enough_material(tavern_repair_price.x,tavern_repair_price.y,tavern_repair_price.z):
		process_cost(tavern_repair_price.x,tavern_repair_price.y,tavern_repair_price.z)
		VillageManager.tavern_repaired = true
		$TownRepair/VBoxContainer/Tavern/Label.add_theme_color_override("font_color", Color.BLACK)
	else:
		not_enough()
func _on_tavern_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/Tavern/Checked.visible == false:
		$TownRepair/VBoxContainer/Tavern/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.tavern_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(tavern_repair_price.x)
		%Stone.text = str(tavern_repair_price.y)
		%Iron.text = str(tavern_repair_price.z)
		$Cost/Description.text = tavern_repair_description
func _on_tavern_mouse_exited():
	$TownRepair/VBoxContainer/Tavern/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Weaponsmith repair
func _on_weaponsmith_pressed():
	if check_enough_material(weaponsmith_repair_price.x,weaponsmith_repair_price.y,weaponsmith_repair_price.z):
		process_cost(weaponsmith_repair_price.x,weaponsmith_repair_price.y,weaponsmith_repair_price.z)
		VillageManager.weaponsmith_repaired = true
		$TownRepair/VBoxContainer/Weaponsmith/Label.add_theme_color_override("font_color", Color.BLACK)
	else:
		not_enough()
func _on_weaponsmith_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/Weaponsmith/Checked.visible == false:
		$TownRepair/VBoxContainer/Weaponsmith/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.weaponsmith_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(weaponsmith_repair_price.x)
		%Stone.text = str(weaponsmith_repair_price.y)
		%Iron.text = str(weaponsmith_repair_price.z)
		$Cost/Description.text = weaponsmith_repair_description
func _on_weaponsmith_mouse_exited():
	$TownRepair/VBoxContainer/Weaponsmith/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Armourer repair
func _on_armourer_pressed():
	if check_enough_material(armourer_repair_price.x,armourer_repair_price.y,armourer_repair_price.z):
		process_cost(armourer_repair_price.x,armourer_repair_price.y,armourer_repair_price.z)
		VillageManager.armourer_repaired = true
		$TownRepair/VBoxContainer/Armourer/Label.add_theme_color_override("font_color", Color.BLACK)
	else:
		not_enough()
func _on_armourer_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/Armourer/Checked.visible == false:
		$TownRepair/VBoxContainer/Armourer/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.armourer_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(armourer_repair_price.x)
		%Stone.text = str(armourer_repair_price.y)
		%Iron.text = str(armourer_repair_price.z)
		$Cost/Description.text = armourer_repair_description
func _on_armourer_mouse_exited():
	$TownRepair/VBoxContainer/Armourer/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Sorcerer repair
func _on_sorcerer_pressed():
	if check_enough_material(sorcerer_repair_price.x,sorcerer_repair_price.y,sorcerer_repair_price.z):
		process_cost(sorcerer_repair_price.x,sorcerer_repair_price.y,sorcerer_repair_price.z)
		VillageManager.sorcerer_repaired = true
		$TownRepair/VBoxContainer/Sorcerer/Label.add_theme_color_override("font_color", Color.BLACK)
	else:
		not_enough()
func _on_sorcerer_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/Sorcerer/Checked.visible == false:
		$TownRepair/VBoxContainer/Sorcerer/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.sorcerer_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(sorcerer_repair_price.x)
		%Stone.text = str(sorcerer_repair_price.y)
		%Iron.text = str(sorcerer_repair_price.z)
		$Cost/Description.text = sorcererh_repair_description
func _on_sorcerer_mouse_exited():
	$TownRepair/VBoxContainer/Sorcerer/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Town square repair
func _on_town_square_pressed():
	if check_enough_material(town_square_repair_price.x,town_square_repair_price.y,town_square_repair_price.z):
		process_cost(town_square_repair_price.x,town_square_repair_price.y,town_square_repair_price.z)
		VillageManager.town_square_repaired = true
		$TownRepair/VBoxContainer/TownSquare/Label.add_theme_color_override("font_color", Color.BLACK)
	else:
		not_enough()
func _on_town_square_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/TownSquare/Checked.visible == false:
		$TownRepair/VBoxContainer/TownSquare/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.town_square_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(town_square_repair_price.x)
		%Stone.text = str(town_square_repair_price.y)
		%Iron.text = str(town_square_repair_price.z)
		$Cost/Description.text = town_square_repair_description
func _on_town_square_mouse_exited():
	$TownRepair/VBoxContainer/TownSquare/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Farm repair
func _on_farm_pressed():
	if check_enough_material(farm_repair_price.x,farm_repair_price.y,farm_repair_price.z):
		process_cost(farm_repair_price.x,farm_repair_price.y,farm_repair_price.z)
		VillageManager.farm_repaired = true
		$TownRepair/VBoxContainer/Farm/Label.add_theme_color_override("font_color", Color.BLACK)
	else:
		not_enough()
func _on_farm_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/Farm/Checked.visible == false:
		$TownRepair/VBoxContainer/Farm/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.farm_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(farm_repair_price.x)
		%Stone.text = str(farm_repair_price.y)
		%Iron.text = str(farm_repair_price.z)
		$Cost/Description.text = farm_repair_description
func _on_farm_mouse_exited():
	$TownRepair/VBoxContainer/Farm/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Houses repair
func _on_houses_pressed():
	if check_enough_material(houses_repair_price.x,houses_repair_price.y,houses_repair_price.z):
		process_cost(houses_repair_price.x,houses_repair_price.y,houses_repair_price.z)
		VillageManager.houses_repaired = true
		$TownRepair/VBoxContainer/Houses/Label.add_theme_color_override("font_color", Color.BLACK)
	else:
		not_enough()
func _on_houses_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/Houses/Checked.visible == false:
		$TownRepair/VBoxContainer/Houses/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.houses_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(houses_repair_price.x)
		%Stone.text = str(houses_repair_price.y)
		%Iron.text = str(houses_repair_price.z)
		$Cost/Description.text = houses_repair_description
func _on_houses_mouse_exited():
	$TownRepair/VBoxContainer/Houses/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Left watchtower repair
func _on_left_watchtower_pressed():
	if check_enough_material(left_watchtower_repair_price.x,left_watchtower_repair_price.y,left_watchtower_repair_price.z):
		process_cost(left_watchtower_repair_price.x,left_watchtower_repair_price.y,left_watchtower_repair_price.z)
		VillageManager.left_watchtower_repaired = true
		$TownRepair/VBoxContainer/LeftWatchtower/Label.add_theme_color_override("font_color", Color.BLACK)
	else:
		not_enough()
func _on_left_watchtower_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/LeftWatchtower/Checked.visible == false:
		$TownRepair/VBoxContainer/LeftWatchtower/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.left_watchtower_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(left_watchtower_repair_price.x)
		%Stone.text = str(left_watchtower_repair_price.y)
		%Iron.text = str(left_watchtower_repair_price.z)
		$Cost/Description.text = left_watchtower_repair_description
func _on_left_watchtower_mouse_exited():
	$TownRepair/VBoxContainer/LeftWatchtower/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Right Watchtower
func _on_right_watchtower_pressed():
	if check_enough_material(right_watchtower_repair_price.x,right_watchtower_repair_price.y,right_watchtower_repair_price.z):
		process_cost(right_watchtower_repair_price.x,right_watchtower_repair_price.y,right_watchtower_repair_price.z)
		VillageManager.right_watchtower_repaired = true
		$TownRepair/VBoxContainer/RightWatchtower/Label.add_theme_color_override("font_color", Color.BLACK)
	else:
		not_enough()
func _on_right_watchtower_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/RightWatchtower/Checked.visible == false:
		$TownRepair/VBoxContainer/RightWatchtower/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.right_watchtower_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(right_watchtower_repair_price.x)
		%Stone.text = str(right_watchtower_repair_price.y)
		%Iron.text = str(right_watchtower_repair_price.z)
		$Cost/Description.text = right_watchtower_repair_description
func _on_right_watchtower_mouse_exited():
	$TownRepair/VBoxContainer/RightWatchtower/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Woodcutters camp build
func _on_woodcutters_camp_pressed():
	if check_enough_material(woodcutters_camp_repair_price.x,woodcutters_camp_repair_price.y,woodcutters_camp_repair_price.z):
		process_cost(woodcutters_camp_repair_price.x,woodcutters_camp_repair_price.y,woodcutters_camp_repair_price.z)
		VillageManager.woodcutters_camp_repaired = true
		$TownRepair/VBoxContainer/WoodcuttersCamp/Label.add_theme_color_override("font_color", Color.BLACK)
		VillageManager.wood_timer()
	else:
		not_enough()
func _on_woodcutters_camp_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/WoodcuttersCamp/Checked.visible == false:
		$TownRepair/VBoxContainer/WoodcuttersCamp/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.woodcutters_camp_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(woodcutters_camp_repair_price.x)
		%Stone.text = str(woodcutters_camp_repair_price.y)
		%Iron.text = str(woodcutters_camp_repair_price.z)
		$Cost/Description.text = woodcutters_camp_repair_description
		
func _on_woodcutters_camp_mouse_exited():
	$TownRepair/VBoxContainer/WoodcuttersCamp/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Stone mine build
func _on_stone_mine_pressed():
	if check_enough_material(stone_mine_repair_price.x,stone_mine_repair_price.y,stone_mine_repair_price.z):
		process_cost(stone_mine_repair_price.x,stone_mine_repair_price.y,stone_mine_repair_price.z)
		VillageManager.stone_mine_repaired = true
		$TownRepair/VBoxContainer/StoneMine/Label.add_theme_color_override("font_color", Color.BLACK)
		VillageManager.stone_timer()
	else:
		not_enough()
func _on_stone_mine_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/StoneMine/Checked.visible == false:
		$TownRepair/VBoxContainer/StoneMine/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.stone_mine_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(stone_mine_repair_price.x)
		%Stone.text = str(stone_mine_repair_price.y)
		%Iron.text = str(stone_mine_repair_price.z)
		$Cost/Description.text = stone_mine_repair_description
func _on_stone_mine_mouse_exited():
	$TownRepair/VBoxContainer/StoneMine/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Iron mine build
func _on_iron_mine_pressed():
	if check_enough_material(iron_mine_repair_price.x,iron_mine_repair_price.y,iron_mine_repair_price.z):
		process_cost(iron_mine_repair_price.x,iron_mine_repair_price.y,iron_mine_repair_price.z)
		VillageManager.iron_mine_repaired = true
		$TownRepair/VBoxContainer/IronMine/Label.add_theme_color_override("font_color", Color.BLACK)
		VillageManager.iron_timer()
	else:
		not_enough()
func _on_iron_mine_mouse_entered():
	if $BookFrontPage.visible == false and $TownRepair/VBoxContainer/IronMine/Checked.visible == false:
		$TownRepair/VBoxContainer/IronMine/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.iron_mine_repaired == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(iron_mine_repair_price.x)
		%Stone.text = str(iron_mine_repair_price.y)
		%Iron.text = str(iron_mine_repair_price.z)
		$Cost/Description.text = iron_mine_repair_description
func _on_iron_mine_mouse_exited():
	$TownRepair/VBoxContainer/IronMine/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false


#############################################################################################################################
##Upgrades##

func update_upgrade_text():
	$TownUpgrades/VBoxContainer/TavernUpgrade/Label.text = "Upgrade Tavern to lvl " + str(VillageManager.tavern_lvl + 1)
	if VillageManager.tavern_lvl == 3:
		$TownUpgrades/VBoxContainer/TavernUpgrade/Label.text = "Upgrade Tavern"
		
	$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Label.text = "Upgrade Weaponsmith to lvl " + str(VillageManager.weaponsmith_lvl + 1)
	if VillageManager.weaponsmith_lvl == 3:
		$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Label.text = "Upgrade Weaponsmith"
		
	$TownUpgrades/VBoxContainer/ArmourerUpgrade/Label.text = "Upgrade Armourer to lvl " + str(VillageManager.armourer_lvl + 1)
	if VillageManager.armourer_lvl == 3:
		$TownUpgrades/VBoxContainer/ArmourerUpgrade/Label.text = "Upgrade Armourer"
		
	$TownUpgrades/VBoxContainer/SorcererUpgrade/Label.text = "Upgrade Sorcerer to lvl " + str(VillageManager.sorcerer_lvl + 1)
	if VillageManager.sorcerer_lvl == 3:
		$TownUpgrades/VBoxContainer/SorcererUpgrade/Label.text = "Upgrade Sorcerer"
	
	$TownUpgrades/VBoxContainer/WoodcuttersUpgrade/Label.text = "Upgrade Woodcutters to lvl " + str(VillageManager.woodcutters_lvl + 1)
	if VillageManager.woodcutters_lvl == 5:
		$TownUpgrades/VBoxContainer/WoodcuttersUpgrade/Label.text = "Upgrade Woodcutters"
	
	$TownUpgrades/VBoxContainer/StoneMineUpgrade/Label.text = "Upgrade Stone mine to lvl " + str(VillageManager.stone_mine_lvl + 1)
	if VillageManager.stone_mine_lvl == 5:
		$TownUpgrades/VBoxContainer/StoneMineUpgrade/Label.text = "Upgrade Stone mine"
	
	$TownUpgrades/VBoxContainer/IronMineUpgrade/Label.text = "Upgrade Irone mine to lvl " + str(VillageManager.iron_mine_lvl + 1)
	if VillageManager.iron_mine_lvl == 5:
		$TownUpgrades/VBoxContainer/IronMineUpgrade/Label.text = "Upgrade Irone mine"
		
	$TownUpgrades/VBoxContainer/RathausUpgrade/Label.text = "Upgrade Rathaus to lvl " + str(VillageManager.rathaus_lvl + 1)
	if VillageManager.rathaus_lvl == 3:
		$TownUpgrades/VBoxContainer/RathausUpgrade/Label.text = "Upgrade Rathaus"
		
	$TownUpgrades/VBoxContainer/FarmUpgrade/Label.text = "Upgrade Farm to lvl " + str(VillageManager.farm_lvl + 1)
	if VillageManager.farm_lvl == 3:
		$TownUpgrades/VBoxContainer/FarmUpgrade/Label.text = "Upgrade Farm"
	
	$TownUpgrades/VBoxContainer/HousesUpgrade/Label.text = "Build new Houses lvl " + str(VillageManager.build_houses)
	if VillageManager.build_houses == 4:
		$TownUpgrades/VBoxContainer/HousesUpgrade/Label.text = "Build new Houses"

#Tavern upgrade
func _on_tavern_upgrade_pressed():
	if VillageManager.tavern_lvl == 1:
		if check_enough_material(tavern1_upgrade_price.x,tavern1_upgrade_price.y,tavern1_upgrade_price.z):
			process_cost(tavern1_upgrade_price.x,tavern1_upgrade_price.y,tavern1_upgrade_price.z)
			VillageManager.tavern_lvl = 2
			SaveManager.savefilesave()
			_on_tavern_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.tavern_lvl == 2:
		if check_enough_material(tavern2_upgrade_price.x,tavern2_upgrade_price.y,tavern2_upgrade_price.z):
			process_cost(tavern2_upgrade_price.x,tavern2_upgrade_price.y,tavern2_upgrade_price.z)
			VillageManager.tavern_lvl = 3
			SaveManager.savefilesave()
			_on_tavern_upgrade_mouse_entered()
			$TownUpgrades/VBoxContainer/TavernUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
			return
		else:
			not_enough()
func _on_tavern_upgrade_mouse_entered():
	if $BookFrontPage.visible == false and $TownUpgrades/VBoxContainer/TavernUpgrade/Checked.visible == false:
		$TownUpgrades/VBoxContainer/TavernUpgrade/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.tavern_lvl == 3:
		$Cost.visible = false
	elif VillageManager.tavern_lvl == 1:
		$Cost.visible = true
		%Wood.text = str(tavern1_upgrade_price.x)
		%Stone.text = str(tavern1_upgrade_price.y)
		%Iron.text = str(tavern1_upgrade_price.z)
		$Cost/Description.text = "Upgrade tavern to level 2 and access new upgrades"
	elif VillageManager.tavern_lvl == 2:
		$Cost.visible = true
		%Wood.text = str(tavern2_upgrade_price.x)
		%Stone.text = str(tavern2_upgrade_price.y)
		%Iron.text = str(tavern2_upgrade_price.z)
		$Cost/Description.text = "Upgrade tavern to level 3 and access new upgrades"
func _on_tavern_upgrade_mouse_exited():
	$TownUpgrades/VBoxContainer/TavernUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Weaponsmith upgrade
func _on_weaponsmith_upgrade_pressed():
	if VillageManager.weaponsmith_lvl == 1:
		if check_enough_material(weaponsmith1_upgrade_price.x,weaponsmith1_upgrade_price.y,weaponsmith1_upgrade_price.z):
			process_cost(weaponsmith1_upgrade_price.x,weaponsmith1_upgrade_price.y,weaponsmith1_upgrade_price.z)
			VillageManager.weaponsmith_lvl = 2
			SaveManager.savefilesave()
			_on_weaponsmith_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.weaponsmith_lvl == 2:
		if check_enough_material(weaponsmith2_upgrade_price.x,weaponsmith2_upgrade_price.y,weaponsmith2_upgrade_price.z):
			process_cost(weaponsmith2_upgrade_price.x,weaponsmith2_upgrade_price.y,weaponsmith2_upgrade_price.z)
			VillageManager.weaponsmith_lvl = 3
			SaveManager.savefilesave()
			_on_weaponsmith_upgrade_mouse_entered()
			$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
			return
		else:
			not_enough()
func _on_weaponsmith_upgrade_mouse_entered():
	if $BookFrontPage.visible == false and $TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Checked.visible == false:
		$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.weaponsmith_lvl == 3:
		$Cost.visible = false
	elif VillageManager.weaponsmith_lvl == 1:
		$Cost.visible = true
		%Wood.text = str(weaponsmith1_upgrade_price.x)
		%Stone.text = str(weaponsmith1_upgrade_price.y)
		%Iron.text = str(weaponsmith1_upgrade_price.z)
		$Cost/Description.text = "Upgrade weaponsmith shop to level 2 and access new upgrades"
	elif VillageManager.weaponsmith_lvl == 2:
		$Cost.visible = true
		%Wood.text = str(weaponsmith2_upgrade_price.x)
		%Stone.text = str(weaponsmith2_upgrade_price.y)
		%Iron.text = str(weaponsmith2_upgrade_price.z)
		$Cost/Description.text = "Upgrade weaponsmith shop to level 3 and access new upgrades"
func _on_weaponsmith_upgrade_mouse_exited():
	$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Armourer upgrade
func _on_armourer_upgrade_pressed():
	if VillageManager.armourer_lvl == 1:
		if check_enough_material(armourer1_upgrade_price.x,armourer1_upgrade_price.y,armourer1_upgrade_price.z):
			process_cost(armourer1_upgrade_price.x,armourer1_upgrade_price.y,armourer1_upgrade_price.z)
			VillageManager.armourer_lvl = 2
			SaveManager.savefilesave()
			_on_armourer_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.armourer_lvl == 2:
		if check_enough_material(armourer2_upgrade_price.x,armourer2_upgrade_price.y,armourer2_upgrade_price.z):
			process_cost(armourer2_upgrade_price.x,armourer2_upgrade_price.y,armourer2_upgrade_price.z)
			VillageManager.armourer_lvl = 3
			SaveManager.savefilesave()
			_on_armourer_upgrade_mouse_entered()
			$TownUpgrades/VBoxContainer/ArmourerUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
			return
		else:
			not_enough()
func _on_armourer_upgrade_mouse_entered():
	if $BookFrontPage.visible == false and $TownUpgrades/VBoxContainer/ArmourerUpgrade/Checked.visible == false:
		$TownUpgrades/VBoxContainer/ArmourerUpgrade/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.armourer_lvl == 3:
		$Cost.visible = false
	elif VillageManager.armourer_lvl == 1:
		$Cost.visible = true
		%Wood.text = str(armourer1_upgrade_price.x)
		%Stone.text = str(armourer1_upgrade_price.y)
		%Iron.text = str(armourer1_upgrade_price.z)
		$Cost/Description.text = "Upgrade armourer shop to level 2 and access new upgrades"
	elif VillageManager.armourer_lvl == 2:
		$Cost.visible = true
		%Wood.text = str(armourer2_upgrade_price.x)
		%Stone.text = str(armourer2_upgrade_price.y)
		%Iron.text = str(armourer2_upgrade_price.z)
		$Cost/Description.text = "Upgrade armourer shop to level 3 and access new upgrades"
func _on_armourer_upgrade_mouse_exited():
	$TownUpgrades/VBoxContainer/ArmourerUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Sorcere upgrade
func _on_sorcerer_upgrade_pressed():
	if VillageManager.sorcerer_lvl == 1:
		if check_enough_material(sorcerer1_upgrade_price.x,sorcerer1_upgrade_price.y,sorcerer1_upgrade_price.z):
			process_cost(sorcerer1_upgrade_price.x,sorcerer1_upgrade_price.y,sorcerer1_upgrade_price.z)
			VillageManager.sorcerer_lvl = 2
			SaveManager.savefilesave()
			_on_sorcerer_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.sorcerer_lvl == 2:
		if check_enough_material(sorcerer2_upgrade_price.x,sorcerer2_upgrade_price.y,sorcerer2_upgrade_price.z):
			process_cost(sorcerer2_upgrade_price.x,sorcerer2_upgrade_price.y,sorcerer2_upgrade_price.z)
			VillageManager.sorcerer_lvl = 3
			SaveManager.savefilesave()
			_on_sorcerer_upgrade_mouse_entered()
			$TownUpgrades/VBoxContainer/SorcererUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
			return
		else:
			not_enough()
func _on_sorcerer_upgrade_mouse_entered():
	if $BookFrontPage.visible == false and $TownUpgrades/VBoxContainer/SorcererUpgrade/Checked.visible == false:
		$TownUpgrades/VBoxContainer/SorcererUpgrade/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.sorcerer_lvl == 3:
		$Cost.visible = false
	elif VillageManager.sorcerer_lvl == 1:
		$Cost.visible = true
		%Wood.text = str(sorcerer1_upgrade_price.x)
		%Stone.text = str(sorcerer1_upgrade_price.y)
		%Iron.text = str(sorcerer1_upgrade_price.z)
		$Cost/Description.text = "Upgrade sorcerer shop to level 2 and access new upgrades"
	elif VillageManager.sorcerer_lvl == 2:
		$Cost.visible = true
		%Wood.text = str(sorcerer2_upgrade_price.x)
		%Stone.text = str(sorcerer2_upgrade_price.y)
		%Iron.text = str(sorcerer2_upgrade_price.z)
		$Cost/Description.text = "Upgrade sorcerer shop to level 3 and access new upgrades"
func _on_sorcerer_upgrade_mouse_exited():
	$TownUpgrades/VBoxContainer/SorcererUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Woodcutters upgrade
func _on_woodcutters_upgrade_pressed():
	if VillageManager.woodcutters_lvl == 1:
		if check_enough_material(woodcutters_camp1_upgrade_price.x,woodcutters_camp1_upgrade_price.y,woodcutters_camp1_upgrade_price.z):
			process_cost(woodcutters_camp1_upgrade_price.x,woodcutters_camp1_upgrade_price.y,woodcutters_camp1_upgrade_price.z)
			VillageManager.woodcutters_lvl = 2
			SaveManager.savefilesave()
			_on_woodcutters_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.woodcutters_lvl == 2:
		if check_enough_material(woodcutters_camp2_upgrade_price.x,woodcutters_camp2_upgrade_price.y,woodcutters_camp2_upgrade_price.z):
			process_cost(woodcutters_camp2_upgrade_price.x,woodcutters_camp2_upgrade_price.y,woodcutters_camp2_upgrade_price.z)
			VillageManager.woodcutters_lvl = 3
			SaveManager.savefilesave()
			_on_woodcutters_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.woodcutters_lvl == 3:
		if check_enough_material(woodcutters_camp3_upgrade_price.x,woodcutters_camp3_upgrade_price.y,woodcutters_camp3_upgrade_price.z):
			process_cost(woodcutters_camp3_upgrade_price.x,woodcutters_camp3_upgrade_price.y,woodcutters_camp3_upgrade_price.z)
			VillageManager.woodcutters_lvl = 4
			SaveManager.savefilesave()
			_on_woodcutters_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.woodcutters_lvl == 4:
		if check_enough_material(woodcutters_camp4_upgrade_price.x,woodcutters_camp4_upgrade_price.y,woodcutters_camp4_upgrade_price.z):
			process_cost(woodcutters_camp4_upgrade_price.x,woodcutters_camp4_upgrade_price.y,woodcutters_camp4_upgrade_price.z)
			VillageManager.woodcutters_lvl = 5
			SaveManager.savefilesave()
			_on_woodcutters_upgrade_mouse_entered()
			$TownUpgrades/VBoxContainer/WoodcuttersUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
			return
		else:
			not_enough()
func _on_woodcutters_upgrade_mouse_entered():
	if $BookFrontPage.visible == false and $TownUpgrades/VBoxContainer/WoodcuttersUpgrade/Checked.visible == false:
		$TownUpgrades/VBoxContainer/WoodcuttersUpgrade/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.woodcutters_lvl == 5:
		$Cost.visible = false
	elif VillageManager.woodcutters_lvl == 1:
		$Cost.visible = true
		%Wood.text = str(woodcutters_camp1_upgrade_price.x)
		%Stone.text = str(woodcutters_camp1_upgrade_price.y)
		%Iron.text = str(woodcutters_camp1_upgrade_price.z)
		$Cost/Description.text = "Upgrade woodcutters camp to level 2 to increase production"
	elif VillageManager.woodcutters_lvl == 2:
		$Cost.visible = true
		%Wood.text = str(woodcutters_camp2_upgrade_price.x)
		%Stone.text = str(woodcutters_camp2_upgrade_price.y)
		%Iron.text = str(woodcutters_camp2_upgrade_price.z)
		$Cost/Description.text = "Upgrade woodcutters camp to level 3 to increase production"
	elif VillageManager.woodcutters_lvl == 3:
		$Cost.visible = true
		%Wood.text = str(woodcutters_camp3_upgrade_price.x)
		%Stone.text = str(woodcutters_camp3_upgrade_price.y)
		%Iron.text = str(woodcutters_camp3_upgrade_price.z)
		$Cost/Description.text = "Upgrade woodcutters camp to level 4 to increase production"	
	elif VillageManager.woodcutters_lvl == 4:
		$Cost.visible = true
		%Wood.text = str(woodcutters_camp4_upgrade_price.x)
		%Stone.text = str(woodcutters_camp4_upgrade_price.y)
		%Iron.text = str(woodcutters_camp4_upgrade_price.z)
		$Cost/Description.text = "Upgrade woodcutters camp to level 5 to increase production"	
func _on_woodcutters_upgrade_mouse_exited():
	$TownUpgrades/VBoxContainer/WoodcuttersUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Stone mine upgrade
func _on_stone_mine_upgrade_pressed():
	if VillageManager.stone_mine_lvl == 1:
		if check_enough_material(stone_mine1_upgrade_price.x,stone_mine1_upgrade_price.y,stone_mine1_upgrade_price.z):
			process_cost(stone_mine1_upgrade_price.x,stone_mine1_upgrade_price.y,stone_mine1_upgrade_price.z)
			VillageManager.stone_mine_lvl = 2
			SaveManager.savefilesave()
			_on_stone_mine_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.stone_mine_lvl == 2:
		if check_enough_material(stone_mine2_upgrade_price.x,stone_mine2_upgrade_price.y,stone_mine2_upgrade_price.z):
			process_cost(stone_mine2_upgrade_price.x,stone_mine2_upgrade_price.y,stone_mine2_upgrade_price.z)
			VillageManager.stone_mine_lvl = 3
			SaveManager.savefilesave()
			_on_stone_mine_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.stone_mine_lvl == 3:
		if check_enough_material(stone_mine3_upgrade_price.x,stone_mine3_upgrade_price.y,stone_mine3_upgrade_price.z):
			process_cost(stone_mine3_upgrade_price.x,stone_mine3_upgrade_price.y,stone_mine3_upgrade_price.z)
			VillageManager.stone_mine_lvl = 4
			SaveManager.savefilesave()
			_on_stone_mine_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.stone_mine_lvl == 4:
		if check_enough_material(stone_mine4_upgrade_price.x,stone_mine4_upgrade_price.y,stone_mine4_upgrade_price.z):
			process_cost(stone_mine4_upgrade_price.x,stone_mine4_upgrade_price.y,stone_mine4_upgrade_price.z)
			VillageManager.stone_mine_lvl = 5
			SaveManager.savefilesave()
			_on_stone_mine_upgrade_mouse_entered()
			$TownUpgrades/VBoxContainer/StoneMineUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
			return
		else:
			not_enough()
func _on_stone_mine_upgrade_mouse_entered():
	if $BookFrontPage.visible == false and $TownUpgrades/VBoxContainer/StoneMineUpgrade/Checked.visible == false:
		$TownUpgrades/VBoxContainer/StoneMineUpgrade/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.stone_mine_lvl == 5:
		$Cost.visible = false
	elif VillageManager.stone_mine_lvl == 1:
		$Cost.visible = true
		%Wood.text = str(stone_mine1_upgrade_price.x)
		%Stone.text = str(stone_mine1_upgrade_price.y)
		%Iron.text = str(stone_mine1_upgrade_price.z)
		$Cost/Description.text = "Upgrade stone mine to level 2 to increase production"
	elif VillageManager.stone_mine_lvl == 2:
		$Cost.visible = true
		%Wood.text = str(stone_mine2_upgrade_price.x)
		%Stone.text = str(stone_mine2_upgrade_price.y)
		%Iron.text = str(stone_mine2_upgrade_price.z)
		$Cost/Description.text = "Upgrade stone mine to level 3 to increase production"
	elif VillageManager.stone_mine_lvl == 3:
		$Cost.visible = true
		%Wood.text = str(stone_mine3_upgrade_price.x)
		%Stone.text = str(stone_mine3_upgrade_price.y)
		%Iron.text = str(stone_mine3_upgrade_price.z)
		$Cost/Description.text = "Upgrade stone mine to level 4 to increase production"	
	elif VillageManager.stone_mine_lvl == 4:
		$Cost.visible = true
		%Wood.text = str(stone_mine4_upgrade_price.x)
		%Stone.text = str(stone_mine4_upgrade_price.y)
		%Iron.text = str(stone_mine4_upgrade_price.z)
		$Cost/Description.text = "Upgrade stone mine to level 5 to increase production"	
func _on_stone_mine_upgrade_mouse_exited():
	$TownUpgrades/VBoxContainer/StoneMineUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Iron upgrade
func _on_iron_mine_upgrade_pressed():
	if VillageManager.iron_mine_lvl == 1:
		if check_enough_material(iron_mine1_upgrade_price.x,iron_mine1_upgrade_price.y,iron_mine1_upgrade_price.z):
			process_cost(iron_mine1_upgrade_price.x,iron_mine1_upgrade_price.y,iron_mine1_upgrade_price.z)
			VillageManager.iron_mine_lvl = 2
			SaveManager.savefilesave()
			_on_iron_mine_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.iron_mine_lvl == 2:
		if check_enough_material(iron_mine2_upgrade_price.x,iron_mine2_upgrade_price.y,iron_mine2_upgrade_price.z):
			process_cost(iron_mine2_upgrade_price.x,iron_mine2_upgrade_price.y,iron_mine2_upgrade_price.z)
			VillageManager.iron_mine_lvl = 3
			SaveManager.savefilesave()
			_on_iron_mine_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.iron_mine_lvl == 3:
		if check_enough_material(iron_mine3_upgrade_price.x,iron_mine3_upgrade_price.y,iron_mine3_upgrade_price.z):
			process_cost(iron_mine3_upgrade_price.x,iron_mine3_upgrade_price.y,iron_mine3_upgrade_price.z)
			VillageManager.iron_mine_lvl = 4
			SaveManager.savefilesave()
			_on_iron_mine_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.iron_mine_lvl == 4:
		if check_enough_material(iron_mine4_upgrade_price.x,iron_mine4_upgrade_price.y,iron_mine4_upgrade_price.z):
			process_cost(iron_mine4_upgrade_price.x,iron_mine4_upgrade_price.y,iron_mine4_upgrade_price.z)
			VillageManager.iron_mine_lvl = 5
			SaveManager.savefilesave()
			_on_iron_mine_upgrade_mouse_entered()
			$TownUpgrades/VBoxContainer/IronMineUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
			return
		else:
			not_enough()
func _on_iron_mine_upgrade_mouse_entered():
	if $BookFrontPage.visible == false and $TownUpgrades/VBoxContainer/IronMineUpgrade/Checked.visible == false:
		$TownUpgrades/VBoxContainer/IronMineUpgrade/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.iron_mine_lvl == 5:
		$Cost.visible = false
	elif VillageManager.iron_mine_lvl == 1:
		$Cost.visible = true
		%Wood.text = str(iron_mine1_upgrade_price.x)
		%Stone.text = str(iron_mine1_upgrade_price.y)
		%Iron.text = str(iron_mine1_upgrade_price.z)
		$Cost/Description.text = "Upgrade iron mine to level 2 to increase production"
	elif VillageManager.iron_mine_lvl == 2:
		$Cost.visible = true
		%Wood.text = str(iron_mine2_upgrade_price.x)
		%Stone.text = str(iron_mine2_upgrade_price.y)
		%Iron.text = str(iron_mine2_upgrade_price.z)
		$Cost/Description.text = "Upgrade iron mine to level 3 to increase production"
	elif VillageManager.iron_mine_lvl == 3:
		$Cost.visible = true
		%Wood.text = str(iron_mine3_upgrade_price.x)
		%Stone.text = str(iron_mine3_upgrade_price.y)
		%Iron.text = str(iron_mine3_upgrade_price.z)
		$Cost/Description.text = "Upgrade iron mine to level 4 to increase production"	
	elif VillageManager.iron_mine_lvl == 4:
		$Cost.visible = true
		%Wood.text = str(iron_mine4_upgrade_price.x)
		%Stone.text = str(iron_mine4_upgrade_price.y)
		%Iron.text = str(iron_mine4_upgrade_price.z)
		$Cost/Description.text = "Upgrade iron mine to level 5 to increase production"	
func _on_iron_mine_upgrade_mouse_exited():
	$TownUpgrades/VBoxContainer/IronMineUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Rathaus upgrade
func _on_rathaus_upgrade_pressed():
	if VillageManager.rathaus_lvl == 1:
		if check_enough_material(rathaus1_upgrade_price.x,rathaus1_upgrade_price.y,rathaus1_upgrade_price.z):
			process_cost(rathaus1_upgrade_price.x,rathaus1_upgrade_price.y,rathaus1_upgrade_price.z)
			VillageManager.rathaus_lvl = 2
			SaveManager.savefilesave()
			_on_rathaus_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.rathaus_lvl == 2:
		if check_enough_material(rathaus2_upgrade_price.x,rathaus2_upgrade_price.y,rathaus2_upgrade_price.z):
			process_cost(rathaus2_upgrade_price.x,rathaus2_upgrade_price.y,rathaus2_upgrade_price.z)
			VillageManager.rathaus_lvl = 3
			SaveManager.savefilesave()
			_on_rathaus_upgrade_mouse_entered()
			$TownUpgrades/VBoxContainer/RathausUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
			return
		else:
			not_enough()
func _on_rathaus_upgrade_mouse_entered():
	if $BookFrontPage.visible == false and $TownUpgrades/VBoxContainer/RathausUpgrade/Checked.visible == false:
		$TownUpgrades/VBoxContainer/RathausUpgrade/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.rathaus_lvl == 3:
		$Cost.visible = false
	elif VillageManager.rathaus_lvl == 1:
		$Cost.visible = true
		%Wood.text = str(rathaus1_upgrade_price.x)
		%Stone.text = str(rathaus1_upgrade_price.y)
		%Iron.text = str(rathaus1_upgrade_price.z)
		$Cost/Description.text = "Upgrade rathaus to level 2 increase taxes"
	elif VillageManager.rathaus_lvl == 2:
		$Cost.visible = true
		%Wood.text = str(rathaus2_upgrade_price.x)
		%Stone.text = str(rathaus2_upgrade_price.y)
		%Iron.text = str(rathaus2_upgrade_price.z)
		$Cost/Description.text = "Upgrade rathaus to level 3 increase taxes"
func _on_rathaus_upgrade_mouse_exited():
	$TownUpgrades/VBoxContainer/RathausUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Farm upgrade
func _on_farm_upgrade_pressed():
	if VillageManager.farm_lvl == 1:
		if check_enough_material(farm1_upgrade_price.x,farm1_upgrade_price.y,farm1_upgrade_price.z):
			process_cost(farm1_upgrade_price.x,farm1_upgrade_price.y,farm1_upgrade_price.z)
			VillageManager.farm_lvl = 2
			SaveManager.savefilesave()
			_on_farm_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.farm_lvl == 2:
		if check_enough_material(farm2_upgrade_price.x,farm2_upgrade_price.y,farm2_upgrade_price.z):
			process_cost(farm2_upgrade_price.x,farm2_upgrade_price.y,farm2_upgrade_price.z)
			VillageManager.farm_lvl = 3
			SaveManager.savefilesave()
			_on_farm_upgrade_mouse_entered()
			$TownUpgrades/VBoxContainer/FarmUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
			return
		else:
			not_enough()
func _on_farm_upgrade_mouse_entered():
	if $BookFrontPage.visible == false and $TownUpgrades/VBoxContainer/FarmUpgrade/Checked.visible == false:
		$TownUpgrades/VBoxContainer/FarmUpgrade/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.farm_lvl == 3:
		$Cost.visible = false
	elif VillageManager.farm_lvl == 1:
		$Cost.visible = true
		%Wood.text = str(farm1_upgrade_price.x)
		%Stone.text = str(farm1_upgrade_price.y)
		%Iron.text = str(farm1_upgrade_price.z)
		$Cost/Description.text = "Upgrade farm to level 2 increase production"
	elif VillageManager.farm_lvl == 2:
		$Cost.visible = true
		%Wood.text = str(farm2_upgrade_price.x)
		%Stone.text = str(farm2_upgrade_price.y)
		%Iron.text = str(farm2_upgrade_price.z)
		$Cost/Description.text = "Upgrade farm to level 3 increase production"
func _on_farm_upgrade_mouse_exited():
	$TownUpgrades/VBoxContainer/FarmUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Lamp upgrade
func _on_lamps_upgrade_pressed():
	if check_enough_material(lamp_upgrade_price.x,lamp_upgrade_price.y,lamp_upgrade_price.z):
		process_cost(lamp_upgrade_price.x,lamp_upgrade_price.y,lamp_upgrade_price.z)
		VillageManager.lamps_built = true
		$TownUpgrades/VBoxContainer/LampsUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	else:
		not_enough()
func _on_lamps_upgrade_mouse_entered():
	if $BookFrontPage.visible == false and $TownUpgrades/VBoxContainer/LampsUpgrade/Checked.visible == false:
		$TownUpgrades/VBoxContainer/LampsUpgrade/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.lamps_built == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(lamp_upgrade_price.x)
		%Stone.text = str(lamp_upgrade_price.y)
		%Iron.text = str(lamp_upgrade_price.z)
		$Cost/Description.text = "Bring more light and happiness to your village"
func _on_lamps_upgrade_mouse_exited():
	$TownUpgrades/VBoxContainer/LampsUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false

#Campfire upgrade
func _on_campfire_upgrade_pressed():
	if check_enough_material(campfire_upgrade_price.x,campfire_upgrade_price.y,campfire_upgrade_price.z):
		process_cost(campfire_upgrade_price.x,campfire_upgrade_price.y,campfire_upgrade_price.z)
		VillageManager.campfire_built = true
		$TownUpgrades/VBoxContainer/CampfireUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	else:
		not_enough()
func _on_campfire_upgrade_mouse_entered():
	if $BookFrontPage.visible == false and $TownUpgrades/VBoxContainer/CampfireUpgrade/Checked.visible == false:
		$TownUpgrades/VBoxContainer/CampfireUpgrade/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.campfire_built == true:
		$Cost.visible = false
	else:
		$Cost.visible = true
		%Wood.text = str(campfire_upgrade_price.x)
		%Stone.text = str(campfire_upgrade_price.y)
		%Iron.text = str(campfire_upgrade_price.z)
		$Cost/Description.text = "Build campfire for your villagers to gather around"
func _on_campfire_upgrade_mouse_exited():
	$TownUpgrades/VBoxContainer/CampfireUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false
	
#Houses upgrade
func _on_houses_upgrade_pressed():
	if VillageManager.build_houses == 0:
		if check_enough_material(houses1_upgrade_price.x,houses1_upgrade_price.y,houses1_upgrade_price.z):
			process_cost(houses1_upgrade_price.x,houses1_upgrade_price.y,houses1_upgrade_price.z)
			VillageManager.build_houses = 1
			SaveManager.savefilesave()
			_on_houses_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.build_houses == 1:
		if check_enough_material(houses2_upgrade_price.x,houses2_upgrade_price.y,houses2_upgrade_price.z):
			process_cost(houses2_upgrade_price.x,houses2_upgrade_price.y,houses2_upgrade_price.z)
			VillageManager.build_houses = 2
			SaveManager.savefilesave()
			_on_houses_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.build_houses == 2:
		if check_enough_material(houses3_upgrade_price.x,houses3_upgrade_price.y,houses3_upgrade_price.z):
			process_cost(houses3_upgrade_price.x,houses3_upgrade_price.y,houses3_upgrade_price.z)
			VillageManager.build_houses = 3
			SaveManager.savefilesave()
			_on_houses_upgrade_mouse_entered()
			return
		else:
			not_enough()
	if VillageManager.build_houses == 3:
		if check_enough_material(houses4_upgrade_price.x,houses4_upgrade_price.y,houses4_upgrade_price.z):
			process_cost(houses4_upgrade_price.x,houses4_upgrade_price.y,houses4_upgrade_price.z)
			VillageManager.build_houses = 4
			SaveManager.savefilesave()
			_on_houses_upgrade_mouse_entered()
			$TownUpgrades/VBoxContainer/HousesUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
			return
		else:
			not_enough()
func _on_houses_upgrade_mouse_entered():
	if $BookFrontPage.visible == false and $TownUpgrades/VBoxContainer/HousesUpgrade/Checked.visible == false:
		$TownUpgrades/VBoxContainer/HousesUpgrade/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
		Sfx.play_SFX(Sfx.book_hover)
	if VillageManager.build_houses == 4:
		$Cost.visible = false
	elif VillageManager.build_houses == 0:
		$Cost.visible = true
		%Wood.text = str(houses1_upgrade_price.x)
		%Stone.text = str(houses1_upgrade_price.y)
		%Iron.text = str(houses1_upgrade_price.z)
		$Cost/Description.text = "Build new houses for your villagers"
	elif VillageManager.build_houses == 1:
		$Cost.visible = true
		%Wood.text = str(houses2_upgrade_price.x)
		%Stone.text = str(houses2_upgrade_price.y)
		%Iron.text = str(houses2_upgrade_price.z)
		$Cost/Description.text = "Build new houses for your villagers"	
	elif VillageManager.build_houses == 2:
		$Cost.visible = true
		%Wood.text = str(houses3_upgrade_price.x)
		%Stone.text = str(houses3_upgrade_price.y)
		%Iron.text = str(houses3_upgrade_price.z)
		$Cost/Description.text = "Build new houses for your villagers"	
	elif VillageManager.build_houses == 3:
		$Cost.visible = true
		%Wood.text = str(houses4_upgrade_price.x)
		%Stone.text = str(houses4_upgrade_price.y)
		%Iron.text = str(houses4_upgrade_price.z)
		$Cost/Description.text = "Build new houses for your villagers"	
func _on_houses_upgrade_mouse_exited():
	$TownUpgrades/VBoxContainer/HousesUpgrade/Label.add_theme_color_override("font_color", Color.BLACK)
	$Cost.visible = false


func _on_enter_dungeon_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
func _on_village_management_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
func _on_exit_shop_front_page_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
