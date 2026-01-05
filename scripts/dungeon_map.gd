extends CanvasLayer

var base_action1
var base_action2
var base_action3
var health 
var max_health 
var shield 
var xp 

var random_f1
var random_f2
var random_f3
var random_f4

@export var test_active : bool
@onready var run_time = $RunTime/RunTimeLabel

func _ready():
	LevelManager.show_map = false
	choose_random_f()
	hide_tutorial()
	
func _process(_delta):
	if LevelManager.show_map:
		if Input.is_action_just_pressed("Esc"):
			_on_home_pressed()
	dungeon_map()
	choose_map()
	if LevelManager.in_tutorial_level:
		$InfoPageDetails/BackLabel.text = "Play"
	check_run_time()

func choose_random_f():
	random_f1 = randi_range(1,6)
	random_f2 = randi_range(1,3)
	
	if test_active == true:
		random_f1 = 1
		$Dungeons/F1/DungeonF1_1/Levels/LevelSelection27.visible = true
	else:
		$Dungeons/F1/DungeonF1_1/Levels/LevelSelection27.visible = false


func choose_map():
	if LevelManager.floor == 1:
		if random_f1 == 1:
			%DungeonF1_1.visible = true
		elif random_f1 == 2:
			%DungeonF1_2.visible = true
		elif random_f1 == 3:
			%DungeonF1_3.visible = true
		elif random_f1 == 4:
			%DungeonF1_4.visible = true
		elif random_f1 == 5:
			%DungeonF1_5.visible = true
		elif random_f1 == 6:
			%DungeonF1_6.visible = true
			
	elif LevelManager.floor == 2:
		if random_f2 == 1:
			%DungeonF2_1.visible = true
		elif random_f2 == 2:
			%DungeonF2_2.visible = true
		elif random_f2 == 3:
			%DungeonF2_3.visible = true
			
	elif LevelManager.floor == 3:
		%DungeonF3_1.visible = true
	elif LevelManager.floor == 4:
		%DungeonF4_1.visible = true
	if LevelManager.in_tutorial_level:
		$Dungeons/Tutorial/DungeonF_T.visible = true
	
func hide_all_dungeons():
	#F1
	%DungeonF1_1.visible = false
	%DungeonF1_2.visible = false
	%DungeonF1_3.visible = false
	%DungeonF1_4.visible = false
	%DungeonF1_5.visible = false
	%DungeonF1_6.visible = false
	#F2
	%DungeonF2_1.visible = false
	%DungeonF2_2.visible = false
	%DungeonF2_3.visible = false
	#F3
	%DungeonF3_1.visible = false
	#F4
	%DungeonF4_1.visible = false
	#FT
	$Dungeons/Tutorial/DungeonF_T.visible = false
	
	
func dungeon_map():
	if LevelManager.show_map == false:
		visible = false
	elif LevelManager.show_map == true:
		visible = true
		update_stats()
		update_type()
		update_gems()
		update_materials()
		visual_update_stats()
		
func update_stats():
	health = SaveManager.autosave_data.player_data.health
	max_health = SaveManager.autosave_data.player_data.max_health
	shield = SaveManager.autosave_data.player_data.shield
	base_action1 = PlayerManager.player.base_action1
	base_action2 = PlayerManager.player.base_action2
	base_action3 = PlayerManager.player.base_action3

func update_gems():
	$Gems/GemsNumbers/RedGemNumber.text = ": " + str(SaveManager.autosave_data.gems.red_gem)
	$Gems/GemsNumbers/GreenGemNumber.text = ": " + str(SaveManager.autosave_data.gems.green_gem)
	$Gems/GemsNumbers/BlueGemNumber.text = ": " + str(SaveManager.autosave_data.gems.blue_gem)
	$Gems/GemsNumbers/YellowGemNumber.text = ": " + str(SaveManager.autosave_data.gems.yellow_gem)
	$Gems/GemsNumbers/CoinNumber.text = ": " + str(SaveManager.autosave_data.player_data.coins)

func update_materials():
	$Material/WoodLabel.text = ": " + str(SaveManager.autosave_data.materials.wood)
	$Material/StoneLabel.text = ": " + str(SaveManager.autosave_data.materials.stone)
	$Material/IronLabel.text = ": " + str(SaveManager.autosave_data.materials.iron)

func update_type():
	if SaveManager.autosave_data.player_data.type == "Rogue":
		$Playerback/PlayerPortret.texture = load("res://assets/32rogues/portrets/rogue.png")
		$PlayerType.text = "Rogue"
	elif SaveManager.autosave_data.player_data.type == "Barbarian":
		$Playerback/PlayerPortret.texture = load("res://assets/32rogues/portrets/barbarian.png")
		$PlayerType.text = "Barbarian"
		
func visual_update_stats():
	$Stats/StatsNumbers/HealthNumber.text = str(health)
	$Stats/StatsNumbers/MaxHealthNumber.text = str(max_health)
	$Stats/StatsNumbers/ShieldNumber.text = str(shield)
	$Stats/StatsNumbers/BaseAction1Number.text = str(base_action1.x) + " - " + str(base_action1.y)
	$Stats/StatsNumbers/BaseAction2Number.text = str(base_action2.x) + " - " + str(base_action2.y)
	$Stats/StatsNumbers/BaseAction3Number.text = str(base_action3.x) + " - " + str(base_action3.y)
	if SaveManager.autosave_data.player_data.type == "Rogue":
		$Stats/StatsNames/BaseAction1.text = "Sword Damage"
		$Stats/StatsNames/BaseAction2.text = "Bow Damage"
		$Stats/StatsNames/BaseAction3.visible = false
		$Stats/StatsNumbers/BaseAction3Number. visible = false
	elif SaveManager.autosave_data.player_data.type == "Barbarian":
		$Stats/StatsNames/BaseAction1.text = "Axe Damage"
		$Stats/StatsNames/BaseAction2.text = "Mace Damage"
		$Stats/StatsNames/BaseAction3.visible = false
		$Stats/StatsNumbers/BaseAction3Number. visible = false
		
func check_run_time():
	run_time.text = "Run Time:" + "\n" + str(RunStats.run_timer)

func _on_home_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)

func _on_home_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	$Pause.visible = true
	hide_tutorial()


func _on_back_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	$Pause/Back/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
	$Pause/Progress.visible = true
	$Pause/Progress.text = "Press Back to return to the game"
func _on_back_mouse_exited():
	$Pause/Back/Label.add_theme_color_override("font_color", Color.WHITE)
	$Pause/Progress.visible = false

func _on_back_pressed():
	$Pause/Settings.save_settings()
	Sfx.play_SFX(Sfx.button_confirm)
	$Pause.visible = false

func _on_menu_pressed():
	$Pause/Settings.save_settings()
	Sfx.play_SFX(Sfx.button_confirm)
	$Pause.visible = false
	choose_random_f()
	LevelManager.back_to_village()

func _on_menu_mouse_entered():
	$Pause/Menu/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
	Sfx.play_SFX(Sfx.in_game_hover)
	$Pause/Progress.visible = true
	$Pause/Progress.text = "Press Exit to return to the village 
	Please note all loot and progress will be lost"
func _on_menu_mouse_exited():
	$Pause/Menu/Label.add_theme_color_override("font_color", Color.WHITE)
	$Pause/Progress.visible = false

func show_tutorial():
	$InfoPage.visible = true
	$InfoPageHeader.visible = true
	$InfoLabel.visible = true
	$InfoPageDetails.visible = true
	
func hide_tutorial():
	$InfoPage.visible = false
	$InfoPageHeader.visible = false
	$InfoLabel.visible = false
	$InfoPageDetails.visible = false

func _on_info_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	show_tutorial()
func _on_info_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	$Info/TextureRect.modulate = Color(0.537, 0.558, 0.828)
func _on_info_mouse_exited():
	$Info/TextureRect.modulate = Color(0.369, 0.38, 0.675)
func _on_back_button_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	hide_tutorial()
func _on_back_button_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
