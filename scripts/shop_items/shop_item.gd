extends TextureButton

@export var prices : ShopPrices

var description = "Damage: "
var item_lvl
var upgraded_item_damage

func _ready():
	await get_tree().create_timer(1).timeout
	set_item()
	item_set()


func set_item():
	if prices.item == "Axe":
		item_lvl = VillageManager.axe_item_lvl
		upgraded_item_damage = PlayerManager.player.upgraded_axe_damage
	elif prices.item == "Mace":
		item_lvl = VillageManager.mace_item_lvl
		upgraded_item_damage = PlayerManager.player.upgraded_mace_damage
	elif prices.item == "Sword":
		item_lvl = VillageManager.sword_item_lvl
		upgraded_item_damage = PlayerManager.player.upgraded_sword_damage
	elif prices.item == "Bow":
		item_lvl = VillageManager.bow_item_lvl
		upgraded_item_damage = PlayerManager.player.upgraded_bow_damage

		
		
func effect():
	var tween = create_tween()
	tween.tween_property($ItemPicture, "scale", Vector2(4,4), 0.1)
	tween.tween_property($ItemPicture, "scale", Vector2(3,3), 0.1)

func not_enough():
	$NotEnough/NotEnoughLabel.visible = true
	await get_tree().create_timer(1).timeout
	$NotEnough/NotEnoughLabel.visible = false

func item_set():
	if item_lvl == 1:
		upgraded_item_damage = Vector2(0,0)
		$ItemNameLvl.text = str(prices.item) + " Lvl " + str(item_lvl)
		$ItemDescription.text = str(description) + str(prices.damage_0.x) + "-" + str(prices.damage_0.y)
	elif item_lvl == 6:
		$ItemNameLvl.text = str(prices.item) + " Lvl Max"
		$ItemDescription.text = str(description) + str(prices.damage_0.x + upgraded_item_damage.x) + "-" + str(prices.damage_0.y + upgraded_item_damage.y)
	else:
		$ItemNameLvl.text = str(prices.item) + " Lvl " + str(item_lvl)
		$ItemDescription.text = str(description) + str(prices.damage_0.x + upgraded_item_damage.x) + "-" + str(prices.damage_0.y + upgraded_item_damage.y)



func item_data_save():
	item_lvl += 1
	
	if prices.item == "Axe":
		VillageManager.axe_item_lvl = item_lvl
	elif prices.item == "Mace":
		VillageManager.mace_item_lvl = item_lvl
	elif prices.item == "Sword":
		VillageManager.sword_item_lvl = item_lvl
	elif prices.item == "bow":
		VillageManager.bow_item_lvl = item_lvl
		
	SaveManager.savefilesave()
	#SaveManager.load_savefile()

func item_level_UP():
	if item_lvl == 1 and VillageManager.weaponsmith_lvl >= 1:
		if PlayerManager.player.total_coins < prices.price_coin_lvl_1 or PlayerManager.player.total_red_gem < prices.price_gem_lvl_1:
			not_enough()
		else:
			upgraded_item_damage += prices.damage_1
			print(upgraded_item_damage)
			print(PlayerManager.player.upgraded_axe_damage)
			PlayerManager.player.total_coins -= prices.price_coin_lvl_1
			PlayerManager.player.total_red_gem -= prices.price_gem_lvl_1
			item_data_save()
	elif item_lvl == 2 and VillageManager.weaponsmith_lvl >= 1:
		if PlayerManager.player.total_coins < prices.price_coin_lvl_2 or PlayerManager.player.total_red_gem < prices.price_gem_lvl_2:
			not_enough()
		else:
			upgraded_item_damage += prices.damage_2
			PlayerManager.player.total_coins -= prices.price_coin_lvl_2
			PlayerManager.player.total_blue_gem -= prices.price_gem_lvl_2
			item_data_save()
	elif item_lvl == 3 and VillageManager.weaponsmith_lvl >= 2:
		if PlayerManager.player.total_coins < prices.price_coin_lvl_3 or PlayerManager.player.total_red_gem < prices.price_gem_lvl_3:
			not_enough()
		else:
			upgraded_item_damage += prices.damage_3
			PlayerManager.player.total_coins -= prices.price_coin_lvl_3
			PlayerManager.player.total_green_gem -= prices.price_gem_lvl_3
			item_data_save()
	elif item_lvl == 4 and VillageManager.weaponsmith_lvl >= 2:
		if PlayerManager.player.total_coins < prices.price_coin_lvl_4 or PlayerManager.player.total_red_gem < prices.price_gem_lvl_4:
			not_enough()
		else:
			upgraded_item_damage += prices.damage_4
			PlayerManager.player.total_coins -= prices.price_coin_lvl_4
			PlayerManager.player.total_yellow_gem -= prices.price_gem_lvl_4
			item_data_save()
	elif item_lvl == 5 and VillageManager.weaponsmith_lvl >= 3:
		if PlayerManager.player.total_coins < prices.price_coin_lvl_5 or PlayerManager.player.total_red_gem < prices.price_gem_lvl_5:
			not_enough()
		else:
			upgraded_item_damage += prices.damage_5
			PlayerManager.player.total_coins -= prices.price_coin_lvl_5
			PlayerManager.player.total_red_gem -= prices.price_gem_lvl_5
			item_data_save()
	elif item_lvl == 6:
		$MaxLevel/MaxLevelLabel.visible = true
		await get_tree().create_timer(1).timeout
		$MaxLevel/MaxLevelLabel.visible = false
	else:
		$LowLevel/LowLevelLabel.visible = true
		await get_tree().create_timer(1).timeout
		$LowLevel/LowLevelLabel.visible = false
		
	if prices.item == "Axe":
		PlayerManager.player.upgraded_axe_damage = upgraded_item_damage
	elif prices.item == "Mace":
		PlayerManager.player.upgraded_axe_damage = upgraded_item_damage
	elif prices.item == "Sword":
		PlayerManager.player.upgraded_axe_damage = upgraded_item_damage	
	elif prices.item == "Bow":
		PlayerManager.player.upgraded_axe_damage = upgraded_item_damage	

	SaveManager.savefilesave()

func _on_mouse_entered():
	$Price.visible = true
	if item_lvl == 1:
		$ItemDescription.text = str(description) + str(prices.damage_0.x + prices.damage_1.x + upgraded_item_damage.x) + "-" + str(prices.damage_0.y + prices.damage_1.y + upgraded_item_damage.y)
		$Price/CoinsLabel.text = ": " + str(prices.price_coin_lvl_1)
		$Price/Gems.texture = prices.gem_color_lvl_1
		$Price/GemsLabel.text = ": " + str(prices.price_gem_lvl_1)
	elif item_lvl == 2:
		$ItemDescription.text = str(description) + str(prices.damage_0.x + prices.damage_2.x + upgraded_item_damage.x) + "-" + str(prices.damage_0.y + prices.damage_2.y + upgraded_item_damage.y)
		$Price/CoinsLabel.text = ": " + str(prices.price_coin_lvl_2)
		$Price/Gems.texture = prices.gem_color_lvl_2
		$Price/GemsLabel.text = ": " + str(prices.price_gem_lvl_2)
	elif item_lvl == 3:
		$ItemDescription.text = str(description) + str(prices.damage_0.x + prices.damage_3.x + upgraded_item_damage.x) + "-" + str(prices.damage_0.y + prices.damage_3.y + upgraded_item_damage.y)
		$Price/CoinsLabel.text = ": " + str(prices.price_coin_lvl_3)
		$Price/Gems.texture = prices.gem_color_lvl_3
		$Price/GemsLabel.text = ": " + str(prices.price_gem_lvl_3)
	elif item_lvl == 4:
		$ItemDescription.text = str(description) + str(prices.damage_0.x + prices.damage_4.x + upgraded_item_damage.x) + "-" + str(prices.damage_0.y + prices.damage_4.y + upgraded_item_damage.y)
		$Price/CoinsLabel.text = ": " + str(prices.price_coin_lvl_4)
		$Price/Gems.texture = prices.gem_color_lvl_4
		$Price/GemsLabel.text = ": " + str(prices.price_gem_lvl_4)
	elif item_lvl == 5:
		$ItemDescription.text = str(description) + str(prices.damage_0.x + prices.damage_5.x + upgraded_item_damage.x) + "-" + str(prices.damage_0.y + prices.damage_5.y + upgraded_item_damage.y)
		$Price/CoinsLabel.text = ": " + str(prices.price_coin_lvl_5)
		$Price/Gems.texture = prices.gem_color_lvl_5
		$Price/GemsLabel.text = ": " + str(prices.price_gem_lvl_5)
	elif item_lvl == 6:
		$Price/Coins.visible = false
		$Price/CoinsLabel.visible = false
		$Price/Gems.visible = false
		$Price/GemsLabel.visible = false
	
	if item_lvl == 6:
		$ItemNameLvl.text = str(prices.item) + " Lvl Max"
	else:
		$ItemNameLvl.text = str(prices.item) + " Lvl " + str(item_lvl + 1)

func _on_mouse_exited():
	$Price.visible = false
	item_set()
	
func _on_pressed():
	effect()
	item_level_UP()
	_on_mouse_entered()
