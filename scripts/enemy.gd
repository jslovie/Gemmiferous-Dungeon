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

func _ready():
	stat_check()
	state = alive
	EnemyManager.enemy = self
	%ActionTimer.start()

func _process(delta):
	pass

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
	Type_check()
	
func Type_check():
	if type == "Skeleton":
		var skeleton_texture = load("res://assets/32rogues/enem/skeleton.png")
		%EnemyType.texture = skeleton_texture
		%ActionTimer.wait_time = 4
	elif type == "Spider":
		var spider_texture = load("res://assets/32rogues/enem/spider.png")
		%EnemyType.texture = spider_texture
		%ActionTimer.wait_time = 3
	elif type == "SkeletonArcher":
		var skeleton_archer_texture = load("res://assets/32rogues/enem/skeleton_archer.png")
		%EnemyType.texture = skeleton_archer_texture
		%ActionTimer.wait_time = 5
	elif type == "SkeletonMage":
		var skeleton_mage_texture = load("res://assets/32rogues/enem/skeleton_mage.png")
		%EnemyType.texture = skeleton_mage_texture
		%ActionTimer.wait_time = 3	

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
		if type == "spider":
			%AnimationPlayer.play("hit_spider")
		elif type == "skeleton" or "skeleton_archer" or "skeleton_mage":
			%AnimationPlayer.play("hit_skeleton")
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
	
	##Visual hit
	if type == "spider":
		%AnimationPlayer.play("hit_spider")
	elif type == "skeleton" or "skeleton_archer" or "skeleton_mage":
		%AnimationPlayer.play("hit_skeleton")
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
	PlayerManager.update_stats()
	
	#Scene change
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/dungeons/between_level.tscn")
	LevelManager.show_map = true
	

func _on_action_timer_timeout():
	random_action()
