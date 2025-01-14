class_name Enemy
extends CharacterBody2D

enum {alive, dead}
var state
var status = "alive"


var type = "spider"
var health = 20
var health_increase = 5
var max_health = 20
var shield = 5
var shield_increase = 3
var damage = 5
var coin_worth = 5
var hit_multiplier = 1
var action_delay = 0
var blood_type

@onready var time = $ActionTimer

func _ready():
	stat_check()
	state = alive
	EnemyManager.enemy = self
	change_delay()
	%ActionTimer.start()
	
func _process(_delta):
	%Label.text = str(time.time_left)

	
func stat_check():
	type = EnemyManager.type
	health = EnemyManager.health
	health_increase = EnemyManager.health_increase
	max_health = EnemyManager.max_health
	shield = EnemyManager.shield
	shield_increase = EnemyManager.shield_increase
	damage = EnemyManager.damage
	coin_worth = EnemyManager.coin_worth
	hit_multiplier = EnemyManager.hit_multiplier
	action_delay = EnemyManager.action_delay
	blood_type = EnemyManager.blood_type
	Type_check()
	
func Type_check():
	if type == "Skeleton":
		var skeleton_texture = load("res://assets/32rogues/enem/skeleton.png")
		%EnemyType.texture = skeleton_texture
	elif type == "Spider":
		var spider_texture = load("res://assets/32rogues/enem/spider.png")
		%EnemyType.texture = spider_texture
	elif type == "SkeletonArcher":
		var skeleton_archer_texture = load("res://assets/32rogues/enem/skeleton_archer.png")
		%EnemyType.texture = skeleton_archer_texture
	elif type == "SkeletonMage":
		var skeleton_mage_texture = load("res://assets/32rogues/enem/skeleton_mage.png")
		%EnemyType.texture = skeleton_mage_texture
	elif type == "Hag":
		var hag_texture = load("res://assets/32rogues/enem/hag.png")
		%EnemyType.texture = hag_texture
	elif type == "Rat":
		var rat_texture = load("res://assets/32rogues/enem/rat.png")
		%EnemyType.texture = rat_texture
	elif type == "Zombie":
		var zombie_texture = load("res://assets/32rogues/enem/zombie.png")
		%EnemyType.texture = zombie_texture
	elif type == "Ghost":
		var ghost_texture = load("res://assets/32rogues/enem/ghost.png")
		%EnemyType.texture = ghost_texture
	elif type == "Ghost Warrior":
		var ghost_warrior_texture = load("res://assets/32rogues/enem/ghost_warrior.png")
		%EnemyType.texture = ghost_warrior_texture
	elif type == "Ghoul":
		var ghoul_texture = load("res://assets/32rogues/enem/ghoul.png")
		%EnemyType.texture = ghoul_texture
	elif type == "Demon Boss":
		var demon_boss_texture = load("res://assets/32rogues/enem/demon_boss.png")
		%EnemyType.texture = demon_boss_texture
	elif type == "Devil Boss":
		var devil_boss_texture = load("res://assets/32rogues/enem/devil_boss.png")
		%EnemyType.texture = devil_boss_texture
	elif type == "Dragon Boss":
		var dragon_boss_texture = load("res://assets/32rogues/enem/dragon_boss.png")
		%EnemyType.texture = dragon_boss_texture

func change_delay():
	%ActionTimer.wait_time = action_delay
	print(%ActionTimer.wait_time)

func random_action():
	var random = Random.get_rng()
		
	if random == "attack":
		inflict_damage()
		%SwordPiece.visible = true
		await get_tree().create_timer(2.0).timeout
		%SwordPiece.visible = false
			
	if random == "shield":
		shield_up()
		%ShieldPiece.visible = true
		await get_tree().create_timer(2.0).timeout
		%ShieldPiece.visible = false
			
	if random == "heal":
		heal()
		%HealPiece.visible = true
		await get_tree().create_timer(2.0).timeout
		%HealPiece.visible = false
			
func inflict_damage():
	PlayerManager.player.receive_damage(damage)

func shield_up():
	shield += shield_increase

func heal():
	health += health_increase
	if health >= max_health:
		health = max_health

func take_damage(damage):
	if state == alive:
		#Visual knockback
		var tween_scale = create_tween()
		tween_scale.tween_property($EnemyType,"scale", Vector2(16,16), 0.1)
		tween_scale.tween_property($EnemyType,"scale", Vector2(15,15), 0.1)
		var tween_move = create_tween()
		tween_move.tween_property($EnemyType, "position", Vector2(0,-100), 0.1)
		tween_move.tween_property($EnemyType, "position", Vector2(0, 0), 0.1)
		#Visual hit
		if blood_type == "Green":
			%AnimationPlayer.play("hit_green")
		elif blood_type == "White":
			%AnimationPlayer.play("hit_white")
		elif blood_type == "Ghost":
			%AnimationPlayer.play("hit_ghost")
		elif blood_type == "Red":
			%AnimationPlayer.play("hit_red")
		#Logic behind getting hit
		var health_attack = 0
		for d in range(0, damage):
			if shield > 0:
				shield -= 1
			else:
				health_attack += 1
		var total_attack = health_attack * PlayerManager.player.piece_multiplier
		health -= total_attack
		
		if health <= 0:
			health = 0
			get_killed()

func get_killed():
	#Status change and stop for actions
	state = dead
	status = "dead"
	PlayerManager.player.get_coins(coin_worth)
	%ActionTimer.stop()
	%Actions.visible = false
	
	#Visual hit
	if blood_type == "Green":
		%AnimationPlayer.play("hit_green")
	elif blood_type == "White":
		%AnimationPlayer.play("hit_white")
	elif blood_type == "Ghost":
		%AnimationPlayer.play("hit_ghost")
	elif blood_type == "Red":
			%AnimationPlayer.play("hit_red")
			
	var tween_scale = create_tween()
	tween_scale.tween_property($EnemyType,"scale", Vector2(16,16), 0.1)
	tween_scale.tween_property($EnemyType,"scale", Vector2(15,15), 0.1)
	var tween_move = create_tween()
	tween_move.tween_property($EnemyType, "position", Vector2(800,0), 0.5)
	var tween_rotate = create_tween()
	tween_rotate.tween_property($EnemyType, "rotation", deg_to_rad(90), 0.5)
	
	#Autosave
	SaveManager.autosave()
	
	#Update player stats
	#PlayerManager.update_stats()
	
	#Scene change
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	LevelManager.show_map = true
	

func _on_action_timer_timeout():
	random_action()
