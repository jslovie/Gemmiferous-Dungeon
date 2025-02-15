extends TextureButton

var description = "Description of item"
var item = "Item"
var lvl = 1

func _ready():
	item_set()
	
func item_set():
	$ItemDescription.text = description
	$ItemNameLvl.text = str(item) + " Lvl " + str(lvl)

func item_level_UP():
	if lvl == 1:
		lvl += 1
		

func effect():
	var tween = create_tween()
	tween.tween_property($".", "size", Vector2(150,150), 0.1)
	tween.tween_property($".", "size", Vector2(113,115), 0.1)

func _on_mouse_entered():
	$Price.visible = true
	$ItemDescription.text = "New description of item"
	$ItemNameLvl.text = str(item) + " Lvl " + str(lvl + 1)

func _on_mouse_exited():
	$Price.visible = false
	$ItemDescription.text = description
	$ItemNameLvl.text = str(item) + " Lvl " + str(lvl)

func _on_pressed():
	effect()
	item_level_UP()
