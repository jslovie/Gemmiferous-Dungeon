class_name Player
extends CharacterBody2D

enum{alive, dead}
var state
var status = "alive"

var first_spawn = true

var sword_damage = 3.0
var magic_damage = 3.0
var bow_damage = 3.0
var health = 50
var max_health = 50
var shield = 0
var shield_load = 0
var xp = 0
var coins = 0
var piece_multiplier = 1



func _ready():
	state = alive
	PlayerManager.player = self
	load_handle()

func load_handle():
	if first_spawn == true:
		first_spawn = false
		SaveManager.autosave()
	else:
		SaveManager.load_autosave()
		

func sword_attack():
	EnemyManager.enemy.take_damage(sword_damage)

func magic_attack():
	EnemyManager.enemy.take_damage(magic_damage)

func bow_attack():
	EnemyManager.enemy.take_damage(bow_damage)

func shield_up(amount):
	shield += amount

func xp_up():
	xp += 1

func get_coins(amount):
	coins += amount

func receive_damage(damage):
	if state == alive:
		#Visual knockback
		var tween_scale = create_tween()
		tween_scale.tween_property($Character,"scale", Vector2(16,16), 0.1)
		tween_scale.tween_property($Character,"scale", Vector2(15,15), 0.1)
		var tween_move = create_tween()
		tween_move.tween_property($Character, "position", Vector2(0,-100), 0.1)
		tween_move.tween_property($Character, "position", Vector2(0, 0), 0.1)
		#Visual hit
		%AnimationPlayer.play("hit")
		#Logic behind getting hit
		var health_attack = 0
		for d in range(0, damage):
			if shield > 0:
				shield -= 1
			else:
				health_attack += 1
		var total_attack = health_attack * EnemyManager.enemy.hit_multiplier
		health -= total_attack
		
		if health <= 0:
			health = 0
			get_killed()

func get_killed():
	state = dead
	status = "dead"
	
	%AnimationPlayer.play("hit")
	var tween_scale = create_tween()
	tween_scale.tween_property($Character,"scale", Vector2(16,16), 0.1)
	tween_scale.tween_property($Character,"scale", Vector2(15,15), 0.1)
	var tween_move = create_tween()
	tween_move.tween_property($Character, "position", Vector2(-800,0), 0.5)
	var tween_rotate = create_tween()
	tween_rotate.tween_property($Character, "rotation", deg_to_rad(-90), 0.5)
	
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/dungeons/test_world.tscn")
