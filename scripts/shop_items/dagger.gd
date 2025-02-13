extends TextureButton


var description = "Damage: 1-4"
var item = "Dagger"

func _ready():
	item_set()

func effect():
	var tween = create_tween()
	tween.tween_property($ItemPicture, "scale", Vector2(4,4), 0.1)
	tween.tween_property($ItemPicture, "scale", Vector2(3,3), 0.1)

func not_enough():
	$NotEnough/NotEnoughLabel.visible = true
	await get_tree().create_timer(1).timeout
	$NotEnough/NotEnoughLabel.visible = false

func item_set():
	$ItemDescription.text = description
	$ItemNameLvl.text = str(item) + " Lvl " + str(VillageManager.sword_item_lvl)

func item_data_save():
	VillageManager.sword_item_lvl += 1
	SaveManager.savefilesave()
	SaveManager.load_savefile()

func item_level_UP():
	if VillageManager.sword_item_lvl == 1 and VillageManager.weaponsmith_lvl >= 1:
		if PlayerManager.player.total_coins < 25 or PlayerManager.player.total_red_gem < 10:
			not_enough()
		else:
			PlayerManager.player.upgraded_sword_damage = PlayerManager.player.upgraded_sword_damage + Vector2(1,0)
			PlayerManager.player.total_coins -= 25
			PlayerManager.player.total_red_gem -= 10
			item_data_save()
	elif VillageManager.sword_item_lvl == 2 and VillageManager.weaponsmith_lvl >= 1:
		if PlayerManager.player.total_coins < 50 or PlayerManager.player.total_red_gem < 15:
			not_enough()
		else:
			PlayerManager.player.upgraded_sword_damage = PlayerManager.player.upgraded_sword_damage + Vector2(1,2)
			PlayerManager.player.total_coins -= 50
			PlayerManager.player.total_blue_gem -= 15
			item_data_save()
	elif VillageManager.sword_item_lvl == 3 and VillageManager.weaponsmith_lvl >= 2:
		if PlayerManager.player.total_coins < 75 or PlayerManager.player.total_red_gem < 30:
			not_enough()
		else:
			PlayerManager.player.upgraded_sword_damage = PlayerManager.player.upgraded_sword_damage + Vector2(1,1)
			PlayerManager.player.total_coins -= 75
			PlayerManager.player.total_green_gem -= 30
			item_data_save()
	elif VillageManager.sword_item_lvl == 4 and VillageManager.weaponsmith_lvl >= 2:
		if PlayerManager.player.total_coins < 95 or PlayerManager.player.total_red_gem < 50:
			not_enough()
		else:
			PlayerManager.player.upgraded_sword_damage = PlayerManager.player.upgraded_sword_damage + Vector2(0,2)
			PlayerManager.player.total_coins -= 95
			PlayerManager.player.total_yellow_gem -= 50
			item_data_save()
	elif VillageManager.sword_item_lvl == 5 and VillageManager.weaponsmith_lvl >= 3:
		if PlayerManager.player.total_coins < 150 or PlayerManager.player.total_red_gem < 75:
			not_enough()
		else:
			PlayerManager.player.upgraded_sword_damage = PlayerManager.player.upgraded_sword_damage + Vector2(2,0)
			PlayerManager.player.total_coins -= 150
			PlayerManager.player.total_red_gem -= 75
			item_data_save()
	else:
		$LowLevel/LowLevelLabel.visible = true
		await get_tree().create_timer(1).timeout
		$LowLevel/LowLevelLabel.visible = false

func _on_mouse_entered():
	$Price.visible = true
	if VillageManager.sword_item_lvl == 1:
		$ItemDescription.text = "Damage: 3-4"
		$Price/CoinsLabel.text = ": 25"
		$Price/Gems.texture = load("res://assets/32rogues/gems/red.png")
		$Price/GemsLabel.text = ": 10"
	elif VillageManager.sword_item_lvl == 2:
		$ItemDescription.text = "Damage: 4-6"
		$Price/CoinsLabel.text = ": 50"
		$Price/Gems.texture = load("res://assets/32rogues/gems/blue.png")
		$Price/GemsLabel.text = ": 15"
	elif VillageManager.sword_item_lvl == 3:
		$ItemDescription.text = "Damage: 5-7"
		$Price/CoinsLabel.text = ": 75"
		$Price/Gems.texture = load("res://assets/32rogues/gems/green.png")
		$Price/GemsLabel.text = ": 30"
	elif VillageManager.sword_item_lvl == 4:
		$ItemDescription.text = "Damage: 5-9"
		$Price/CoinsLabel.text = ": 95"
		$Price/Gems.texture = load("res://assets/32rogues/gems/yellow.png")
		$Price/GemsLabel.text = ": 50"
	elif VillageManager.sword_item_lvl == 5:
		$ItemDescription.text = "Damage: 7-9"
		$Price/CoinsLabel.text = ": 150"
		$Price/Gems.texture = load("res://assets/32rogues/gems/red.png")
		$Price/GemsLabel.text = ": 75"
		
	$ItemNameLvl.text = str(item) + " Lvl " + str(VillageManager.sword_item_lvl + 1)

func _on_mouse_exited():
	$Price.visible = false
	$ItemDescription.text = description
	$ItemNameLvl.text = str(item) + " Lvl " + str(VillageManager.sword_item_lvl)

func _on_pressed():
	effect()
	item_level_UP()
	_on_mouse_entered()
