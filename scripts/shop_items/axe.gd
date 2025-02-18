extends TextureButton

@export var prices : ShopPrices

var description = "Damage: "



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
	if VillageManager.axe_item_lvl == 1:
		PlayerManager.player.upgraded_axe_damage = Vector2(0,0)
	if VillageManager.axe_item_lvl == 1:
		$ItemDescription.text = str(description) + str(prices.damage_0.x) + "-" + str(prices.damage_0.y)
	else:
		$ItemDescription.text = str(description) + str(prices.damage_0.x + PlayerManager.player.upgraded_axe_damage.x) + "-" + str(prices.damage_0.y + PlayerManager.player.upgraded_axe_damage.y)
	$ItemNameLvl.text = str(prices.item) + " Lvl " + str(VillageManager.axe_item_lvl)

func item_data_save():
	VillageManager.axe_item_lvl += 1
	SaveManager.savefilesave()
	SaveManager.load_savefile()

func item_level_UP():
	if VillageManager.axe_item_lvl == 1 and VillageManager.weaponsmith_lvl >= 1:
		if PlayerManager.player.total_coins < prices.price_coin_lvl_1 or PlayerManager.player.total_red_gem < prices.price_gem_lvl_1:
			not_enough()
		else:
			PlayerManager.player.upgraded_axe_damage += prices.damage_1
			PlayerManager.player.total_coins -= prices.price_coin_lvl_1
			PlayerManager.player.total_red_gem -= prices.price_gem_lvl_1
			item_data_save()
	elif VillageManager.axe_item_lvl == 2 and VillageManager.weaponsmith_lvl >= 1:
		if PlayerManager.player.total_coins < prices.price_coin_lvl_2 or PlayerManager.player.total_red_gem < prices.price_gem_lvl_2:
			not_enough()
		else:
			PlayerManager.player.upgraded_axe_damage += prices.damage_2
			PlayerManager.player.total_coins -= prices.price_coin_lvl_2
			PlayerManager.player.total_blue_gem -= prices.price_gem_lvl_2
			item_data_save()
	elif VillageManager.axe_item_lvl == 3 and VillageManager.weaponsmith_lvl >= 2:
		if PlayerManager.player.total_coins < prices.price_coin_lvl_3 or PlayerManager.player.total_red_gem < prices.price_gem_lvl_3:
			not_enough()
		else:
			PlayerManager.player.upgraded_axe_damage += prices.damage_3
			PlayerManager.player.total_coins -= prices.price_coin_lvl_3
			PlayerManager.player.total_green_gem -= prices.price_gem_lvl_3
			item_data_save()
	elif VillageManager.axe_item_lvl == 4 and VillageManager.weaponsmith_lvl >= 2:
		if PlayerManager.player.total_coins < prices.price_coin_lvl_4 or PlayerManager.player.total_red_gem < prices.price_gem_lvl_4:
			not_enough()
		else:
			PlayerManager.player.upgraded_axe_damage += prices.damage_4
			PlayerManager.player.total_coins -= prices.price_coin_lvl_4
			PlayerManager.player.total_yellow_gem -= prices.price_gem_lvl_4
			item_data_save()
	elif VillageManager.axe_item_lvl == 5 and VillageManager.weaponsmith_lvl >= 3:
		if PlayerManager.player.total_coins < prices.price_coin_lvl_5 or PlayerManager.player.total_red_gem < prices.price_gem_lvl_5:
			not_enough()
		else:
			PlayerManager.player.upgraded_axe_damage += prices.damage_5
			PlayerManager.player.total_coins -= prices.price_coin_lvl_5
			PlayerManager.player.total_red_gem -= prices.price_gem_lvl_5
			item_data_save()
	else:
		$LowLevel/LowLevelLabel.visible = true
		await get_tree().create_timer(1).timeout
		$LowLevel/LowLevelLabel.visible = false
	print("Upgraded Axe damage: " + str(PlayerManager.player.upgraded_axe_damage))
func _on_mouse_entered():
	$Price.visible = true
	if VillageManager.axe_item_lvl == 1:
		$ItemDescription.text = str(description) + str(prices.damage_0.x + prices.damage_1.x + PlayerManager.player.upgraded_axe_damage.x) + "-" + str(prices.damage_0.y + prices.damage_1.y + PlayerManager.player.upgraded_axe_damage.y)
		$Price/CoinsLabel.text = ": " + str(prices.price_coin_lvl_1)
		$Price/Gems.texture = prices.gem_color_lvl_1
		$Price/GemsLabel.text = ": " + str(prices.price_gem_lvl_1)
	elif VillageManager.axe_item_lvl == 2:
		$ItemDescription.text = str(description) + str(prices.damage_0.x + prices.damage_2.x + PlayerManager.player.upgraded_axe_damage.x) + "-" + str(prices.damage_0.y + prices.damage_2.y + PlayerManager.player.upgraded_axe_damage.y)
		$Price/CoinsLabel.text = ": " + str(prices.price_coin_lvl_2)
		$Price/Gems.texture = prices.gem_color_lvl_2
		$Price/GemsLabel.text = ": " + str(prices.price_gem_lvl_2)
	elif VillageManager.axe_item_lvl == 3:
		$ItemDescription.text = str(description) + str(prices.damage_0.x + prices.damage_3.x + PlayerManager.player.upgraded_axe_damage.x) + "-" + str(prices.damage_0.y + prices.damage_3.y + PlayerManager.player.upgraded_axe_damage.y)
		$Price/CoinsLabel.text = ": " + str(prices.price_coin_lvl_3)
		$Price/Gems.texture = prices.gem_color_lvl_3
		$Price/GemsLabel.text = ": " + str(prices.price_gem_lvl_3)
	elif VillageManager.axe_item_lvl == 4:
		$ItemDescription.text = str(description) + str(prices.damage_0.x + prices.damage_4.x + PlayerManager.player.upgraded_axe_damage.x) + "-" + str(prices.damage_0.y + prices.damage_4.y + PlayerManager.player.upgraded_axe_damage.y)
		$Price/CoinsLabel.text = ": " + str(prices.price_coin_lvl_4)
		$Price/Gems.texture = prices.gem_color_lvl_4
		$Price/GemsLabel.text = ": " + str(prices.price_gem_lvl_4)
	elif VillageManager.axe_item_lvl == 5:
		$ItemDescription.text = str(description) + str(prices.damage_0.x + prices.damage_5.x + PlayerManager.player.upgraded_axe_damage.x) + "-" + str(prices.damage_0.y + prices.damage_5.y + PlayerManager.player.upgraded_axe_damage.y)
		$Price/CoinsLabel.text = ": " + str(prices.price_coin_lvl_5)
		$Price/Gems.texture = prices.gem_color_lvl_5
		$Price/GemsLabel.text = ": " + str(prices.price_gem_lvl_5)
		
	$ItemNameLvl.text = str(prices.item) + " Lvl " + str(VillageManager.axe_item_lvl + 1)

func _on_mouse_exited():
	$Price.visible = false
	item_set()
	
func _on_pressed():
	effect()
	item_level_UP()
	_on_mouse_entered()
