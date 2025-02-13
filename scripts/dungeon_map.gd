extends CanvasLayer

var base_action1
var base_action2
var base_action3
var health 
var max_health 
var shield 
var xp 


func _ready():
	LevelManager.show_map = false

func _process(_delta):
	dungeon_map()
	choose_map()

func choose_map():
	if LevelManager.floor == 1:
		$Dungeons/DungeonF1_1.visible = true
		$Dungeons/DungeonF2_1.visible = false
		$Dungeons/DungeonF3_1.visible = false
		$Dungeons/DungeonF4_1.visible = false
	elif LevelManager.floor == 2:
		$Dungeons/DungeonF1_1.visible = false
		$Dungeons/DungeonF2_1.visible = true
		$Dungeons/DungeonF3_1.visible = false
		$Dungeons/DungeonF4_1.visible = false
	elif LevelManager.floor == 3:
		$Dungeons/DungeonF1_1.visible = false
		$Dungeons/DungeonF2_1.visible = false
		$Dungeons/DungeonF3_1.visible = true
		$Dungeons/DungeonF4_1.visible = false
	elif LevelManager.floor == 4:
		$Dungeons/DungeonF1_1.visible = false
		$Dungeons/DungeonF2_1.visible = false
		$Dungeons/DungeonF3_1.visible = false
		$Dungeons/DungeonF4_1.visible = true
		
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
		
