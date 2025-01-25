class_name Player
extends CharacterBody2D

signal rage_up

#Status
enum{alive, dead}
var state
var status = "alive"
@export var type : String

#Stats
@export var test_stats : Vector2
@export var type_action1 : float
@export var type_action2 : float
@export var type_action3 : float
@export var upgraded_action1 : float
@export var upgraded_action2 : float
@export var upgraded_action3 : float
var base_action1 : float
var base_action2 : float
var base_action3 : float
var action1 = 0
var action2 = 0
var action3 = 0

@export var health : float
@export var max_health : float
@export var shield : int
var shield_load = 3
var coins = 0
var materials = 0
var piece_multiplier = 1
var spawned = false
var spins_left = 0

#Weapon Statuses
var has_mace = false
var mace_stunt_chance = 10
var rage = 0

#Gems
var red_gem = 0
var yellow_gem = 0
var green_gem = 0
var blue_gem = 0

var rng = RandomNumberGenerator.new()

var mace_stunt_rarities = {
	"nothing" : 100,
	"stunt" : mace_stunt_chance,
}

#func print_test():
	#print("Player Health is: " + str(health))
	#print("Player Action1 is: " + str(base_action1))
	#print(type)

func _ready():
	state = alive
	PlayerManager.player = self
	update_player_texture()

func _process(delta):
	#print_test()
	update_base_actions()
	
func update_player_texture():
	if type == "Rogue":
		$Character.texture = load("res://assets/32rogues/chars/rogue.png")
	elif type == "Barbarian":
		$Character.texture = load("res://assets/32rogues/chars/barbarian.png")

func update_base_actions():
	base_action1 = type_action1 + upgraded_action1
	base_action2 = type_action2 + upgraded_action2
	base_action3 = type_action3 + upgraded_action3
	
func damage1_attack():
	if rage > 0:
		action1 = (base_action1 + (base_action1 * rage)) * piece_multiplier
		EnemyManager.enemy.take_damage(action1)
		print("damage is: " + str(action1))
	else:
		action1 = (base_action1 * piece_multiplier)
		EnemyManager.enemy.take_damage(action1)
		
func damage2_attack():
	action2 = action2 + (base_action2 * piece_multiplier)
	EnemyManager.enemy.take_damage(action2)
	if has_mace == true:
		var mace_action = get_mace_stunt_rng()
		print(mace_action)
	
func damage3_attack():
	action3 = action3 + (base_action3 * piece_multiplier)
	EnemyManager.enemy.take_damage(action3)

func get_mace_stunt_rng():
	rng.randomize()
	
	print(mace_stunt_rarities["stunt"])
	
	var weigted_sum = 0
	
	for n in mace_stunt_rarities:
		weigted_sum += mace_stunt_rarities[n]
	
	var item = rng.randi_range(0, weigted_sum)

	for n in mace_stunt_rarities:
		if item <= mace_stunt_rarities[n]:
			return n
		item -= mace_stunt_rarities[n]


func handle_rage(amount):
	rage += amount
	if rage > 2:
		rage = 2
	$RageTimer.start()
	print("rage is: " + str(rage))
	
func shield_up(amount):
	if EnemyManager.enemy.status == "alive":
		shield += amount
		
func material_up():
	if EnemyManager.enemy.status == "alive":
		materials += 1

func red_gem_up(amount):
	red_gem += amount
	
func green_gem_up(amount):
	green_gem += amount
		
func blue_gem_up(amount):
	blue_gem += amount
		
func yellow_gem_up(amount):
	yellow_gem += amount

func coins_up():
	coins += 1

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


func _on_rage_timer_timeout():
	if rage > 0:
		rage -= 0.2
