extends TextureButton

@export var upgrade_set : ItemUpgrade

var item_lvl
var upgraded_amount

func _ready():
	await get_tree().create_timer(1).timeout
	set_item()
	item_set()

	
func set_item():

	if upgrade_set.item == "Initial Shield":
		item_lvl = VillageManager.shield_init_lvl
		upgraded_amount = PlayerManager.player.upgraded_shield_init
	elif upgrade_set.item == "Shield Load":
		item_lvl = VillageManager.shield_load_lvl
		upgraded_amount = PlayerManager.player.upgraded_shield_load
	elif upgrade_set.item == "Max Shield":
		item_lvl = VillageManager.shield_max_lvl
		upgraded_amount = PlayerManager.player.upgraded_shield_max

func effect():
	var tween = create_tween()
	tween.tween_property($ItemPicture, "scale", Vector2(4,4), 0.1)
	tween.tween_property($ItemPicture, "scale", Vector2(3,3), 0.1)

func not_enough():
	Sfx.play_SFX(Sfx.upgrade_deny)
	$NotEnough/NotEnoughLabel.visible = true
	await get_tree().create_timer(1).timeout
	$NotEnough/NotEnoughLabel.visible = false

func item_set():
	if item_lvl == 1:
		upgraded_amount = upgrade_set.origin_value
		$ItemNameLvl.text = str(upgrade_set.item) + " Lvl " + str(item_lvl)
		$ItemDescription.text = str(upgrade_set.origin_value) + str(upgrade_set.description)
	elif item_lvl == 6:
		$ItemNameLvl.text = str(upgrade_set.item) + " Lvl Max"
		$ItemDescription.text = str(upgrade_set.origin_value + upgraded_amount) + str(upgrade_set.description)
	else:
		$ItemNameLvl.text = str(upgrade_set.item) + " Lvl " + str(item_lvl)
		$ItemDescription.text = str(upgrade_set.origin_value + upgraded_amount) + str(upgrade_set.description)



func item_data_save():
	Sfx.play_SFX(Sfx.upgrade)
	item_lvl += 1

	if upgrade_set.item == "Initial Shield":
		VillageManager.shield_init_lvl = item_lvl
	elif upgrade_set.item == "Shield Load":
		VillageManager.shield_load_lvl = item_lvl
	elif upgrade_set.item == "Max Shield":
		VillageManager.shield_max_lvl = item_lvl
		
	SaveManager.savefilesave()
	#SaveManager.load_savefile()

func process_gem(gem_texture, price_gem_lvl):
	if gem_texture == "Red":
		PlayerManager.player.total_red_gem -= price_gem_lvl
	elif gem_texture == "Blue":
		PlayerManager.player.total_blue_gem -= price_gem_lvl
	elif gem_texture == "Green":
		PlayerManager.player.total_green_gem -= price_gem_lvl
	elif gem_texture == "Yellow":
		PlayerManager.player.total_yellow_gem -= price_gem_lvl
	VillageHudMobile.update_village_hud_mobile()
	
func check_enough(gem_color, gem_price, coin_price):
	if PlayerManager.player.total_coins < coin_price:
		return false
	else:
		if gem_color == "Red":
			if PlayerManager.player.total_red_gem < gem_price:
				return false
			else:
				return true
		elif gem_color == "Blue":
			if PlayerManager.player.total_blue_gem < gem_price:
				return false
			else:
				return true
		elif gem_color == "Green":
			if PlayerManager.player.total_green_gem < gem_price:
				return false
			else:
				return true
		elif gem_color == "Yellow":
			if PlayerManager.player.total_yellow_gem < gem_price:
				return false
			else:
				return true

func item_level_UP():
	if item_lvl == 1 and VillageManager.armourer_lvl >= 1:
		if check_enough(upgrade_set.gem_color_text_lvl_1, upgrade_set.price_gem_lvl_1, upgrade_set.price_coin_lvl_1) == false:
			not_enough()
		else:
			upgraded_amount += upgrade_set.value_lvl_1
			PlayerManager.player.total_coins -= upgrade_set.price_coin_lvl_1
			process_gem(upgrade_set.gem_color_text_lvl_1, upgrade_set.price_gem_lvl_1)
			item_data_save()
	elif item_lvl == 2 and VillageManager.armourer_lvl >= 1:
		if check_enough(upgrade_set.gem_color_text_lvl_2, upgrade_set.price_gem_lvl_2, upgrade_set.price_coin_lvl_2) == false:
			not_enough()
		else:
			upgraded_amount += upgrade_set.value_lvl_2
			PlayerManager.player.total_coins -= upgrade_set.price_coin_lvl_2
			process_gem(upgrade_set.gem_color_text_lvl_2, upgrade_set.price_gem_lvl_2)
			item_data_save()
	elif item_lvl == 3 and VillageManager.armourer_lvl >= 2:
		if check_enough(upgrade_set.gem_color_text_lvl_3, upgrade_set.price_gem_lvl_3, upgrade_set.price_coin_lvl_3) == false:
			not_enough()
		else:
			upgraded_amount += upgrade_set.value_lvl_3
			PlayerManager.player.total_coins -= upgrade_set.price_coin_lvl_3
			process_gem(upgrade_set.gem_color_text_lvl_3, upgrade_set.price_gem_lvl_3)
			item_data_save()
	elif item_lvl == 4 and VillageManager.armourer_lvl >= 2:
		if check_enough(upgrade_set.gem_color_text_lvl_4, upgrade_set.price_gem_lvl_4, upgrade_set.price_coin_lvl_4) == false:
			not_enough()
		else:
			upgraded_amount += upgrade_set.value_lvl_4
			PlayerManager.player.total_coins -= upgrade_set.price_coin_lvl_4
			process_gem(upgrade_set.gem_color_text_lvl_4, upgrade_set.price_gem_lvl_4)
			item_data_save()
	elif item_lvl == 5 and VillageManager.armourer_lvl >= 3:
		if check_enough(upgrade_set.gem_color_text_lvl_5, upgrade_set.price_gem_lvl_5, upgrade_set.price_coin_lvl_5) == false:
			not_enough()
		else:
			upgraded_amount += upgrade_set.value_lvl_5
			PlayerManager.player.total_coins -= upgrade_set.price_coin_lvl_5
			process_gem(upgrade_set.gem_color_text_lvl_5, upgrade_set.price_gem_lvl_5)
			item_data_save()
			
	elif item_lvl == 6:
		Sfx.play_SFX(Sfx.upgrade_deny)
		$MaxLevel/MaxLevelLabel.visible = true
		await get_tree().create_timer(1).timeout
		$MaxLevel/MaxLevelLabel.visible = false
	else:
		Sfx.play_SFX(Sfx.upgrade_deny)
		$LowLevel/LowLevelLabel.visible = true
		await get_tree().create_timer(1).timeout
		$LowLevel/LowLevelLabel.visible = false
	
	if upgrade_set.item == "Initial Shield":
		PlayerManager.player.upgraded_shield_init = upgraded_amount
	elif upgrade_set.item == "Shield Load":
		PlayerManager.player.upgraded_shield_load = upgraded_amount
	elif upgrade_set.item == "Max Shield":
		PlayerManager.player.upgraded_shield_max = upgraded_amount

	SaveManager.savefilesave()

func _on_mouse_entered():
	$Price.visible = true
	if item_lvl == 1:
		$ItemDescription.text = str(upgrade_set.origin_value + upgrade_set.value_lvl_1 + upgraded_amount) + str(upgrade_set.description)
		$Price/CoinsLabel.text = ": " + str(upgrade_set.price_coin_lvl_1)
		$Price/Gems.texture = upgrade_set.gem_color_lvl_1
		$Price/GemsLabel.text = ": " + str(upgrade_set.price_gem_lvl_1)
	elif item_lvl == 2:
		$ItemDescription.text = str(upgrade_set.origin_value + upgrade_set.value_lvl_2 + upgraded_amount) + str(upgrade_set.description)
		$Price/CoinsLabel.text = ": " + str(upgrade_set.price_coin_lvl_2)
		$Price/Gems.texture = upgrade_set.gem_color_lvl_2
		$Price/GemsLabel.text = ": " + str(upgrade_set.price_gem_lvl_2)
	elif item_lvl == 3:
		$ItemDescription.text = str(upgrade_set.origin_value + upgrade_set.value_lvl_3 + upgraded_amount) + str(upgrade_set.description)
		$Price/CoinsLabel.text = ": " + str(upgrade_set.price_coin_lvl_3)
		$Price/Gems.texture = upgrade_set.gem_color_lvl_3
		$Price/GemsLabel.text = ": " + str(upgrade_set.price_gem_lvl_3)
	elif item_lvl == 4:
		$ItemDescription.text = str(upgrade_set.origin_value + upgrade_set.value_lvl_4 + upgraded_amount) + str(upgrade_set.description)
		$Price/Gems.texture = upgrade_set.gem_color_lvl_4
		$Price/GemsLabel.text = ": " + str(upgrade_set.price_gem_lvl_4)
	elif item_lvl == 5:
		$ItemDescription.text = str(upgrade_set.origin_value + upgrade_set.value_lvl_5 + upgraded_amount) + str(upgrade_set.description)
		$Price/CoinsLabel.text = ": " + str(upgrade_set.price_coin_lvl_5)
		$Price/Gems.texture = upgrade_set.gem_color_lvl_5
		$Price/GemsLabel.text = ": " + str(upgrade_set.price_gem_lvl_5)
	elif item_lvl == 6:
		$Price/Coins.visible = false
		$Price/CoinsLabel.visible = false
		$Price/Gems.visible = false
		$Price/GemsLabel.visible = false
	
	if item_lvl == 6:
		$ItemNameLvl.text = str(upgrade_set.item) + " Lvl Max"
	else:
		$ItemNameLvl.text = str(upgrade_set.item) + " Lvl " + str(item_lvl + 1)

func _on_mouse_exited():
	$Price.visible = false
	item_set()
	
func _on_pressed():
	effect()
	item_level_UP()
	_on_mouse_entered()
