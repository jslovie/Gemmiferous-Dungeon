extends TextureButton

var description = "Damage: 2-4"
var item = "Axe"
var lvl = 1

func _ready():
	item_set()
	
func item_set():
	$ItemDescription.text = description
	$ItemNameLvl.text = str(item) + " Lvl " + str(lvl)

func item_level_UP():
	if lvl == 1:
		PlayerManager.player.upgraded_axe_damage = PlayerManager.player.upgraded_axe_damage + Vector2(1,0)
		PlayerManager.player.total_coins -= 25
		PlayerManager.player.total_red_gem -= 10
		SaveManager.savefilesave()
		SaveManager.load_savefile()
		lvl += 1
		
		

func _on_mouse_entered():
	$Price.visible = true
	if lvl == 1:
		$ItemDescription.text = "Damage: 3-4"
		$Price/CoinsLabel.text = ": 25"
		$Price/Gems.texture = load("res://assets/32rogues/gems/red.png")
		$Price/GemsLabel.text = ": 10"
	elif lvl == 2:
		$ItemDescription.text = "Damage: 4-6"
		$Price/CoinsLabel.text = ": 50"
		$Price/Gems.texture = load("res://assets/32rogues/gems/blue.png")
		$Price/GemsLabel.text = ": 15"
		
		
	$ItemNameLvl.text = str(item) + " Lvl " + str(lvl + 1)

func _on_mouse_exited():
	$Price.visible = false
	$ItemDescription.text = description
	$ItemNameLvl.text = str(item) + " Lvl " + str(lvl)

func _on_pressed():
	item_level_UP()
	_on_mouse_entered()
