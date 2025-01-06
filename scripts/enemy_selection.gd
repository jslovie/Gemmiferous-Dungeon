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
