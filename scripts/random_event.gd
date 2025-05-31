extends Node2D

var room

var coins_lost
var coins_gained
var red_gems_lost
var blue_gems_lost
var green_gems_lost
var yellow_gems_lost
#var materials_lost
var health_lost
var health_gained

@export var test : bool
@export var test_level : int

func _ready():
	$Continue.visible = false
	$PlayerDied.visible = false
	Music.play_music_random_event()
	LevelManager.level_done += 1
	EnemyManager.enemy.type = "Trap"
	SaveManager.load_autosave()
	choose_random_room()
	update_text()
	$Control/Resolution.visible = false

func _process(_delta):
	change_background()

func change_background():
	if LevelManager.floor == 1:
		$Background/F1.visible = true
	elif LevelManager.floor == 2:
		$Background/F2.visible = true
	elif LevelManager.floor == 3:
		$Background/F3.visible = true
	elif LevelManager.floor == 4:
		$Background/F4.visible = true

func choose_random_room():
	room = randi_range(1, 6)
	if test == true:
		room = test_level
		
	
func lost_items(amount):
	coins_lost = round(PlayerManager.player.coins * amount)
	red_gems_lost = round(PlayerManager.player.red_gem * amount)
	blue_gems_lost = round(PlayerManager.player.blue_gem * amount)
	green_gems_lost = round(PlayerManager.player.green_gem * amount)
	yellow_gems_lost = round(PlayerManager.player.yellow_gem * amount)
	#materials_lost = round(PlayerManager.player.materials * amount)
	PlayerManager.player.coins -= coins_lost
	PlayerManager.player.red_gem -= red_gems_lost
	PlayerManager.player.blue_gem -= blue_gems_lost
	PlayerManager.player.green_gem -= green_gems_lost
	PlayerManager.player.yellow_gem -= yellow_gems_lost
	#PlayerManager.player.materials -= materials_lost

func lost_coins(percentage):
	coins_lost = round(PlayerManager.player.coins * percentage)
	PlayerManager.player.coins -= coins_lost
	
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
	if PlayerManager.player.health >= PlayerManager.player.max_health:
		PlayerManager.player.health = PlayerManager.player.max_health

func gain_gems(amount):
	PlayerManager.player.red_gem += round(PlayerManager.player.red_gem * amount)
	PlayerManager.player.blue_gem += round(PlayerManager.player.blue_gem * amount)
	PlayerManager.player.green_gem += round(PlayerManager.player.green_gem * amount)
	PlayerManager.player.yellow_gem += round(PlayerManager.player.yellow_gem * amount)

func get_gems(amount):
	PlayerManager.player.red_gem += amount
	PlayerManager.player.blue_gem += amount
	PlayerManager.player.green_gem += amount
	PlayerManager.player.yellow_gem += amount
	
func handle_game_over():
	await get_tree().create_timer(3).timeout
	PlayerManager.player.status = "dead"
	$Control/Resolution.visible = false
	$PlayerDied.visible = true
	EnemyManager.enemy.type = "Trap"
	PlayerManager.player.set_treasure()
	SaveManager.savefilesave()
	SaveManager.remove_autosave()

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
		%EventText.text = "You entered a room, but you were caught off guard by a group of monsters"
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
	elif room == 5:
		%EventText.text = "You entered a room, but there seems to be nothing inside"
		%Button.text = "Quite disappointed, you decided to head towards the door on the other side to leave"
		%Button2.visible = false
		%Button3.visible = false
	elif room == 6:
		%EventText.text = "You entered a room and see old man sitting on the ground, he seems to have some healing skills"
		%Button.text = "Heal some HP for some spare coins"
		%Button2.text = "Leave the old man alone"
		%Button3.visible = false
		
func resolution_screen():
	$Control/Event.visible = false
	$Control/Resolution.visible = true
	$Continue.visible = true

func update_text_next():
	pass

func handle_button():
	if room == 1:
		if %Button.text == "Attempt to flee":
			var random_resolution = randi_range(1,2)
			if random_resolution == 1:
				resolution_screen()
				$Continue.visible = false
				%ResolutionText.text = "One of the monsters caught you"
				await get_tree().create_timer(3).timeout
				EnemyManager.type = "Zombie"
				LevelManager.level_done -= 1
				get_tree().change_scene_to_file("res://scenes/dungeons/enemy_selection.tscn")
			elif random_resolution == 2:
				resolution_screen()
				%ResolutionText.text = "You managed to escape but lost some items"
				lost_items(0.1)
				
	elif room == 2:
		if %Button.text == "Drink the liquid":
			var random_resolution = randi_range(1,2)
			if random_resolution == 1:
				resolution_screen()
				%ResolutionText.text = "You feel well and healed 25 HP"
				gained_health(25)
				
			elif random_resolution == 2:
				resolution_screen()
				$Continue.visible = false
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
				%ResolutionText.text = "You started to read the book but quickly realized that you don't understand anything. 
										You decided it would be better to leave."
				
	elif room == 4:
		if %Button.text == "Open the chest":
			var random_resolution = randi_range(1,2)
			if random_resolution == 1:
				resolution_screen()
				$Continue.visible = false
				%ResolutionText.text = "As you were trying to open the chest you triggered a hidden mechanism which drove sharp spikes into your hand
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
				LevelManager.type = "Treasure"
				get_tree().change_scene_to_file("res://scenes/game_window.tscn")
				
	elif room == 5:
		if %Button.text == "Quite disappointed, you decided to head towards the door on the other side to leave":
			var random_resolution = randi_range(1,3)
			if random_resolution == 1:
				resolution_screen()
				lost_health_percentage(0.15)
				%ResolutionText.text = "You stepped on hidden spikes and lost " + str(health_lost) + " HP"
				
				LevelManager.switch_to_dungeon_map()
			elif random_resolution == 2:
				resolution_screen()
				%ResolutionText.text = "Nothing happened on the way"
				
			elif random_resolution == 3:
				resolution_screen()
				%ResolutionText.text = "You noticed a pile of gems on the floor. Luck is on your side"
				get_gems(2)
				gain_gems(0.15)
				
			elif random_resolution == 4:
				resolution_screen()
				%ResolutionText.text = "You noticed a pouch full of gold on the floor. Looks like someone lost it here"
				gained_coins(50)
				
	elif room == 6:
		if %Button.text == "Heal some HP for some spare coins":
			resolution_screen()
			var random_heal = randi_range(1,10)
			gained_health(random_heal)
			lost_coins(0.1)
			%ResolutionText.text = "You gained " + str(random_heal) + " HP and gave the old man " + str(coins_lost) + " coins"
			
			
			
func handle_button2():
	if room == 1:
		if %Button2.text == "Fight them":
			var random_resolution = randi_range(1,2)
			if random_resolution == 1:
				resolution_screen()
				lost_health_percentage(0.2)
				var random_coins = randi_range(25,50)
				gained_coins(random_coins)
				%ResolutionText.text = "You fought well and gained " + str(random_coins) + " coins, but lost " + str(health_lost) + " health"
				
				
			elif random_resolution == 2:
				resolution_screen()
				lost_health_percentage(0.1)
				var random_coins = randi_range(15,25)
				gained_coins(random_coins)
				%ResolutionText.text = "You fought good and gained " + str(random_coins) + " coins, but lost " + str(health_lost) + " health"
				
	elif room == 2:
		resolution_screen()
		%ResolutionText.text = "You decided to not drink the mysterious liquid and left the room hoping it was a good decision"
		
	elif room == 3:
		resolution_screen()
		%ResolutionText.text = "Such book won't bring anything good, you left the room glad that you did't touch it"
			
	elif room == 4:
		resolution_screen()
		%ResolutionText.text = "You decided that you don't trust the chest and left the room"
		
	elif room == 6:
		resolution_screen()
		%ResolutionText.text = "You decided that you don't trust the old man and left the room"
		
			
			
			
				
func handle_button3():
	pass


func _on_button_pressed():
	handle_button()

func _on_button_2_pressed():
	handle_button2()

func _on_button_3_pressed():
	handle_button3()


func _on_continue_pressed():
	LevelManager.switch_to_dungeon_map_timeless()
func _on_continue_mouse_entered():
	$Continue/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_continue_mouse_exited():
	$Continue/Label.add_theme_color_override("font_color", Color.WHITE)
