extends Node2D



func _ready():
	SaveManager.load_savefile()
	update_treasures()
	update_materials()
	repair_estate()

	
func _process(_delta):
	update_facility_timers()
	update_treasures()
	update_materials()
	check_woodcutters_icon()
	check_stone_mine_icon()
	check_iron_mine_icon()

func repair_estate():
	$VillageTiles/Manor.texture_normal = load("res://assets/village/Gemmiferous_estate/manor.png")
	$VillageTiles/Manor.texture_hover = load("res://assets/village/Gemmiferous_estate/manor_highlighted.png")
	$VillageTiles/Sorcerer.texture_normal = load("res://assets/village/Gemmiferous_estate/sorcerer.png")
	$VillageTiles/Sorcerer.texture_hover = load("res://assets/village/Gemmiferous_estate/sorcerer_highlight.png")
	$VillageTiles/Shops/IronMine.visible = true
	$VillageTiles/Shops/Woodcutters.visible = true
	$VillageTiles/Shops/StoneMine.visible = true
	$VillageTiles/Camp.visible = true
	$VillageTiles/Bonfire.visible = true
	$VillageTiles/Houses/Hauses.texture = load("res://assets/village/Gemmiferous_estate/houses.png")
	$VillageTiles/Houses/Square.texture = load("res://assets/village/Gemmiferous_estate/Square.png")
	$VillageTiles/Houses/DoubleHouses.visible = true
	$VillageTiles/Houses/House.visible = true
	$VillageTiles/Houses/BigHouse.visible = true
	$VillageTiles/Houses/House2.visible = true
	$VillageTiles/Houses/House3.visible = true
	$VillageTiles/Houses/House4.visible = true
	$VillageTiles/Houses/House5.visible = true
	$VillageTiles/Houses/House6.visible = true
	$VillageTiles/Houses/DoubleHouses2.visible = true
	$VillageTiles/Farm/Mill.texture = load("res://assets/village/Gemmiferous_estate/mill.png")
	$VillageTiles/Farm/Warehouse.texture = load("res://assets/village/Gemmiferous_estate/warehouse.png")
	$VillageTiles/GuardTowers/Watchtower1.texture = load("res://assets/village/Gemmiferous_estate/watchtower_1.png")
	$VillageTiles/GuardTowers/Watchtower2.texture = load("res://assets/village/Gemmiferous_estate/watchtower_2.png")
	$VillageTiles/Farm/Field1.visible = true
	$VillageTiles/Farm/Field2.visible = true
	$VillageTiles/Farm/Field3.visible = true
	$VillageTiles/Lamps.visible = true
	$VillageTiles/Shops/Church.texture_normal = load("res://assets/village/Gemmiferous_estate/church 2.png")
	$VillageTiles/Shops/Church.texture_hover = load("res://assets/village/Gemmiferous_estate/church 2=highlighted.png")
	$VillageTiles/Shops/Taverm.texture_normal = load("res://assets/village/Gemmiferous_estate/tavern.png")
	$VillageTiles/Shops/Taverm.texture_hover = load("res://assets/village/Gemmiferous_estate/tavern_highlighted.png")
	$VillageTiles/Shops/Weaponsmith.texture_normal = load("res://assets/village/Gemmiferous_estate/weaponsmith.png")
	$VillageTiles/Shops/Weaponsmith.texture_hover = load("res://assets/village/Gemmiferous_estate/weaponsmith_highlighted.png")
	$VillageTiles/Shops/Armourer.texture_normal = load("res://assets/village/Gemmiferous_estate/armourer.png")
	$VillageTiles/Shops/Armourer.texture_hover = load("res://assets/village/Gemmiferous_estate/armourer_highlighted.png")

func update_facility_timers():
	%WoodLabel.text = '%02d:%02d' % [VillageManager.wood_m, VillageManager.wood_s]
	%StoneLabel.text = '%02d:%02d' % [VillageManager.stone_m, VillageManager.stone_s]
	%IronLabel.text = '%02d:%02d' % [VillageManager.iron_m, VillageManager.iron_s]
	
func check_woodcutters_icon():
	if VillageManager.wood_collected > 0:
		$Facilities/WoodButton.visible = true
	else:
		$Facilities/WoodButton.visible = false

func collect_wood():
	PlayerManager.player.total_wood += VillageManager.wood_collected
	VillageManager.wood_collected = 0
	SaveManager.savefilesave()

func check_stone_mine_icon():
	if VillageManager.stone_collected > 0:
		$Facilities/StoneButton.visible = true
	else:
		$Facilities/StoneButton.visible = false

func collect_stone():
	PlayerManager.player.total_stone += VillageManager.stone_collected
	VillageManager.stone_collected = 0
	SaveManager.savefilesave()

func check_iron_mine_icon():
	if VillageManager.iron_collected > 0:
		$Facilities/IronButton.visible = true
	else:
		$Facilities/IronButton.visible = false

func collect_iron():
	PlayerManager.player.total_iron += VillageManager.iron_collected
	VillageManager.iron_collected = 0
	SaveManager.savefilesave()


func update_treasures():
	$GemStats/Control/RedLabel.text = ": " + str(PlayerManager.player.total_red_gem)
	$GemStats/Control/BlueLabel.text = ": " + str(PlayerManager.player.total_blue_gem)
	$GemStats/Control/GreenLabel.text = ": " + str(PlayerManager.player.total_green_gem)
	$GemStats/Control/YellowLabel.text = ": " + str(PlayerManager.player.total_yellow_gem)
	$GemStats/Control/CoinsLabel.text = ": " + str(PlayerManager.player.total_coins)
	
func update_materials():
	$Material/WoodLabel.text = ": " + str(PlayerManager.player.total_wood)
	$Material/StoneLabel.text = ": " + str(PlayerManager.player.total_stone)
	$Material/IronLabel.text = ": " + str(PlayerManager.player.total_iron)

func _on_manor_pressed():
	get_tree().change_scene_to_file("res://scenes/character_selection.tscn")


func _on_taverm_pressed():
	SaveManager.load_savefile()
	$TavernShop.visible = true


func _on_weaponsmith_pressed():
	SaveManager.load_savefile()
	$WeaponsmithShop.visible = true


func _on_armourer_pressed():
	SaveManager.load_savefile()
	$ArmourerShop.visible = true


func _on_wood_button_pressed():
	collect_wood()

func _on_stone_button_pressed():
	collect_stone()

func _on_iron_button_pressed():
	collect_iron()
