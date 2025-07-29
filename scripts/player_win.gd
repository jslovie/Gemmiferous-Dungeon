extends Control

signal update_total_bar

var descriptions_man = {
	description1 = "Many believe he spent his final days traveling the seas, searching for new lands to conquer. Some say he met his end in a violent storm, while others whisper of a betrayal within his own crew. His fate remains unknown.",
	description2 = "Some people say he kept some of the treasures for himself and spent a few weeks drinking and whoring. Eventually, he died of the plague. The allegations of stealing were never confirmed.",
	description3 = "Some say he withdrew from the world, seeking solitude in the mountains to master forgotten arts and ancient magic. Over the years, his name faded into myth, and no one knows what became of him. All that remains are the mysterious texts he left behind, hinting at a power beyond comprehension.",
	description4 = "Some say he wandered the world in search of forgotten knowledge. He never returned, leaving only legends behind. What he found, if anything, remains unknown.",
	description5 = "Some say he spent his last years as a hermit, seeking peace in the wilderness. He was never seen again, and his fate remains a quiet mystery.",
	description6 = "Some say he roamed the seas, chasing tales of lost islands and hidden treasures. He vanished without a trace, leaving only his journals behind. No one knows what he discovered, but his name lives on in the stories of those who sailed with him."
}

func _ready():
	$Description2.text = choose_description()

func _process(_delta):
	update_treasures()
	update_materials()
	update_description()

func choose_description():
	var description_keys = descriptions_man.keys()
	var random_description = description_keys[randi() % descriptions_man.size()]
	var selected_description = descriptions_man[random_description]
	return selected_description
		
	
func update_description():
	$Description.text = "The " + str(PlayerManager.player.type) + " managed to return from the dungeon alive."
	
func update_treasures():
	$Gems/GemsNumbers/RedGemNumber.text = ": " + str(PlayerManager.player.red_gem)
	$Gems/GemsNumbers/GreenGemNumber.text = ": " + str(PlayerManager.player.green_gem)
	$Gems/GemsNumbers/BlueGemNumber.text = ": " + str(PlayerManager.player.blue_gem)
	$Gems/GemsNumbers/YellowGemNumber.text = ": " + str(PlayerManager.player.yellow_gem)
	$Gems/GemsNumbers/CoinNumber.text = ": " + str(PlayerManager.player.coins)

func update_materials():
	$Material/WoodLabel.text = ": " + str(PlayerManager.player.wood)
	$Material/StoneLabel.text = ": " + str(PlayerManager.player.stone)
	$Material/IronLabel.text = ": " + str(PlayerManager.player.iron)

func _on_exit_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)

func _on_exit_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	$Exit.visible = false
	$Label.visible = false
	SaveManager.savefilesave()
	LevelManager.reset_map()
	RelicManager.reset_pieces_relics()
	emit_signal("update_total_bar")
	await get_tree().create_timer(2.5).timeout
	SaveManager.remove_autosave()
	SaveManager.savefilesave()
	LevelManager.reset_win()
	RelicManager.hide_stats = false
	LevelManager.back_to_village()
