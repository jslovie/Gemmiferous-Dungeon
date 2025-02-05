extends Node2D



func _ready():
	SaveManager.load_savefile()
	update_treasures()
	update_materials()
	manor_ruin()
	%WoodTimer.start(VillageManager.wood_time_left)
	%StoneTimer.start(VillageManager.stone_time_left)
	%IronTimer.start(VillageManager.iron_time_left)
	
func _process(_delta):
	update_treasures()
	update_materials()
	woodcutters_timer()
	stone_mine_timer()
	iron_mine_timer()
	check_woodcutters_icon()
	check_stone_mine_icon()
	check_iron_mine_icon()
	
#Wood
func woodcutters_timer():
	VillageManager.wood_m = int(%WoodTimer.time_left / 60)
	VillageManager.wood_s = int(%WoodTimer.time_left) - VillageManager.wood_m * 60
	var time = "%02d:%02d" % [VillageManager.wood_m, VillageManager.wood_s]
	%WoodLabel.text = time
	VillageManager.wood_time_left = %WoodTimer.time_left
	
func woodcutters_timer_out():
	VillageManager.wood_time_left = 40
	%WoodTimer.start(VillageManager.wood_time_left)
	VillageManager.wood_collected += 1
	
func check_woodcutters_icon():
	if VillageManager.wood_collected > 0:
		$FacilityTimers/WoodTimer/WoodButton.visible = true
	else:
		$FacilityTimers/WoodTimer/WoodButton.visible = false

func collect_wood():
	PlayerManager.player.total_wood += VillageManager.wood_collected
	VillageManager.wood_collected = 0
	SaveManager.savefilesave()

#Stone
func stone_mine_timer():
	VillageManager.stone_m = int(%StoneTimer.time_left / 60)
	VillageManager.stone_s = int(%StoneTimer.time_left) - VillageManager.stone_m * 60
	var time = "%02d:%02d" % [VillageManager.stone_m, VillageManager.stone_s]
	%StoneLabel.text = time
	VillageManager.stone_time_left = %StoneTimer.time_left

func stone_mine_timer_out():
	VillageManager.stone_time_left = 40
	%StoneTimer.start(VillageManager.stone_time_left)
	VillageManager.stone_collected += 1
	
func check_stone_mine_icon():
	if VillageManager.stone_collected > 0:
		$FacilityTimers/StoneTimer/StoneButton.visible = true
	else:
		$FacilityTimers/StoneTimer/StoneButton.visible = false

func collect_stone():
	PlayerManager.player.total_stone += VillageManager.stone_collected
	VillageManager.stone_collected = 0
	SaveManager.savefilesave()

#Iron
func iron_mine_timer():
	VillageManager.iron_m = int(%IronTimer.time_left / 60)
	VillageManager.iron_s = int(%IronTimer.time_left) - VillageManager.iron_m * 60
	var time = "%02d:%02d" % [VillageManager.iron_m, VillageManager.iron_s]
	%IronLabel.text = time
	VillageManager.iron_time_left = %IronTimer.time_left

func iron_mine_timer_out():
	VillageManager.iron_time_left = 40
	%IronTimer.start(VillageManager.iron_time_left)
	VillageManager.iron_collected += 1
	
func check_iron_mine_icon():
	if VillageManager.iron_collected > 0:
		$FacilityTimers/IronTimer/IronButton.visible = true
	else:
		$FacilityTimers/IronTimer/IronButton.visible = false

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


func manor_ruin():
	$VillageTiles/Manor.texture_normal = load("res://assets/village/Castles/castle 07- ruin.png")
	$VillageTiles/Manor.texture_hover = load("res://assets/village/Castles/castle 07- ruin - highlighted.png")

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


func _on_wood_timer_timeout():
	woodcutters_timer_out()


func _on_wood_button_pressed():
	collect_wood()


func _on_stone_timer_timeout():
	stone_mine_timer_out()


func _on_stone_button_pressed():
	collect_stone()


func _on_iron_button_pressed():
	collect_iron()


func _on_iron_timer_timeout():
	iron_mine_timer_out()
