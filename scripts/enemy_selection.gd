extends Node2D

@export var enemy : String

func _ready():
	select_enemy()
	print(enemy)


func select_enemy():
	enemy = EnemyManager.enemy_type
	if enemy == "Skeleton":
		var skeleton = preload("res://scenes/enemies/skeleton_enemy_type.tscn").instantiate()
		skeleton.global_position = $Controllable_player.global_position
		add_child(skeleton)
	elif enemy == "Spider":
		var spider = preload("res://scenes/enemies/spider_enemy_type.tscn").instantiate()
		spider.global_position = $Controllable_player.global_position
		add_child(spider)
	elif enemy == "Skeleton Mage":
		var skeleton_mage = preload("res://scenes/enemies/skeleton_mage_enemy_type.tscn").instantiate()
		skeleton_mage.global_position = $Controllable_player.global_position
		add_child(skeleton_mage)
	elif enemy == "Skeleton Archer":
		var skeleton_archer = preload("res://scenes/enemies/skeleton_archer_enemy_type.tscn").instantiate()
		skeleton_archer.global_position = $Controllable_player.global_position
		add_child(skeleton_archer)
