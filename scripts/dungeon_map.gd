extends CanvasLayer

var damage1
var damage2
var damage3
var health 
var max_health 
var shield 
var xp 
var coins
var materials


func _ready():
	LevelManager.show_map = false
	#initial_update_stats()

func _process(_delta):
	dungeon_map()
	visual_update_stats()
	
func dungeon_map():
	if LevelManager.show_map == false:
		visible = false
	elif LevelManager.show_map == true:
		visible = true
		update_stats()

func update_stats():
	health = SaveManager.autosave_data.player_data.health
	max_health = SaveManager.autosave_data.player_data.max_health
	shield = SaveManager.autosave_data.player_data.shield
	damage1 = SaveManager.autosave_data.player_data.damage1
	damage2 = SaveManager.autosave_data.player_data.damage2
	damage3 = SaveManager.autosave_data.player_data.damage3
	coins = SaveManager.autosave_data.player_data.coins
	materials = SaveManager.autosave_data.player_data.materials
	
func visual_update_stats():
	$Stats/StatsNumbers/HealthNumber.text = str(health)
	$Stats/StatsNumbers/MaxHealthNumber.text = str(max_health)
	$Stats/StatsNumbers/ShieldNumber.text = str(shield)
	$Stats/StatsNumbers/Damage1Number.text = str(damage1)
	$Stats/StatsNumbers/Damage2Number.text = str(damage2)
	$Stats/StatsNumbers/Damage3Number.text = str(damage3)
	$Stats/StatsNumbers/CoinsNumber.text = str(coins)
	$Stats/StatsNumbers/MaterialsNumber.text = str(materials)
