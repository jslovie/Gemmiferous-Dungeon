extends Node2D

@export var enemy : String

func _ready():
	select_enemy()
	print(enemy)


func select_enemy():
	enemy = EnemyManager.type
	if enemy == "Spider":
		var spider = preload("res://scenes/enemies/spider_enemy_type.tscn").instantiate()
		spider.global_position = $Controllable_player.global_position
		add_child(spider)
	elif enemy == "Rat":
		var rat = preload("res://scenes/enemies/rat_enemy_type.tscn").instantiate()
		rat.global_position = $Controllable_player.global_position
		add_child(rat)
	elif enemy == "Hag":
		var hag = preload("res://scenes/enemies/hag_enemy_type.tscn").instantiate()
		hag.global_position = $Controllable_player.global_position
		add_child(hag)
	elif enemy == "Ghost":
		var ghost = preload("res://scenes/enemies/ghost_enemy_type.tscn").instantiate()
		ghost.global_position = $Controllable_player.global_position
		add_child(ghost)
	elif enemy == "Ghoul":
		var ghoul = preload("res://scenes/enemies/ghoul_enemy_type.tscn").instantiate()
		ghoul.global_position = $Controllable_player.global_position
		add_child(ghoul)
	elif enemy == "Zombie":
		var zombie = preload("res://scenes/enemies/zombie_enemy_type.tscn").instantiate()
		zombie.global_position = $Controllable_player.global_position
		add_child(zombie)
	elif enemy == "Skeleton":
		var skeleton = preload("res://scenes/enemies/skeleton_enemy_type.tscn").instantiate()
		skeleton.global_position = $Controllable_player.global_position
		add_child(skeleton)
	elif enemy == "Skeleton Mage":
		var skeleton_mage = preload("res://scenes/enemies/skeleton_mage_enemy_type.tscn").instantiate()
		skeleton_mage.global_position = $Controllable_player.global_position
		add_child(skeleton_mage)
	elif enemy == "Skeleton Archer":
		var skeleton_archer = preload("res://scenes/enemies/skeleton_archer_enemy_type.tscn").instantiate()
		skeleton_archer.global_position = $Controllable_player.global_position
		add_child(skeleton_archer)
	elif enemy == "Demon Boss":
		var demon_boss = preload("res://scenes/enemies/demon_boss_enemy_type.tscn").instantiate()
		demon_boss.global_position = $Controllable_player.global_position
		add_child(demon_boss)
	elif enemy == "Devil Boss":
		var devil_boss = preload("res://scenes/enemies/devil_boss_enemy_type.tscn").instantiate()
		devil_boss.global_position = $Controllable_player.global_position
		add_child(devil_boss)	
	elif enemy == "Dragon Boss":
		var dragon_boss = preload("res://scenes/enemies/dragon_boss_enemy_type.tscn").instantiate()
		dragon_boss.global_position = $Controllable_player.global_position
		add_child(dragon_boss)	
		
		
	print("Enemy is : " + str(enemy))
