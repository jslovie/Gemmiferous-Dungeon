extends Control

func _ready():
	$EnemySprite.visible = true
	$Trap.visible = false
	
func _process(_delta):
	update_treasures()
	update_materials()
	update_enemy_sprite()

func update_enemy_sprite():
	if PlayerManager.player.status == "dead":
		type_check()


func type_check():
	if EnemyManager.enemy.type == "Skeleton":
		var skeleton_texture = load("res://assets/32rogues/enem/skeleton.png")
		$EnemySprite.texture = skeleton_texture
	elif EnemyManager.enemy.type == "Spider":
		var spider_texture = load("res://assets/32rogues/enem/spider.png")
		$EnemySprite.texture = spider_texture
	elif EnemyManager.enemy.type == "SkeletonArcher":
		var skeleton_archer_texture = load("res://assets/32rogues/enem/skeleton_archer.png")
		$EnemySprite.texture = skeleton_archer_texture
	elif EnemyManager.enemy.type == "SkeletonMage":
		var skeleton_mage_texture = load("res://assets/32rogues/enem/skeleton_mage.png")
		$EnemySprite.texture = skeleton_mage_texture
	elif EnemyManager.enemy.type == "Hag":
		var hag_texture = load("res://assets/32rogues/enem/hag.png")
		$EnemySprite.texture = hag_texture
	elif EnemyManager.enemy.type == "Rat":
		var rat_texture = load("res://assets/32rogues/enem/rat.png")
		$EnemySprite.texture = rat_texture
	elif EnemyManager.enemy.type == "Zombie":
		var zombie_texture = load("res://assets/32rogues/enem/zombie.png")
		$EnemySprite.texture = zombie_texture
	elif EnemyManager.enemy.type == "Ghost":
		var ghost_texture = load("res://assets/32rogues/enem/ghost.png")
		$EnemySprite.texture = ghost_texture
	elif EnemyManager.enemy.type == "Ghost Warrior":
		var ghost_warrior_texture = load("res://assets/32rogues/enem/ghost_warrior.png")
		$EnemySprite.texture = ghost_warrior_texture
	elif EnemyManager.enemy.type == "Ghoul":
		var ghoul_texture = load("res://assets/32rogues/enem/ghoul.png")
		$EnemySprite.texture = ghoul_texture
	elif EnemyManager.enemy.type == "Demon Boss":
		var demon_boss_texture = load("res://assets/32rogues/enem/demon_boss.png")
		$EnemySprite.texture = demon_boss_texture
	elif EnemyManager.enemy.type == "Devil Boss":
		var devil_boss_texture = load("res://assets/32rogues/enem/devil_boss.png")
		$EnemySprite.texture = devil_boss_texture
	elif EnemyManager.enemy.type == "Dragon Boss":
		var dragon_boss_texture = load("res://assets/32rogues/enem/dragon_boss.png")
		$EnemySprite.texture = dragon_boss_texture
	elif EnemyManager.enemy.type == "Trap":
		$EnemySprite.visible = false
		$Trap.visible = true
		
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


func _on_exit_pressed():
	SaveManager.savefilesave()
	get_tree().change_scene_to_file("res://scenes/village.tscn")
