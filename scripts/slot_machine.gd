extends Control

var blue_gem = load("res://assets/32rogues/gems/blue.png")
var yellow_gem = load("res://assets/32rogues/gems/yellow.png")
var green_gem = load("res://assets/32rogues/gems/green.png")
var red_gem = load("res://assets/32rogues/gems/red.png")
var jackpot = false

var result1
var result2
var result3

var result1_desktop = Vector2(139,583)
var result2_desktop = Vector2(287,583)
var result3_desktop = Vector2(435,583)

var result1_mobile = Vector2(177,400)
var result2_mobile = Vector2(288,400)
var result3_mobile = Vector2(399,400)

var red_gem_effect = load("res://scenes/GUI/red_gem.tscn")
var blue_gem_effect = load("res://scenes/GUI/blue_gem.tscn")
var green_gem_effect = load("res://scenes/GUI/green_gem.tscn")
var yellow_gem_effect = load("res://scenes/GUI/yellow_gem.tscn")

func _ready():
	if LevelManager.is_mobile:
		result1 = result1_mobile
		result2 = result2_mobile
		result3 = result3_mobile
	else:
		result1 = result1_desktop
		result2 = result2_desktop
		result3 = result3_desktop

func _process(_delta):
	update_spins()
	check_for_continued()
	if LevelManager.is_mobile:
		$Continue.position = Vector2(-43,78)
		
func check_for_continued():
	if LevelManager.spinning == true:
		$Continue.visible = false
	elif LevelManager.spinning == false:
		$Continue.visible = true

func check_effects():
	if LevelManager.effects == "Off":
		$Confetti.visible = false
		$Confetti2.visible = false
	else:
		$Confetti.visible = true
		$Confetti2.visible = true

func pull():
	LevelManager.spinning = true
	$Key.play("open")
	Sfx.play_SFX(Sfx.key)
	await get_tree().create_timer(0.2).timeout
	tween_in()
	await get_tree().create_timer(0.9).timeout
	tween_back()
	
	$AudioStreamPlayer.play()
	
	%Slot._handle_pulled()
	
	%Slot2._handle_pulled()
	
	%Slot3._handle_pulled()


func tween_in():
	var tween = create_tween()
	tween.tween_property($Key, "position", Vector2(1,8), 0.1)
	
func tween_back():
	var tween = create_tween()
	tween.tween_property($Key, "position", Vector2(15,8), 0.1)

func update_spins():
	if PlayerManager.player.spins_left > 0:
		%SpinsLeft.text = str(PlayerManager.player.spins_left) + " spins left"
	else:
		%SpinsLeft.text = "No spins left"
	
	
func _on_key_button_pressed():
	if PlayerManager.player.spins_left > 0:
		if %Slot.spinning == false and %Slot2.spinning == false or %Slot3.spinning == false:
			%Slot.spinning = true
			%Slot2.spinning = true
			%Slot3.spinning = true
			pull()
			PlayerManager.player.spins_left -= 1

func load_result():
	if %Slot.result != null and %Slot2.result != null and %Slot3.result != null:
		print(%Slot.result)
		print(%Slot2.result)
		print(%Slot3.result)
		handle_result()
		%Slot.result = null
		%Slot2.result = null
		%Slot3.result = null

func material_effect(effect, pos):
	var current = effect.instantiate()
	current.position = pos
	add_child(current)

func handle_result():
	$AudioStreamPlayer.stop()
	#Jackpots
	if %Slot.result == "blue" and %Slot.result == %Slot2.result and %Slot.result == %Slot3.result:
		EffectLoad.material_effect(blue_gem_effect, result1)
		EffectLoad.material_effect(blue_gem_effect, result2)
		EffectLoad.material_effect(blue_gem_effect, result3)
		Sfx.play_SFX(Sfx.slot_win)
		await get_tree().create_timer(0.8).timeout
		PlayerManager.player.blue_gem_up(22)
		jackpot = true
	elif %Slot.result == "red" and %Slot.result == %Slot2.result and %Slot.result == %Slot3.result:
		EffectLoad.material_effect(red_gem_effect, result1)
		EffectLoad.material_effect(red_gem_effect, result2)
		EffectLoad.material_effect(red_gem_effect, result3)
		Sfx.play_SFX(Sfx.slot_win)
		await get_tree().create_timer(0.8).timeout
		PlayerManager.player.red_gem_up(22)
		jackpot = true
	elif %Slot.result == "green" and %Slot.result == %Slot2.result and %Slot.result == %Slot3.result:
		EffectLoad.material_effect(green_gem_effect, result1)
		EffectLoad.material_effect(green_gem_effect, result2)
		EffectLoad.material_effect(green_gem_effect, result3)
		Sfx.play_SFX(Sfx.slot_win)
		await get_tree().create_timer(0.8).timeout
		PlayerManager.player.green_gem_up(22)
		jackpot = true
	elif %Slot.result == "yellow" and %Slot.result == %Slot2.result and %Slot.result == %Slot3.result:
		EffectLoad.material_effect(yellow_gem_effect, result1)
		EffectLoad.material_effect(yellow_gem_effect, result2)
		EffectLoad.material_effect(yellow_gem_effect, result3)
		Sfx.play_SFX(Sfx.slot_win)
		await get_tree().create_timer(0.8).timeout
		PlayerManager.player.yellow_gem_up(22)
		jackpot = true
	else:
		if %Slot.result == "blue":
			EffectLoad.material_effect(blue_gem_effect, result1)
			Sfx.play_SFX(Sfx.slot_win)
		elif %Slot.result == "red":
			EffectLoad.material_effect(red_gem_effect, result1)
			Sfx.play_SFX(Sfx.slot_win)
		elif %Slot.result == "green":
			EffectLoad.material_effect(green_gem_effect, result1)
			Sfx.play_SFX(Sfx.slot_win)
		elif %Slot.result == "yellow":
			EffectLoad.material_effect(yellow_gem_effect, result1)
			Sfx.play_SFX(Sfx.slot_win)
			
		if %Slot2.result == "blue":
			EffectLoad.material_effect(blue_gem_effect, result2)
			Sfx.play_SFX(Sfx.slot_win)
		elif %Slot2.result == "red":
			EffectLoad.material_effect(red_gem_effect, result2)
			Sfx.play_SFX(Sfx.slot_win)
		elif %Slot2.result == "green":
			EffectLoad.material_effect(green_gem_effect, result2)
			Sfx.play_SFX(Sfx.slot_win)
		elif %Slot2.result == "yellow":
			EffectLoad.material_effect(yellow_gem_effect, result2)
			Sfx.play_SFX(Sfx.slot_win)
		
		if %Slot3.result == "blue":
			EffectLoad.material_effect(blue_gem_effect, result3)
			Sfx.play_SFX(Sfx.slot_win)
		elif %Slot3.result == "red":
			EffectLoad.material_effect(red_gem_effect, result3)
			Sfx.play_SFX(Sfx.slot_win)
		elif %Slot3.result == "green":
			EffectLoad.material_effect(green_gem_effect, result3)
			Sfx.play_SFX(Sfx.slot_win)
		elif %Slot3.result == "yellow":
			EffectLoad.material_effect(yellow_gem_effect, result3)
			Sfx.play_SFX(Sfx.slot_win)
	
	jackpot = false
	
func _on_continue_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	if PlayerManager.player.spins_left > 0:
		move_tween($SpinsLeft,Vector2(-98,-58),0.8)
		move_tween($Continue,Vector2(791,-12),0.8)
	else:
		visible = false
		if PlayerManager.player.player_won == true:
			if LevelManager.tutorial_completed:
				handle_tutorial_completed()
			else:
				Music.music_to_normal()
				PlayerManager.player.set_treasure()
				LevelManager.tutorial_completed = true
				LevelManager.handle_winning = true
		else:
			Music.music_to_normal()
			LevelManager.switch_to_dungeon_map_timeless()
		

func _on_yes_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	if PlayerManager.player.player_won == true:
		if LevelManager.tutorial_completed:
			handle_tutorial_completed()
		else:
			PlayerManager.player.set_treasure()
			LevelManager.tutorial_completed = true
			LevelManager.handle_winning = true
	else:
		Music.music_to_normal()
		LevelManager.switch_to_dungeon_map_timeless()

func handle_tutorial_completed():
	Music.music_to_normal()
	PlayerManager.player.coins = round(PlayerManager.player.coins / 2)
	PlayerManager.player.red_gem = round(PlayerManager.player.red_gem / 2)
	PlayerManager.player.yellow_gem = round(PlayerManager.player.yellow_gem / 2)
	PlayerManager.player.green_gem = round(PlayerManager.player.green_gem / 2)
	PlayerManager.player.blue_gem = round(PlayerManager.player.blue_gem / 2)
	PlayerManager.player.wood = round(PlayerManager.player.wood / 2)
	PlayerManager.player.stone = round(PlayerManager.player.stone / 2)
	PlayerManager.player.iron = round(PlayerManager.player.iron / 2)
	PlayerManager.player.set_treasure()
	LevelManager.tutorial_completed = true
	LevelManager.handle_winning = true

func _on_no_pressed():
	Sfx.play_SFX(Sfx.button_confirm)
	move_tween($SpinsLeft,Vector2(-861,-58),0.8)
	move_tween($Continue,Vector2(84,-12),0.8)
	
func _on_continue_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	$Continue/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_continue_mouse_exited():
	$Continue/Label.add_theme_color_override("font_color", Color.WHITE)


func _on_yes_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	$SpinsLeft/Yes/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_yes_mouse_exited():
	$SpinsLeft/Yes/Label.add_theme_color_override("font_color", Color.WHITE)
func _on_no_mouse_entered():
	Sfx.play_SFX(Sfx.in_game_hover)
	$SpinsLeft/No/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_no_mouse_exited():
	$SpinsLeft/No/Label.add_theme_color_override("font_color", Color.WHITE)

#Tweens
func move_tween(object,pos,time):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property(object,"position",pos,time)
