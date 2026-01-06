class_name Enemy
extends CharacterBody2D

enum {alive, dead}
var state
var status = "alive"


var type = "Spider"
var health = 20
var health_increase = 5
var max_health = 20
var shield = 5
var shield_increase = 3
var damage : Vector2
var coin_worth = 5
var action_delay : Vector2
var match_to_action : Vector2
var blood_type

var matches_to_action : int

#Statuses
var is_vulnerable = false
var is_weak = false
var is_frail = false

var rng = RandomNumberGenerator.new()

var crit = false
var crit_rarities = {
	"nothing" : 80,
	"crit" : 20,
}

var last_whole: int = -1

var coin_effect_position = Vector2(921,737)
@onready var coin_effect = load("res://scenes/GUI/coin_effect.tscn")
@onready var damage_numbers_origin = $DamageNumbersOrigin
@onready var time = $ActionTimer
@onready var enemy_claw_animation = %EnemyClawAnimation
@onready var enemy_sword_animation = %EnemySwordAnimation




func _ready():
	stat_check()
	change_delay()
	state = alive
	EnemyManager.enemy = self
	start_action()
	
func _process(_delta):
	#if matches_to_action <= 0:
		#$Actions/ActionTimer.visible = false
	#else:
		#$Actions/ActionTimer.visible = true
	update_action_timer()
	trigger_scale()
	%Label.text = str(round(time.time_left))
	if status == "dead" or PlayerManager.player.status == "dead":
		stop_action()
	if LevelManager.type == "Random Event":
		stop_action()
		
func take_action():
	await get_tree().create_timer(0.2).timeout
	random_action()
	reset_matches_to_action()

func reset_matches_to_action():
	scale_tween()
	matches_to_action = randi_range(int(match_to_action.x),int(match_to_action.y))

func trigger_scale():
	var t = int(ceil(%ActionTimer.time_left - 0.5))
	if t != last_whole:
		last_whole = t
		scale_tween()

func scale_tween():
	var tween = create_tween()
	tween.tween_property($Actions/ActionTimer,"scale",Vector2(1.5,1.5),0.1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property($Actions/ActionTimer,"scale",Vector2(1,1),0.1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

func stat_check():
	type = EnemyManager.type
	health = EnemyManager.health
	health_increase = EnemyManager.health_increase
	max_health = EnemyManager.max_health
	shield = EnemyManager.shield
	shield_increase = EnemyManager.shield_increase
	damage = EnemyManager.damage
	coin_worth = EnemyManager.coin_worth
	action_delay = EnemyManager.action_delay
	match_to_action = EnemyManager.match_to_action
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
	elif type == "Wolf":
		var wolf_texture = load("res://assets/32rogues/enem/wolf.png")
		%EnemyType.texture = wolf_texture
	elif type == "Lamprey":
		var lamprey_texture = load("res://assets/32rogues/enem/lamprey.png")
		%EnemyType.texture = lamprey_texture
	elif type == "Crone":
		var crone_texture = load("res://assets/32rogues/enem/crone.png")
		%EnemyType.texture = crone_texture
	elif type == "Ratten":
		var ratten_texture = load("res://assets/32rogues/enem/ratten.png")
		%EnemyType.texture = ratten_texture
	elif type == "Rattena":
		var rattena_texture = load("res://assets/32rogues/enem/rattena.png")
		%EnemyType.texture = rattena_texture
	elif type == "Shroom":
		var shroom_texture = load("res://assets/32rogues/enem/shroom.png")
		%EnemyType.texture = shroom_texture
	elif type == "Gnome":
		var gnome_texture = load("res://assets/32rogues/enem/gnome.png")
		%EnemyType.texture = gnome_texture
	elif type == "Warewolf":
		var warewolf_texture = load("res://assets/32rogues/enem/warewolf.png")
		%EnemyType.texture = warewolf_texture
	elif type == "Gator":
		var gator_texture = load("res://assets/32rogues/enem/gator.png")
		%EnemyType.texture = gator_texture
	elif type == "Medusa":
		var medusa_texture = load("res://assets/32rogues/enem/medusa.png")
		%EnemyType.texture = medusa_texture
	elif type == "Minotaur":
		var minotaur_texture = load("res://assets/32rogues/enem/minotaur.png")
		%EnemyType.texture = minotaur_texture
	elif type == "Leshen":
		var leshen_texture = load("res://assets/32rogues/enem/leshen.png")
		%EnemyType.texture = leshen_texture
	elif type == "Priest":
		var priest_texture = load("res://assets/32rogues/enem/priest.png")
		%EnemyType.texture = priest_texture
	elif type == "Mystic":
		var mystic_texture = load("res://assets/32rogues/enem/mystic.png")
		%EnemyType.texture = mystic_texture
	elif type == "Sly":
		var sly_texture = load("res://assets/32rogues/enem/sly.png")
		%EnemyType.texture = sly_texture
	elif type == "Mystery":
		var mystery_texture = load("res://assets/32rogues/enem/mystery.png")
		%EnemyType.texture = mystery_texture
	elif type == "Wraith":
		var wraith_texture = load("res://assets/32rogues/enem/wraith.png")
		%EnemyType.texture = wraith_texture
	elif type == "Basilisk":
		var basilisk_texture = load("res://assets/32rogues/enem/basilisk.png")
		%EnemyType.texture = basilisk_texture
	elif type == "Formicidae":
		var formicidae_texture = load("res://assets/32rogues/enem/formicidae.png")
		%EnemyType.texture = formicidae_texture
	elif type == "Divine":
		var divine_texture = load("res://assets/32rogues/enem/divine.png")
		%EnemyType.texture = divine_texture
	elif type == "Centipeda":
		var centipeda_texture = load("res://assets/32rogues/enem/centipeda.png")
		%EnemyType.texture = centipeda_texture
	elif type == "Nemean":
		var nemean_texture = load("res://assets/32rogues/enem/nemean.png")
		%EnemyType.texture = nemean_texture
	elif type == "Torment":
		var torment_texture = load("res://assets/32rogues/enem/torment.png")
		%EnemyType.texture = torment_texture
	elif type == "Haidomyrmecinae":
		var haidomyrmecinae_texture = load("res://assets/32rogues/enem/haidomyrmecinae.png")
		%EnemyType.texture = haidomyrmecinae_texture
	elif type == "Angel":
		var angel_texture = load("res://assets/32rogues/enem/angel.png")
		%EnemyType.texture = angel_texture
	elif type == "Microchaetus":
		var microchaetus_texture = load("res://assets/32rogues/enem/microchaetus.png")
		%EnemyType.texture = microchaetus_texture
	elif type == "Torment Us":
		var torment_us_texture = load("res://assets/32rogues/enem/torment_us.png")
		%EnemyType.texture = torment_us_texture
	elif type == "Goblin":
		var goblin_texture = load("res://assets/32rogues/enem/goblin.png")
		%EnemyType.texture = goblin_texture
	elif type == "Mogglewog":
		var mogglewog_texture = load("res://assets/32rogues/enem/mogglewog.png")
		%EnemyType.texture = mogglewog_texture
	elif type == "Troll Boss":
		var troll_boss_texture = load("res://assets/32rogues/enem/troll_boss.png")
		%EnemyType.texture = troll_boss_texture
		
		
func change_delay():
	var random_delay = randi_range(int(action_delay.x), int(action_delay.y))
	%ActionTimer.start(round(random_delay) + 0.4)

func update_action_timer():
	if %ActionTimer.wait_time == 999:
		return
	elif %ActionTimer.time_left < 0.5:
		$Actions/ActionTimer.text = "O"
	#elif %ActionTimer.wait_time == round(%ActionTimer.time_left):
		#$Actions/ActionTimer.text = ""
	else:
		$Actions/ActionTimer.text = int_to_roman(round(%ActionTimer.time_left))

func int_to_roman(value: int) -> String:

	var roman_map = [
		[1000, "M"], [900, "CM"], [500, "D"], [400, "CD"],
		[100, "C"], [90, "XC"], [50, "L"], [40, "XL"],
		[10, "X"], [9, "IX"], [5, "V"], [4, "IV"], [1, "I"]
	]

	var result := ""
	for pair in roman_map:
		var val: int = pair[0]
		var sym: String = pair[1]
		while value >= val:
			value -= val
			result += sym
	
	return result
	

func random_action():
	if status == "dead":
		return
	var random = Random.get_rng()
		
	if random == "attack":
		if PlayerManager.player.is_invisible == true:
			inflict_zero_damage()
			%SwordPiece.visible = true
			PlayerManager.player.became_visible()
			await get_tree().create_timer(1.5).timeout
			%SwordPiece.visible = false
			change_delay()
		else:
			inflict_damage()
			%SwordPiece.visible = true
			PlayerManager.player.became_visible()
			await get_tree().create_timer(1.5).timeout
			%SwordPiece.visible = false
			change_delay()
			
	if random == "shield":
		if shield > 15:
			random_action()
		else:
			shield_up()
			%ShieldPiece.visible = true
			PlayerManager.player.became_visible()
			await get_tree().create_timer(1.5).timeout
			%ShieldPiece.visible = false
			change_delay()
			
	if random == "heal":
		if health == max_health:
			random_action()
		else:
			heal()
			%HealPiece.visible = true
			PlayerManager.player.became_visible()
			await get_tree().create_timer(1.5).timeout
			%HealPiece.visible = false
			change_delay()


func inflict_zero_damage():
	if RelicManager.has_shuriken == true:
		take_damage(3,3)
	attack_animation()
	PlayerManager.player.receive_damage(0)
	
func inflict_damage():
	if RelicManager.has_shuriken == true:
		take_damage(3,3)
	var crit_amount = 0
	var crit_chance = get_crit_rng()
	if crit_chance == "crit":
		crit = true
		crit_amount = 0.20
	else:
		crit = false
		crit_amount = 0
		
	var random_damage = randi_range(int(damage.x), int(damage.y))
	if is_weak == true:
		random_damage = random_damage - (random_damage * 0.3)
	var random_damage_crit = random_damage + (random_damage * crit_amount)
	attack_animation()
	PlayerManager.player.receive_damage(random_damage_crit)

func attack_animation():
	if type == "Ghost Warrior" or type == "Demon Boss":
		sword_blue_animation()
	elif type == "Hag":
		sword_animation()
	else:
		claw_animation()

func get_crit_rng():
	rng.randomize()
	var weigted_sum = 0
	for n in crit_rarities:
		weigted_sum += crit_rarities[n]
	var chance = rng.randi_range(0, weigted_sum)
	for n in crit_rarities:
		if chance <= crit_rarities[n]:
			return n
		chance -= crit_rarities[n]

func shield_up():
	if is_frail == true:
		shield += round(shield_increase * 0.7)
	else:
		shield += shield_increase

func heal():
	health += health_increase
	if health >= max_health:
		health = max_health

func take_damage(damage_taken, random_base_action):
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
		
		#Apply statuses
		var total_damage = damage_taken
		if is_vulnerable:
			total_damage = total_damage * 1.3
		if RelicManager.has_gem_necklace:
			total_damage = total_damage * 1.4
		
		
		#Visual hit number test
		var is_top = false
		var is_critical = false
		if random_base_action == PlayerManager.player.base_action1.y or random_base_action == PlayerManager.player.base_action2.y or random_base_action == PlayerManager.player.base_action3.y or random_base_action == PlayerManager.player.base_action4.y:
			is_top = true
		var is_poison = false
		DamageNumbers.display_number(total_damage, $DamageNumbersOrigin.global_position, is_top, is_critical, is_poison)
		
		#Logic behind getting hit
		var health_attack = 0
		for d in range(0, total_damage):
			if shield > 0:
				shield -= 1
			else:
				health_attack += 1
		var total_attack = health_attack * PlayerManager.player.piece_multiplier
		health -= total_attack
		
		if health <= 0:
			health = 0
			get_killed()

func take_action_damage(damage_taken, action):
	if state == alive:
		#Visual knockback
		var tween_scale = create_tween()
		tween_scale.tween_property($EnemyType,"scale", Vector2(16,16), 0.1)
		tween_scale.tween_property($EnemyType,"scale", Vector2(15,15), 0.1)
		var tween_move = create_tween()
		tween_move.tween_property($EnemyType, "position", Vector2(0,-100), 0.1)
		tween_move.tween_property($EnemyType, "position", Vector2(0, 0), 0.1)

		#Visual hit
		var is_top = false
		var is_critical = false
		var is_poison = false
		var is_bleed = false
		var is_ice = false
		var is_fire = false
		var is_electric = false
		
		if action == "bleed":
			%AnimationPlayer.play("hit_bleed")
			is_bleed = true
		if action == "poison":
			%AnimationPlayer.play("hit_poison")
			is_poison = true
		if action == "ice":
			%AnimationPlayer.play("hit_ice")
			is_ice = true
		if action == "fire":
			%AnimationPlayer.play("hit_fire")
			is_fire = true
		if action == "electric":
			%AnimationPlayer.play("hit_electric")
			is_electric = true
		
		#Apply statuses
		var total_damage = damage_taken
		if is_vulnerable:
			total_damage = total_damage * 1.3
		if RelicManager.has_gem_necklace:
			total_damage = total_damage * 1.4

		DamageNumbers.display_number(total_damage, $DamageNumbersOrigin.global_position, is_top, is_critical, is_poison, is_bleed, is_ice, is_fire, is_electric)

		#Logic behind getting hit
		var health_attack = 0
		for d in range(0, damage_taken):
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
	$VFX.visible = false
	LevelManager.timer_stop = true
	Music.dim_music()
	Sfx.play_SFX(Sfx.victory)
	handle_tutorial()
	LevelManager.level_done += 1
	handle_progress()
	Combo._on_timer_timeout()
	#Shield Cap
	if PlayerManager.player.shield > PlayerManager.player.shield_max:
		PlayerManager.player.shield = PlayerManager.player.shield_max + PlayerManager.player.upgraded_shield_max
	#Status change and stop for actions
	state = dead
	status = "dead"
	LevelManager.level_active = false
	%ActionTimer.stop()
	%Actions.visible = false
	%Stunned.visible = false
	
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
	if LevelManager.is_mobile:
		tween_move.tween_property($EnemyType, "position", Vector2(400,0), 0.5)
	else:
		tween_move.tween_property($EnemyType, "position", Vector2(800,0), 0.5)
	var tween_rotate = create_tween()
	tween_rotate.tween_property($EnemyType, "rotation", deg_to_rad(90), 0.5)
	
	#Relics
	RelicManager.report += 1
	
	#Update player spins
	PlayerManager.player.spins_left += 1
	
	#Get coins
	EffectLoad.material_effect(coin_effect, coin_effect_position)
	await get_tree().create_timer(1).timeout
	if RelicManager.has_wealth_necklace == true:
		PlayerManager.player.get_coins(coin_worth * 1.5)
	else:
		PlayerManager.player.get_coins(coin_worth)
	
	#Autosave
	SaveManager.autosave()

func handle_tutorial():
	if LevelManager.in_tutorial_level:
		if LevelManager.available_level == 8:
			PlayerManager.player.rogue_unlocked = true
			if LevelManager.tutorial_completed:
				PlayerManager.player.player_won = true
			else:
				PlayerManager.player.wood += 25
				PlayerManager.player.stone += 30
				PlayerManager.player.iron += 15
				PlayerManager.player.player_won = true
			
func handle_progress():
	if LevelManager.available_level == 11:
		PlayerManager.player.barbarian_unlocked = true
		SaveManager.savefilesave()
		LevelManager.floor += 1
	if OS.has_feature("Demo"):
		if LevelManager.available_level == 24:
			PlayerManager.player.player_won = true
	if LevelManager.available_level == 24: ###################TEST##################
			PlayerManager.player.player_won = true
	if LevelManager.available_level == 51:
		PlayerManager.player.player_won = true

func stunt(amount):
	var stunt_time = %ActionTimer.time_left + amount
	%ActionTimer.start(stunt_time)
	#%Stunned.visible = true
	PlayerManager.player.stun_active = true
	await  get_tree().create_timer(amount).timeout
	PlayerManager.player.stun_active = false
	#%Stunned.visible = false
	
func stop_action():
	%ActionTimer.stop()
	
func start_action():
	%ActionTimer.start()
	
func player_died():
	stop_action()
	%Actions.visible = false
	%Stunned.visible = false
	
func _on_action_timer_timeout():
	random_action()
	pass


#Animation
func claw_animation():
	enemy_claw_animation.visible = true
	enemy_claw_animation.play("Claw")
	await enemy_claw_animation.animation_finished
	enemy_claw_animation.visible = false

func sword_animation():
	enemy_sword_animation.visible = true
	enemy_sword_animation.play("Sword")
	await enemy_sword_animation.animation_finished
	enemy_sword_animation.visible = false

func sword_blue_animation():
	enemy_sword_animation.visible = true
	enemy_sword_animation.play("Sword_blue")
	await enemy_sword_animation.animation_finished
	enemy_sword_animation.visible = false
