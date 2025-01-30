extends Control

var blue_gem = load("res://assets/32rogues/gems/blue.png")
var yellow_gem = load("res://assets/32rogues/gems/yellow.png")
var green_gem = load("res://assets/32rogues/gems/green.png")
var red_gem = load("res://assets/32rogues/gems/red.png")
var jackpot = false

func _process(delta):
	update_spins()

func pull():
	
	$Key.play("open")
	await get_tree().create_timer(0.2).timeout
	tween()
	await get_tree().create_timer(0.9).timeout
	tween_back()
	
	
	%Slot._handle_pulled()
	
	%Slot2._handle_pulled()
	
	%Slot3._handle_pulled()


func tween():
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
		
func handle_result():
	#Jackpots
	if %Slot.result == "blue" and %Slot.result == %Slot2.result and %Slot.result == %Slot3.result:
		PlayerManager.player.blue_gem_up(25)
		print("blue jackpot")
		jackpot = true
		%SlotResultSprite.texture = blue_gem
		%SlotResult.text = "+ 25"
	elif %Slot.result == "red" and %Slot.result == %Slot2.result and %Slot.result == %Slot3.result:
		PlayerManager.player.red_gem_up(25)
		print("red jackpot")
		jackpot = true
		%SlotResultSprite.texture = red_gem
		%SlotResult.text = "+ 25"
	elif %Slot.result == "green" and %Slot.result == %Slot2.result and %Slot.result == %Slot3.result:
		PlayerManager.player.green_gem_up(25)
		print("green jackpot")
		jackpot = true
		%SlotResultSprite.texture = green_gem
		%SlotResult.text = "+ 25"
	elif %Slot.result == "yellow" and %Slot.result == %Slot2.result and %Slot.result == %Slot3.result:
		PlayerManager.player.yellow_gem_up(25)
		print("yellow jackpot")
		jackpot = true
		%SlotResultSprite.texture = yellow_gem
		%SlotResult.text = "+ 25"
	else:
		%SlotResult.text = "+ 1"
		%Slot2Result.text = "+ 1"
		%Slot3Result.text = "+ 1"
		if %Slot.result == "blue":
			PlayerManager.player.blue_gem_up(1)
			%SlotResultSprite.texture = blue_gem
		elif %Slot.result == "red":
			PlayerManager.player.red_gem_up(1)
			%SlotResultSprite.texture = red_gem
		elif %Slot.result == "green":
			PlayerManager.player.green_gem_up(1)
			%SlotResultSprite.texture = green_gem
		elif %Slot.result == "yellow":
			PlayerManager.player.yellow_gem_up(1)
			%SlotResultSprite.texture = yellow_gem
			
		if %Slot2.result == "blue":
			PlayerManager.player.blue_gem_up(1)
			%Slot2ResultSprite.texture = blue_gem
		elif %Slot2.result == "red":
			PlayerManager.player.red_gem_up(1)
			%Slot2ResultSprite.texture = red_gem
		elif %Slot2.result == "green":
			PlayerManager.player.green_gem_up(1)
			%Slot2ResultSprite.texture = green_gem
		elif %Slot2.result == "yellow":
			PlayerManager.player.yellow_gem_up(1)
			%Slot2ResultSprite.texture = yellow_gem
		
		if %Slot3.result == "blue":
			PlayerManager.player.blue_gem_up(1)
			%Slot3ResultSprite.texture = blue_gem
		elif %Slot3.result == "red":
			PlayerManager.player.red_gem_up(1)
			%Slot3ResultSprite.texture = red_gem
		elif %Slot3.result == "green":
			PlayerManager.player.green_gem_up(1)
			%Slot3ResultSprite.texture = green_gem
		elif %Slot3.result == "yellow":
			PlayerManager.player.yellow_gem_up(1)
			%Slot3ResultSprite.texture = yellow_gem
			
	%Results.visible = true
	if jackpot == true:
		%Slot2Result.visible = false
		%Slot3Result.visible = false
	tween_results_up()
	await get_tree().create_timer(2).timeout
	%Results.position = Vector2(182,-60)
	%Slot2Result.visible = true
	%Slot3Result.visible = true
	%Results.visible = false
	jackpot = false
	
func tween_results_up():
	var tween = create_tween()
	tween.tween_property(%Results, "position", Vector2(182,-150),1.5)



func _on_continue_pressed():
	if PlayerManager.player.spins_left > 0:
		$SpinsLeft.visible = true
	else:
		if PlayerManager.player.player_won == true:
			LevelManager.handle_winning = true
		else:
			LevelManager.switch_to_dungeon_map_timeless()
		

func _on_yes_pressed():
	if PlayerManager.player.player_won == true:
		LevelManager.handle_winning = true
	else:
		LevelManager.switch_to_dungeon_map_timeless()


func _on_no_pressed():
	$SpinsLeft.visible = false
