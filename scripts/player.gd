class_name Player
extends CharacterBody2D


#Status
enum{alive, dead}
var state
var status = "alive"
var player_won = false
@export var type : String


#Stats
@export var type_action1 : Vector2
@export var type_action2 : Vector2
@export var type_action3 : Vector2
@export var upgraded_action1 : Vector2
@export var upgraded_action2 : Vector2
@export var upgraded_action3 : Vector2
var base_action1 : Vector2
var base_action2 : Vector2
var base_action3 : Vector2
var base_action4 : Vector2
var action1 = 0
var action2 = 0
var action3 = 0
var action4 = 0

@export var health : float
@export var max_health : float
@export var shield : int
var shield_max = 10
var shield_load = 3
var shield_to_be_loaded = 0
var piece_multiplier = 1
var spawned = false
var spins_left = 0


#Weapon upgrades
var upgraded_axe_damage  = Vector2(0,0)
var upgraded_mace_damage = Vector2(0,0)
var upgraded_sword_damage = Vector2(0,0)
var upgraded_bow_damage = Vector2(0,0)

#Weapon Statuses
var rage = 0

var has_mace = false
var mace_stunt_chance = 10
var stun_time = 10
var mace_stunt_rarities = {
	"nothing" : 90,
	"stunt" : mace_stunt_chance,
}

var has_invisibility = false
var invisibility_chance = 20
var invisibility_rarities = {
	"nothing" : 80,
	"invisibility" : invisibility_chance,
}

var has_bow_poison = false
var poison_damage = 1
var poison_active = false
var poison_chance = 20
var poison_duration = 6
var poison_repetition = 2
var check_for_poison_arrow = false
var poison_rarities = {
	"nothing" : 80,
	"poison" : poison_chance,
}

var has_antivenom = false

#Gems and Coins
var coins = 0
var red_gem = 0
var yellow_gem = 0
var green_gem = 0
var blue_gem = 0

#Gems and Coins Stored
var total_coins = 0
var total_red_gem = 0
var total_yellow_gem = 0
var total_green_gem = 0
var total_blue_gem = 0

#Gems and Coins Stored if died
var coins_died = 0
var red_gem_died = 0
var yellow_gem_died = 0
var green_gem_died = 0
var blue_gem_died = 0

#Material
var wood = 0
var stone = 0
var iron = 0

#Material Stored
var total_wood = 0
var total_stone = 0
var total_iron = 0

#Material died
var wood_died = 0
var stone_died = 0
var iron_died = 0

var rng = RandomNumberGenerator.new()


var text = ""

func print_test():
	if text == "":
		return
	else:
		$Label.text = text
		
	
func _ready():
	state = alive
	PlayerManager.player = self
	update_player_texture()
	
func _process(_delta):
	print_test()
	update_upgraded_actions()
	update_base_actions()
	total_material()
	total_gems()
	
func update_player_texture():
	if type == "Rogue":
		$Character.texture = load("res://assets/32rogues/chars/rogue.png")
	elif type == "Barbarian":
		$Character.texture = load("res://assets/32rogues/chars/barbarian.png")
	elif type == "Spellblade":
		$Character.texture = load("res://assets/32rogues/chars/Spellblade.png")
	elif type == "Holy":
		$Character.texture = load("res://assets/32rogues/chars/holy.png")

func update_upgraded_actions():
	if type == "Rogue":
		upgraded_action1 = upgraded_sword_damage
		upgraded_action2 = upgraded_bow_damage
	elif type == "Barbarian":
		upgraded_action1 = upgraded_axe_damage
		upgraded_action2 = upgraded_mace_damage
	else:
		upgraded_action1 = Vector2(0,0)
		upgraded_action2 = Vector2(0,0)
		
func update_base_actions():
	base_action1 = type_action1 + upgraded_action1
	base_action2 = type_action2 + upgraded_action2
	base_action3 = type_action3 + upgraded_action3

func shield_up(amount):
	if EnemyManager.enemy.status == "alive":
		shield += amount
		
func heal(amount):
	health += amount
	if health > max_health:
		health = max_health

func damage1_attack():
	if EnemyManager.enemy.status == "dead":
		pass
	else:
		if rage > 0:
			var random_base_action1 = randi_range(base_action1.x, base_action1.y)
			action1 = (random_base_action1 + (random_base_action1 * rage)) * piece_multiplier
			EnemyManager.enemy.take_damage(action1, random_base_action1)
			print("damage is: " + str(action1))
		else:
			var random_base_action1 = randi_range(base_action1.x, base_action1.y)
			action1 = (random_base_action1 * piece_multiplier)
			EnemyManager.enemy.take_damage(action1, random_base_action1)
			print("damage is: " + str(action1))
		
func damage2_attack():
	if EnemyManager.enemy.status == "dead":
		pass
	else:
		var random_base_action2 = randi_range(base_action2.x, base_action2.y)
		action2 = (random_base_action2 * piece_multiplier)
		EnemyManager.enemy.take_damage(action2, random_base_action2)
		if has_mace == true:
			var mace_action = get_mace_stunt_rng()
			print(mace_action)
			if mace_action == "stunt":
				EnemyManager.enemy.stunt(stun_time)
		if has_bow_poison == true:
			var bow_action = get_poison_rng()
			print(bow_action)
			if bow_action == "poison":
				check_for_poison_arrow = true
				poison_active = true
				$EnemyDebuffTimerEnd.start(poison_duration)
				$EnemyDebuffTimer.start(poison_repetition)
	
func damage3_attack():
	if EnemyManager.enemy.status == "dead":
		pass
	else:
		var random_base_action3 = randi_range(base_action3.x, base_action3.y)
		action3 = (random_base_action3 * piece_multiplier)
		EnemyManager.enemy.take_damage(action3, random_base_action3)
		print("damage is: " + str(action3))

func damage4_attack():
	if EnemyManager.enemy.status == "dead":
		pass
	else:
		var random_base_action4 = randi_range(base_action4.x, base_action4.y)
		action4 = (random_base_action4 * piece_multiplier)
		EnemyManager.enemy.take_damage(action4, random_base_action4)
		print("damage is: " + str(action4))
	
func get_mace_stunt_rng():
	rng.randomize()
	var weigted_sum = 0
	for n in mace_stunt_rarities:
		weigted_sum += mace_stunt_rarities[n]
	var chance = rng.randi_range(0, weigted_sum)
	for n in mace_stunt_rarities:
		if chance <= mace_stunt_rarities[n]:
			return n
		chance -= mace_stunt_rarities[n]

func get_invisibility_rng():
	rng.randomize()
	var weigted_sum = 0
	for n in invisibility_rarities:
		weigted_sum += invisibility_rarities[n]
	var chance = rng.randi_range(0, weigted_sum)
	for n in invisibility_rarities:
		if chance <= invisibility_rarities[n]:
			return n
		chance -= invisibility_rarities[n]

func get_poison_rng():
	rng.randomize()
	var weigted_sum = 0
	for n in poison_rarities:
		weigted_sum += poison_rarities[n]
	var chance = rng.randi_range(0, weigted_sum)
	for n in poison_rarities:
		if chance <= poison_rarities[n]:
			return n
		chance -= poison_rarities[n]


func handle_invisibility():
	if has_invisibility == true:
		var invisibility_action = get_invisibility_rng()
		if invisibility_action == "invisibility":
			var tween_invisibility = create_tween()
			tween_invisibility.tween_property($Character, "modulate:a", 0.10, 0.5)
			EnemyManager.enemy.stop_action()
			await get_tree().create_timer(4).timeout
			var tween_invisibility_back = create_tween()
			tween_invisibility_back.tween_property($Character, "modulate:a", 1.0, 0.5)
			EnemyManager.enemy.start_action()

func handle_rage(amount):
	rage += amount
	if rage > 2:
		rage = 2
	$RageTimer.start()

func reset_player_stats():
#Weapon upgrades
	upgraded_axe_damage = Vector2(0,0)
	upgraded_mace_damage = Vector2(0,0)
	upgraded_sword_damage = Vector2(0,0)
	upgraded_bow_damage = Vector2(0,0)
#Gems and Coins Stored
	total_coins = 0
	total_red_gem = 0
	total_yellow_gem = 0
	total_green_gem = 0
	total_blue_gem = 0
#Material Stored
	total_wood = 0
	total_stone = 0
	total_iron = 0

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

func total_material():
	if total_wood > 999:
		total_wood = 999
	if total_stone > 999:
		total_stone = 999
	if total_iron > 999:
		total_iron = 999

func total_gems():
	if total_red_gem > 999:
		total_red_gem = 999
	if total_blue_gem > 999:
		total_blue_gem = 999
	if total_green_gem > 999:
		total_green_gem = 999
	if total_yellow_gem > 999:
		total_yellow_gem = 999
	if total_coins > 999:
		total_coins = 999
		
func set_treasure():
	total_coins += coins
	total_red_gem += red_gem
	total_yellow_gem += yellow_gem
	total_green_gem += green_gem
	total_blue_gem += blue_gem
	total_wood += wood
	total_stone += stone
	total_iron += iron

func set_treasure_died():
	for n in coins:
		var random = randi_range(1,2)
		if random == 1:
			coins_died += 1
	for n in red_gem:
		var random = randi_range(1,2)
		if random == 1:
			red_gem_died += 1
	for n in yellow_gem:
		var random = randi_range(1,2)
		if random == 1:
			yellow_gem_died += 1
	for n in green_gem:
		var random = randi_range(1,2)
		if random == 1:
			green_gem_died += 1
	for n in blue_gem:
		var random = randi_range(1,2)
		if random == 1:
			blue_gem_died += 1
	for n in wood:
		var random = randi_range(1,2)
		if random == 1:
			wood_died += 1
	for n in stone:
		var random = randi_range(1,2)
		if random == 1:
			stone_died += 1
	for n in iron:
		var random = randi_range(1,2)
		if random == 1:
			iron_died += 1

	total_coins += coins_died
	total_red_gem += red_gem_died
	total_yellow_gem += yellow_gem_died
	total_green_gem += green_gem_died
	total_blue_gem += blue_gem_died
	total_wood += wood_died
	total_stone += stone_died
	total_iron += iron_died

func reset_current_treasure():
	coins -= coins
	red_gem -= red_gem
	yellow_gem -= yellow_gem
	green_gem -= green_gem
	blue_gem -= blue_gem
	wood -= wood
	stone -= stone
	iron -= iron

func receive_damage(damage):
	if state == alive:
		#Relics update
		RelicManager.got_hit_health_potion += 1
		RelicManager.got_hit_armor += 1
		#Visual knockback
		var tween_scale = create_tween()
		tween_scale.tween_property($Character,"scale", Vector2(16,16), 0.1)
		tween_scale.tween_property($Character,"scale", Vector2(15,15), 0.1)
		var tween_move = create_tween()
		tween_move.tween_property($Character, "position", Vector2(0,-100), 0.1)
		tween_move.tween_property($Character, "position", Vector2(0, 0), 0.1)
		#Visual hit
		%AnimationPlayer.play("hit")
		
		#Visual hit number test
		var is_top = false
		var is_critical = false
		if damage == EnemyManager.enemy.damage.y:
			is_top = true
		if EnemyManager.enemy.crit == true:
			is_critical = true
		var is_poison = false
		DamageNumbers.display_number(damage, $DamageNumberOrigin.global_position, is_top, is_critical, is_poison)
		
		#Logic behind getting hit
		var health_attack = 0
		for d in range(0, damage):
			if shield > 0:
				shield -= 1
			else:
				health_attack += 1
		var total_attack = health_attack
		health -= total_attack
		
		if health <= 0:
			health = 0
			get_killed()

func get_killed():
	set_treasure_died()
	LevelManager.reset_map()
	EnemyManager.enemy.player_died()
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
	SaveManager.savefilesave()

func _on_rage_timer_timeout():
	if rage > 0:
		rage -= 0.2


func _on_enemy_debuff_timer_timeout():
	EnemyManager.enemy.take_poison_damage(poison_damage)


func _on_enemy_debuff_timer_end_timeout():
	$EnemyDebuffTimer.stop()
	poison_active = false
