extends Node2D



func _ready():
	SaveManager.load_savefile()
	update_treasures()
	update_materials()
	manor_ruin()
	%WoodTimer.start(VillageManager.wood_time_left)

func _process(_delta):
	update_treasures()
	update_materials()
	woodcutters_timer()
	check_woodcutters_icon()

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
