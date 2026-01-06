class_name Player
extends CharacterBody2D


#Status
enum{alive, dead}
var state
var status = "alive"
var player_won = false
@export var type : String


#Stats
@export var type_action1: Vector2
@export var type_action2: Vector2
@export var type_action3: Vector2
@export var upgraded_action1: Vector2
@export var upgraded_action2: Vector2
@export var upgraded_action3: Vector2
var base_action1: Vector2
var base_action2: Vector2
var base_action3: Vector2
var base_action4: Vector2
var action1 = 0
var action2 = 0
var action3 = 0
var action4 = 0

@export var health: float
@export var max_health: float
@export var shield: int
var shield_max: int = 10
var shield_load: int = 3
var shield_to_be_loaded: int = 0
var piece_multiplier: float = 1.0
var combo_multiplier: float = 1.0

var spawned: bool = false
var spins_left: int = 0

#Characted unlocks
var rogue_unlocked: bool = false
var barbarian_unlocked: bool = false
var holy_unlocked: bool = false
var spellblade_unlocked: bool = false
var knight_unlocked: bool = false


#Shield upgrades
var upgraded_shield_max: int = 0
var upgraded_shield_load: int = 0
var upgraded_shield_init: int = 0

#Weapon upgrades
var upgraded_axe_damage  := Vector2(0,0)
var upgraded_mace_damage := Vector2(0,0)
var upgraded_sword_damage := Vector2(0,0)
var upgraded_bow_damage := Vector2(0,0)

#Weapon Statuses
var rage = 0

var has_mace: bool = false
var mace_stunt_chance: int = 10
var stun_time = 3
var mace_stunt_rarities = {
	"chance": 0,
	"rarities": {"nothing": 100, "stun": 0}
}

var has_invisibility: bool = false
var is_invisible: bool = false
var invisibility_chance: int = 20
var invisibility_timer = 6
var invisibility_rarities = {
	"chance": 0,
	"rarities": {"nothing": 100, "invisibility": 0}
}

var has_bow_poison: bool = false
var poison_active: bool = false
var poison_chance: int = 20

var check_for_poison_arrow: bool = false
var poison_rarities = {
	"chance": 0,
	"rarities": {"nothing": 100, "poison": 0}
}

var action_rarities = {
	"nothing" : 80,
	"action" : 20,
}
var bleed_active: bool = false
var ice_active: bool = false
var fire_active: bool = false
var electric_active: bool = false
var stun_active: bool = false
var weak_active: bool = false
var vulnerable_active: bool = false
var frail_active: bool = false

var bleed_damage = 2
var poison_damage = 1
var ice_damage = 2
var fire_damage = 2
var electric_damage = 2


var bleed_duration = 6
var bleed_repetetion = 2
var poison_duration = 6
var poison_repetition = 2
var ice_duration = 6
var ice_repetetion = 2
var fire_duration = 6
var fire_repetetion = 2
var electric_duration = 6
var electric_repetetion = 2
var stun_duration = 6
var weak_duration = 6
var vulnerable_duration = 6
var frail_duration = 6


var has_antivenom = false

#Gems and Coins
var coins: int = 0
var red_gem: int = 0
var yellow_gem: int = 0
var green_gem: int = 0
var blue_gem: int = 0

#Gems and Coins Stored
var total_coins: int = 0
var total_red_gem: int = 0
var total_yellow_gem: int = 0
var total_green_gem: int = 0
var total_blue_gem: int = 0

#Gems and Coins Stored if died
var coins_died: int = 0
var red_gem_died: int = 0
var yellow_gem_died: int = 0
var green_gem_died: int = 0
var blue_gem_died: int = 0

#Material
var wood: int = 0
var stone: int = 0
var iron: int = 0

#Material Stored
var total_wood: int = 0
var total_stone: int = 0
var total_iron: int = 0

#Material died
var wood_died: int = 0
var stone_died: int = 0
var iron_died: int = 0

var rng = RandomNumberGenerator.new()


var text: String = ""

func print_test():
	if text == "":
		return
	else:
		$Label.text = text
		
	
func _ready():
	rng.randomize()
	state = alive
	PlayerManager.player = self
	update_player_texture()
	
func _process(_delta):
	print_test()
	update_upgraded_actions()
	update_base_actions()
	total_material()
	total_gems()
	check_max_health()
	
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

func check_max_health():
	if health > max_health:
		health = max_health

func damage1_attack():
	if EnemyManager.enemy.status == "dead":
		return
	else:
		RelicManager.thorned_necklade += 1
		if rage > 0:
			var random_base_action1 = randi_range(base_action1.x, base_action1.y)
			action1 = (random_base_action1 + (random_base_action1 * rage)) * piece_multiplier * combo_multiplier
			EnemyManager.enemy.take_damage(action1, random_base_action1)
			print("damage is: " + str(action1))
		else:
			var random_base_action1 = randi_range(base_action1.x, base_action1.y)
			action1 = (random_base_action1 * piece_multiplier * combo_multiplier)
			EnemyManager.enemy.take_damage(action1, random_base_action1)
			print("damage is: " + str(action1))
		
func damage2_attack():
	if EnemyManager.enemy.status == "dead":
		return
	else:
		RelicManager.thorned_necklade += 1
		var random_base_action2 = randi_range(base_action2.x, base_action2.y)
		action2 = (random_base_action2 * piece_multiplier * combo_multiplier)
		EnemyManager.enemy.take_damage(action2, random_base_action2)
		if has_mace == true:
			var mace_action = get_mace_stunt_rng()
			if mace_action == "stunt":
				EnemyManager.enemy.stunt(stun_time)
		if has_bow_poison == true:
			var bow_action = get_poison_rng()
			if bow_action == "poison":
				check_for_poison_arrow = true
				poison_active = true
				%PoisonDebuffTimerEnd.start(poison_duration)
				%PoisonDebuffTimer.start(poison_repetition)
	
func damage3_attack():
	if EnemyManager.enemy.status == "dead":
		return
	else:
		RelicManager.thorned_necklade += 1
		var random_base_action3 = randi_range(base_action3.x, base_action3.y)
		action3 = (random_base_action3 * piece_multiplier * combo_multiplier)
		EnemyManager.enemy.take_damage(action3, random_base_action3)
		print("damage is: " + str(action3))

func damage4_attack(action):
	if EnemyManager.enemy.status == "dead":
		return
	else:
		RelicManager.thorned_necklade += 1
		var random_base_action4 = randi_range(base_action4.x, base_action4.y)
		action4 = (random_base_action4 * piece_multiplier * combo_multiplier)
		EnemyManager.enemy.take_damage(action4, random_base_action4)
		print("damage is: " + str(action4))
		
		if action == "bleed":
			var take_action = action_rng()
			if take_action == "action":
				%BleedDebuffTimer.start(bleed_repetetion)
				%BleedDebuffTmerEnd.start(bleed_duration)
				bleed_active = true
				
		if action == "ice":
			var take_action = action_rng()
			if take_action == "action":
				%IceDebuffTimer.start(ice_repetetion)
				%IceDebuffTimerEnd.start(ice_duration)
				ice_active = true
				
		if action == "fire":
			var take_action = action_rng()
			if take_action == "action":
				%FireDebuffTimer.start(fire_repetetion)
				%FireDebuffTimerEnd.start(fire_duration)
				fire_active = true
				
		if action == "electric":
			var take_action = action_rng()
			if take_action == "action":
				%ElectricDebuffTimer.start(electric_repetetion)
				%ElectricDebuffTimerEnd.start(electric_duration)
				electric_active = true
				
		if action == "weak":
			var take_action = action_rng()
			if take_action == "action":
				EnemyManager.enemy.is_weak = true
				%WeakDebuffTimerEnd.start(weak_duration)
				weak_active = true
				
		if action == "vulnerable":
			var take_action = action_rng()
			if take_action == "action":
				EnemyManager.enemy.is_vulnerable = true
				%VulnerableDebuffTimerEnd.start(vulnerable_duration)
				vulnerable_active = true
				
		if action == "frail":
			var take_action = action_rng()
			if take_action == "action":
				EnemyManager.enemy.is_frail = true
				%FrailDebuffTimerEnd.start(frail_duration)
				frail_active = true

func damage_thorned_necklace():
	EnemyManager.enemy.take_damage(15,15)
	receive_damage(5)

func weighted_pick(rarities: Dictionary):
	var total := 0
	for key in rarities.keys():
		total += rarities[key]

	var roll := rng.randi_range(1, total)

	var sorted_keys := rarities.keys()
	sorted_keys.sort()

	for key in sorted_keys:
		roll -= rarities[key]
		if roll <= 0:
			return key

	return sorted_keys[-1]

func get_mace_stunt_rng():
	return weighted_pick(mace_stunt_rarities.rarities)

func get_invisibility_rng():
	return weighted_pick(invisibility_rarities.rarities)
	
func get_poison_rng():
	return weighted_pick(poison_rarities.rarities)

func action_rng():
	var weigted_sum = 0
	for n in action_rarities:
		weigted_sum += action_rarities[n]
	var chance = rng.randi_range(0, weigted_sum)
	for n in action_rarities:
		if chance <= action_rarities[n]:
			return n
		chance -= action_rarities[n]

func handle_invisibility():
	if has_invisibility == true:
		var invisibility_action = get_invisibility_rng()
		if invisibility_action == "invisibility":
			var tween_invisibility = create_tween()
			tween_invisibility.tween_property($Character, "modulate:a", 0.10, 0.5)
			is_invisible = true


func became_visible():
	var tween_invisibility_back = create_tween()
	tween_invisibility_back.tween_property($Character, "modulate:a", 1.0, 0.5)
	is_invisible = false

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
#Character unlocks
	rogue_unlocked = false
	barbarian_unlocked = false
	holy_unlocked = false
	spellblade_unlocked = false
	knight_unlocked = false

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
		Sfx.play_SFX(Sfx.damage)
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
		if shield > 0:
			RelicManager.got_hit_armor += 1
		for d in range(0, damage):
			if shield > 0:
				shield -= 1
			else:
				health_attack += 1
		if health_attack > 0:
			RelicManager.got_hit_health_potion += 1
		var total_attack = health_attack
		health -= total_attack
		
		if health <= 0:
			health = 0
			get_killed()

func get_killed():
	Sfx.play_SFX(Sfx.death)
	RunStats.timer_stop()
	set_treasure_died()
	LevelManager.reset_map()
	EnemyManager.enemy.player_died()
	state = dead
	status = "dead"
	LevelManager.level_active = false
	
	%AnimationPlayer.play("hit")
	var tween_scale = create_tween()
	tween_scale.tween_property($Character,"scale", Vector2(16,16), 0.1)
	tween_scale.tween_property($Character,"scale", Vector2(15,15), 0.1)
	var tween_move = create_tween()
	if LevelManager.is_mobile:
		tween_move.tween_property($Character, "position", Vector2(-400,0), 0.5)
	else:
		tween_move.tween_property($Character, "position", Vector2(-800,0), 0.5)
	var tween_rotate = create_tween()
	tween_rotate.tween_property($Character, "rotation", deg_to_rad(-90), 0.5)
	
	await get_tree().create_timer(3).timeout
	
	SaveManager.remove_autosave()
	SaveManager.savefilesave()

func _on_rage_timer_timeout():
	if rage > 0:
		rage -= 0.2

func _on_bleed_debuff_timer_timeout():
	EnemyManager.enemy.take_action_damage(bleed_damage, "bleed")
	
func _on_bleed_debuff_tmer_end_timeout():
	%BleedDebuffTimer.stop()
	bleed_active = false
	
func _on_poison_debuff_timer_timeout():
	EnemyManager.enemy.take_action_damage(poison_damage, "poison")
	
func _on_poison_debuff_timer_end_timeout():
	%PoisonDebuffTimer.stop()
	poison_active = false

func _on_ice_debuff_timer_timeout():
	EnemyManager.enemy.take_action_damage(ice_damage, "ice")

func _on_ice_debuff_timer_end_timeout():
	%IceDebuffTimer.stop()
	ice_active = false

func _on_fire_debuff_timer_timeout():
	EnemyManager.enemy.take_action_damage(fire_damage, "fire")

func _on_fire_debuff_timer_end_timeout():
	%FireDebuffTimer.stop()
	fire_active = false

func _on_electric_debuff_timer_timeout():
	EnemyManager.enemy.take_action_damage(electric_damage, "electric")

func _on_electric_debuff_timer_end_timeout():
	%ElectricDebuffTimer.stop()
	electric_active = false

func _on_weak_debuff_timer_end_timeout():
	EnemyManager.enemy.is_weak = false
	weak_active = false

func _on_vulnerable_debuff_timer_end_timeout():
	EnemyManager.enemy.is_vulnerable = false
	vulnerable_active = false

func _on_frail_debuff_timer_end_timeout():
	EnemyManager.enemy.is_frail = false
	frail_active = false
