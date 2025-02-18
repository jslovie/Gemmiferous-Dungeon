extends Node2D


func _process(delta):
	update_text()
	update_buttons()

func update_text():
	$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Label.text = "Upgrade Weaponsmith lvl " + str(VillageManager.weaponsmith_lvl)
	if VillageManager.weaponsmith_lvl > 3:
		$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Label.text = "Upgrade Weaponsmith"

func update_buttons():
	if VillageManager.weaponsmith_lvl > 3:
		$TownUpgrades/VBoxContainer/WeaponsmithUpgrade.disabled
		$TownUpgrades/VBoxContainer/WeaponsmithUpgrade/Checked.visible = true

func _on_enter_the_dungeon_pressed():
	get_tree().change_scene_to_file("res://scenes/character_selection.tscn")
	



func _on_exit_shop_pressed():
	visible = false


func _on_weaponsmith_upgrade_pressed():
	VillageManager.weaponsmith_lvl += 1



func _on_church_pressed():
	VillageManager.church_repaired = true
	$Cost.visible = false
	$TownRepair/VBoxContainer/Church.disabled = true
	$TownRepair/VBoxContainer/Church/Checked.visible = true

func _on_church_mouse_entered():
	$Cost.visible = true
	%Wood.text = "50"
	%Stone.text = "45"
	%Iron.text = "10"
	
	
func _on_church_mouse_exited():
	$Cost.visible = false
