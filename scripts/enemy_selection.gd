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
	elif enemy == "Ghost Warrior":
		var ghost_warrior = preload("res://scenes/enemies/ghost_warrior_enemy_type.tscn").instantiate()
		ghost_warrior.global_position = $Controllable_player.global_position
		add_child(ghost_warrior)
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
	elif enemy == "Wolf":
		var wolf = preload("res://scenes/enemies/wolf_enemy_type.tscn").instantiate()
		wolf.global_position = $Controllable_player.global_position
		add_child(wolf)
	elif enemy == "Lamprey":
		var lamprey = preload("res://scenes/enemies/lamprey_enemy_type.tscn").instantiate()
		lamprey.global_position = $Controllable_player.global_position
		add_child(lamprey)
	elif enemy == "Crone":
		var crone = preload("res://scenes/enemies/crone_enemy_type.tscn").instantiate()
		crone.global_position = $Controllable_player.global_position
		add_child(crone)
	elif enemy == "Ratten":
		var ratten = preload("res://scenes/enemies/ratten_enemy_type.tscn").instantiate()
		ratten.global_position = $Controllable_player.global_position
		add_child(ratten)
	elif enemy == "Rattena":
		var rattena = preload("res://scenes/enemies/rattena_enemy_type.tscn").instantiate()
		rattena.global_position = $Controllable_player.global_position
		add_child(rattena)
	elif enemy == "Shroom":
		var shroom = preload("res://scenes/enemies/shroom_enemy_type.tscn").instantiate()
		shroom.global_position = $Controllable_player.global_position
		add_child(shroom)
	elif enemy == "Gnome":
		var gnome = preload("res://scenes/enemies/gnome_enemy_type.tscn").instantiate()
		gnome.global_position = $Controllable_player.global_position
		add_child(gnome)
	elif enemy == "Warewolf":
		var warewolf = preload("res://scenes/enemies/warewolf_enemy_type.tscn").instantiate()
		warewolf.global_position = $Controllable_player.global_position
		add_child(warewolf)
	elif enemy == "Gator":
		var gator = preload("res://scenes/enemies/gator_enemy_type.tscn").instantiate()
		gator.global_position = $Controllable_player.global_position
		add_child(gator)
	elif enemy == "Leshen":
		var leshen = preload("res://scenes/enemies/leshen_enemy_type.tscn").instantiate()
		leshen.global_position = $Controllable_player.global_position
		add_child(leshen)
	elif enemy == "Medusa":
		var medusa = preload("res://scenes/enemies/medusa_enemy_type.tscn").instantiate()
		medusa.global_position = $Controllable_player.global_position
		add_child(medusa)
	elif enemy == "Minotaur":
		var minotaur = preload("res://scenes/enemies/minotaur_enemy_type.tscn").instantiate()
		minotaur.global_position = $Controllable_player.global_position
		add_child(minotaur)
	elif enemy == "Priest":
		var priest = preload("res://scenes/enemies/priest_enemy_type.tscn").instantiate()
		priest.global_position = $Controllable_player.global_position
		add_child(priest)
	elif enemy == "Mystic":
		var mystic = preload("res://scenes/enemies/mystic_enemy_type.tscn").instantiate()
		mystic.global_position = $Controllable_player.global_position
		add_child(mystic)
	elif enemy == "Sly":
		var sly = preload("res://scenes/enemies/sly_enemy_type.tscn").instantiate()
		sly.global_position = $Controllable_player.global_position
		add_child(sly)
	elif enemy == "Mystery":
		var mystery = preload("res://scenes/enemies/mystery_enemy_type.tscn").instantiate()
		mystery.global_position = $Controllable_player.global_position
		add_child(mystery)
	elif enemy == "Wraith":
		var wraith = preload("res://scenes/enemies/wraith_enemy_type.tscn").instantiate()
		wraith.global_position = $Controllable_player.global_position
		add_child(wraith)
	elif enemy == "Basilisk":
		var basilisk = preload("res://scenes/enemies/basilisk_enemy_type.tscn").instantiate()
		basilisk.global_position = $Controllable_player.global_position
		add_child(basilisk)
	elif enemy == "Formicidae":
		var formicidae = preload("res://scenes/enemies/formicidae_enemy_type.tscn").instantiate()
		formicidae.global_position = $Controllable_player.global_position
		add_child(formicidae)
	elif enemy == "Divine":
		var divine = preload("res://scenes/enemies/divine_enemy_type.tscn").instantiate()
		divine.global_position = $Controllable_player.global_position
		add_child(divine)
	elif enemy == "Centipeda":
		var centipeda = preload("res://scenes/enemies/centipeda_enemy_type.tscn").instantiate()
		centipeda.global_position = $Controllable_player.global_position
		add_child(centipeda)
	elif enemy == "Nemean":
		var nemean = preload("res://scenes/enemies/nemean_enemy_type.tscn").instantiate()
		nemean.global_position = $Controllable_player.global_position
		add_child(nemean)
	elif enemy == "Torment":
		var torment = preload("res://scenes/enemies/torment_enemy_type.tscn").instantiate()
		torment.global_position = $Controllable_player.global_position
		add_child(torment)
	elif enemy == "Haidomyrmecinae":
		var haidomyrmecinae = preload("res://scenes/enemies/haidomyrmecinae_enemy_type.tscn").instantiate()
		haidomyrmecinae.global_position = $Controllable_player.global_position
		add_child(haidomyrmecinae)
	elif enemy == "Angel":
		var angel = preload("res://scenes/enemies/angel_enemy_type.tscn").instantiate()
		angel.global_position = $Controllable_player.global_position
		add_child(angel)
	elif enemy == "Microchaetus":
		var microchaetus = preload("res://scenes/enemies/microchaetus_enemy_type.tscn").instantiate()
		microchaetus.global_position = $Controllable_player.global_position
		add_child(microchaetus)
	elif enemy == "Torment Us":
		var torment_us = preload("res://scenes/enemies/torment_us_enemy_type.tscn").instantiate()
		torment_us.global_position = $Controllable_player.global_position
		add_child(torment_us)

	print("Enemy is : " + str(enemy))
