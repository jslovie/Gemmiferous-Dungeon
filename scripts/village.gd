extends Node2D



func _ready():
	SaveManager.load_savefile()
	update_treasures()
	update_materials()
	

	
func _process(_delta):
	update_facility_timers()
	update_treasures()
	update_materials()
	check_woodcutters_icon()
	check_stone_mine_icon()
	check_iron_mine_icon()
	
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
