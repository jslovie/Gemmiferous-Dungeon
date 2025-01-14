class_name Player
extends CharacterBody2D

#Status
enum{alive, dead}
var state
var status = "alive"

#Stats
var damage1 = 3.0
var damage2 = 3.0
var damage3 = 3.0
var health = 50
var max_health = 50
var shield = 0
var shield_load = 3
var coins = 0
var materials = 0
var piece_multiplier = 1
var spawned = false

#Gems
var red_gem = 0
var yellow_gem = 0
var green_gem = 0
var blue_gem = 0


func _ready():
	state = alive
	PlayerManager.player = self

func damage1_attack():
	EnemyManager.enemy.take_damage(damage1)

func damage2_attack():
	EnemyManager.enemy.take_damage(damage2)

func damage3_attack():
	EnemyManager.enemy.take_damage(damage3)

func shield_up(amount):
	if EnemyManager.enemy.status == "alive":
		shield += amount
		
func material_up():
	if EnemyManager.enemy.status == "alive":
		materials += 1

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
	SaveManager.remove_autosave()
	get_tree().quit()
