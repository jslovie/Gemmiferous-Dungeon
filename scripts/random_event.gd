extends Node2D

var room

var coins_lost
var coins_gained
var red_gems_lost
var blue_gems_lost
var green_gems_lost
var yellow_gems_lost
var materials_lost
var health_lost
var health_gained

func _ready():
	SaveManager.load_autosave()
	choose_random_room()
	update_text()
	$Control/Resolution.visible = false
	
func choose_random_room():
	room = randi_range(1, 4)
	room = 4
func lost_items(amount):
	coins_lost = round(PlayerManager.player.coins * amount)
	red_gems_lost = round(PlayerManager.player.red_gem * amount)
	blue_gems_lost = round(PlayerManager.player.blue_gem * amount)
	green_gems_lost = round(PlayerManager.player.green_gem * amount)
	yellow_gems_lost = round(PlayerManager.player.yellow_gem * amount)
	materials_lost = round(PlayerManager.player.materials * amount)
	PlayerManager.player.coins -= coins_lost
	PlayerManager.player.red_gem -= red_gems_lost
	PlayerManager.player.blue_gem -= blue_gems_lost
	PlayerManager.player.green_gem -= green_gems_lost
	PlayerManager.player.yellow_gem -= yellow_gems_lost
	PlayerManager.player.materials -= materials_lost
	
func lost_health_percentage(amount):
	health_lost = round(PlayerManager.player.health * amount)
	PlayerManager.player.health -= health_lost
	
func lost_health_amount(amount):
	health_lost = amount
	PlayerManager.player.health -= health_lost

func gained_coins(amount):
	coins_gained = amount
	PlayerManager.player.coins += coins_gained

func gained_health(amount):
	health_gained = amount
	PlayerManager.player.health += health_gained

func handle_game_over():
	await get_tree().create_timer(3).timeout
	PlayerManager.player.status = "dead"
	%ResolutionText.text = "You Died"
	await get_tree().create_timer(3).timeout
	SaveManager.remove_autosave()
	get_tree().quit()

func template_to_copy(): #just a template, should be removed later
	var random_resolution = randi_range(1,2)
	if random_resolution == 1:
		pass
	elif random_resolution == 2:
		pass
	%EventText.text = ""
	%Button.text = ""
	%Button2.text = ""
	%Button3.visible = false


func update_text():
	if room == 1:
		%EventText.text = "You entered a room but you were caught of guard by a group of monsters"
		%Button.text = "Attempt to flee"
		%Button2.text = "Fight them"
		%Button3.visible = false
	elif room == 2:
		%EventText.text = "You entered a room and found a basin full of red liquid"
		%Button.text = "Drink the liquid"
		%Button2.text = "Leave the room"
		%Button3.visible = false
	elif room == 3:
		%EventText.text = "You entered a room and see book on the pedestal"
		%Button.text = "Open book on random page and read it"
		%Button2.text = "Leave the book alone"
		%Button3.visible = false
	elif room == 4:
		%EventText.text = "You entered a room and see treasure chest on the floor"
		%Button.text = "Open the chest"
		%Button2.text = "Leave the chest alone"
		%Button3.visible = false
		
		
func resolution_screen():
	$Control/Event.visible = false
	$Control/Resolution.visible = true

func update_text_next():
	pass

func handle_button():
	if room == 1:
		if %Button.text == "Attempt to flee":
			var random_resolution = randi_range(1,2)
			if random_resolution == 1:
				resolution_screen()
				%ResolutionText.text = "One of the monsters caught you"
				await get_tree().create_timer(3).timeout
				EnemyManager.type = "Zombie"
				get_tree().change_scene_to_file("res://scenes/dungeons/enemy_selection.tscn")
			elif random_resolution == 2:
				resolution_screen()
				%ResolutionText.text = "You managed to escape but lost some items"
				lost_items(0.1)
				LevelManager.switch_to_dungeon_map()
	elif room == 2:
		if %Button.text == "Drink the liquid":
			var random_resolution = randi_range(1,2)
			if random_resolution == 1:
				resolution_screen()
				%ResolutionText.text = "You feel well and healed 25 HP"
				gained_health(25)
				LevelManager.switch_to_dungeon_map()
			elif random_resolution == 2:
				resolution_screen()
				%ResolutionText.text = "You don't feel well and lost 25 HP"
				lost_health_amount(25)
				if PlayerManager.player.health <= 0:
					handle_game_over()
				else :
					LevelManager.switch_to_dungeon_map()
	elif room == 3:
		if %Button.text == "Open book on random page and read it":
			var random_resolution = randi_range(1,2)
			if random_resolution == 1:
				resolution_screen()
				%ResolutionText.text = "You quickly realized that it was not a good idea.
										You leave the room quite shaken but unharmed"
			elif random_resolution == 2:
				resolution_screen()
				%ResolutionText.text = "You found some useful knowledge on the book" #Need to add some knowledge here
	elif room == 4:
		if %Button.text == "Open the chest":
			var random_resolution = randi_range(1,2)
			if random_resolution == 1:
				resolution_screen()
				%ResolutionText.text = "As you were trying to open the chest you triggered a hiddin mechanism which drove sharp spikes into your hand
										Your hand got hurt badly and you lost 15HP"
				lost_health_amount(15)
				if PlayerManager.player.health <= 0:
					handle_game_over()
				else :
					LevelManager.switch_to_dungeon_map()
			elif random_resolution == 2:
				resolution_screen()
				%ResolutionText.text = "You successfully opened the chest"
				await get_tree().create_timer(3).timeout
				get_tree().change_scene_to_file("res://scenes/treasure.tscn")
			
func handle_button2():
	if room == 1:
		if %Button2.text == "Fight them":
			var random_resolution = randi_range(1,2)
			if random_resolution == 1:
				resolution_screen()
				lost_health_percentage(0.2)
				gained_coins(200)
				%ResolutionText.text = "You fought well and gained 200 coins, but lost " + str(health_lost) + " health"
				LevelManager.switch_to_dungeon_map()
				
			elif random_resolution == 2:
				resolution_screen()
				lost_health_percentage(0.1)
				gained_coins(50)
				%ResolutionText.text = "You fought good and gained 50 coins, but lost " + str(health_lost) + " health"
				LevelManager.switch_to_dungeon_map()
	elif room == 2:
		resolution_screen()
		%ResolutionText.text = "You decided to not drink the mysterious liquid and left the room hoping it was a good decision"
		LevelManager.switch_to_dungeon_map()
	elif room == 3:
		resolution_screen()
		%ResolutionText.text = "Such book won't bring anything good, you left the room glad that you did't touch it"
		LevelManager.switch_to_dungeon_map()	
	elif room == 4:
		resolution_screen()
		%ResolutionText.text = "You decided that you don't trust the chest and left the room"
		LevelManager.switch_to_dungeon_map()
	
func handle_button3():
	pass


func _on_button_pressed():
	handle_button()

func _on_button_2_pressed():
	handle_button2()

func _on_button_3_pressed():
	handle_button3()
