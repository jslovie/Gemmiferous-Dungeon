extends Control

signal update_total_bar

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
	$Who.visible = true
	$Who.text = EnemyManager.enemy.type
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
	elif EnemyManager.enemy.type == "Wolf":
		var wolf_texture = load("res://assets/32rogues/enem/wolf.png")
		$EnemySprite.texture = wolf_texture
	elif EnemyManager.enemy.type == "Lamprey":
		var lamprey_texture = load("res://assets/32rogues/enem/lamprey.png")
		$EnemySprite.texture = lamprey_texture
	elif EnemyManager.enemy.type == "Crone":
		var crone_texture = load("res://assets/32rogues/enem/crone.png")
		$EnemySprite.texture = crone_texture
	elif EnemyManager.enemy.type == "Ratten":
		var ratten_texture = load("res://assets/32rogues/enem/ratten.png")
		$EnemySprite.texture = ratten_texture
	elif EnemyManager.enemy.type == "Rattena":
		var rattena_texture = load("res://assets/32rogues/enem/rattena.png")
		$EnemySprite.texture = rattena_texture
	elif EnemyManager.enemy.type == "Shroom":
		var shroom_texture = load("res://assets/32rogues/enem/shroom.png")
		$EnemySprite.texture = shroom_texture
	elif EnemyManager.enemy.type == "Gnome":
		var gnome_texture = load("res://assets/32rogues/enem/gnome.png")
		$EnemySprite.texture = gnome_texture
	elif EnemyManager.enemy.type == "Warewolf":
		var warewolf_texture = load("res://assets/32rogues/enem/warewolf.png")
		$EnemySprite.texture = warewolf_texture
	elif EnemyManager.enemy.type == "Gator":
		var gator_texture = load("res://assets/32rogues/enem/gator.png")
		$EnemySprite.texture = gator_texture
	elif EnemyManager.enemy.type == "Medusa":
		var medusa_texture = load("res://assets/32rogues/enem/medusa.png")
		$EnemySprite.texture = medusa_texture
	elif EnemyManager.enemy.type == "Minotaur":
		var minotaur_texture = load("res://assets/32rogues/enem/minotaur.png")
		$EnemySprite.texture = minotaur_texture
	elif EnemyManager.enemy.type == "Leshen":
		var leshen_texture = load("res://assets/32rogues/enem/leshen.png")
		$EnemySprite.texture = leshen_texture
	elif EnemyManager.enemy.type == "Priest":
		var priest_texture = load("res://assets/32rogues/enem/priest.png")
		$EnemySprite.texture = priest_texture
	elif EnemyManager.enemy.type == "Mystic":
		var mystic_texture = load("res://assets/32rogues/enem/mystic.png")
		$EnemySprite.texture = mystic_texture
	elif EnemyManager.enemy.type == "Sly":
		var sly_texture = load("res://assets/32rogues/enem/sly.png")
		$EnemySprite.texture = sly_texture
	elif EnemyManager.enemy.type == "Mystery":
		var mystery_texture = load("res://assets/32rogues/enem/mystery.png")
		$EnemySprite.texture = mystery_texture
	elif EnemyManager.enemy.type == "Wraith":
		var wraith_texture = load("res://assets/32rogues/enem/wraith.png")
		$EnemySprite.texture = wraith_texture
	elif EnemyManager.enemy.type == "Basilisk":
		var basilisk_texture = load("res://assets/32rogues/enem/basilisk.png")
		$EnemySprite.texture = basilisk_texture
	elif EnemyManager.enemy.type == "Formicidae":
		var formicidae_texture = load("res://assets/32rogues/enem/formicidae.png")
		$EnemySprite.texture = formicidae_texture
	elif EnemyManager.enemy.type == "Divine":
		var divine_texture = load("res://assets/32rogues/enem/divine.png")
		$EnemySprite.texture = divine_texture
	elif EnemyManager.enemy.type == "Centipeda":
		var centipeda_texture = load("res://assets/32rogues/enem/centipeda.png")
		$EnemySprite.texture = centipeda_texture
	elif EnemyManager.enemy.type == "Nemean":
		var nemean_texture = load("res://assets/32rogues/enem/nemean.png")
		$EnemySprite.texture = nemean_texture
	elif EnemyManager.enemy.type == "Torment":
		var torment_texture = load("res://assets/32rogues/enem/torment.png")
		$EnemySprite.texture = torment_texture
	elif EnemyManager.enemy.type == "Haidomyrmecinae":
		var haidomyrmecinae_texture = load("res://assets/32rogues/enem/haidomyrmecinae.png")
		$EnemySprite.texture = haidomyrmecinae_texture
	elif EnemyManager.enemy.type == "Angel":
		var angel_texture = load("res://assets/32rogues/enem/angel.png")
		$EnemySprite.texture = angel_texture
	elif EnemyManager.enemy.type == "Microchaetus":
		var microchaetus_texture = load("res://assets/32rogues/enem/microchaetus.png")
		$EnemySprite.texture = microchaetus_texture
	elif EnemyManager.enemy.type == "Torment Us":
		var torment_us_texture = load("res://assets/32rogues/enem/torment_us.png")
		$EnemySprite.texture = torment_us_texture
	elif EnemyManager.enemy.type == "Trap":
		$Who.visible = false
		$EnemySprite.visible = false
		$Trap.visible = true
		
func update_treasures():
	$Gems/GemsNumbers/RedGemNumber.text = ": " + str(PlayerManager.player.red_gem_died)
	$Gems/GemsNumbers/GreenGemNumber.text = ": " + str(PlayerManager.player.green_gem_died)
	$Gems/GemsNumbers/BlueGemNumber.text = ": " + str(PlayerManager.player.blue_gem_died)
	$Gems/GemsNumbers/YellowGemNumber.text = ": " + str(PlayerManager.player.yellow_gem_died)
	$Gems/GemsNumbers/CoinNumber.text = ": " + str(PlayerManager.player.coins_died)
	
func update_materials():
	$Material/WoodLabel.text = ": " + str(PlayerManager.player.wood_died)
	$Material/StoneLabel.text = ": " + str(PlayerManager.player.stone_died)
	$Material/IronLabel.text = ": " + str(PlayerManager.player.iron_died)


func _on_exit_pressed():
	SaveManager.savefilesave()
	LevelManager.reset_map()
	RelicManager.reset_pieces_relics()
	emit_signal("update_total_bar")
	await get_tree().create_timer(2.5).timeout
	get_tree().change_scene_to_file("res://scenes/village.tscn")
