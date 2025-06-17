extends Control

var amount_bet = 0
var amount_win = 0

var coin_pos = Vector2(0,-128)
var yellow_gem_pos = Vector2(0,-96)
var green_gem_pos = Vector2(0,-64)
var red_gem_pos = Vector2(0,-32)
var blue_gem_pos = Vector2(0,0)

var score = 0
var enemy_score = 0
var card_wait_time = 1

var card_6 
var card_6_score = 0

var cards_pack = {
	one = "Ace of Spades",
	two = "2 of Spades",
	three = "3 of Spades",
	four = "4 of Spades",
	five = "5 of Spades",
	six = "6 of Spades",
	seven = "7 of Spades",
	eight = "8 of Spades",
	nine = "9 of Spades",
	ten = "10 of Spades",
	eleven = "Jack of Spades",
	twelve = "Queen of Spades",
	thirteen = "King of Spades",
	fourteen = "Ace of Hearts",
	fifteen = "2 of Hearts",
	sixteen = "3 of Hearts",
	seventeen = "4 of Hearts",
	eighteen = "5 of Hearts",
	nineteen = "6 of Hearts",
	twenty = "7 of Hearts",
	twentyone = "8 of Hearts",
	twetytwo = "9 of Hearts",
	twentythree = "10 of Hearts",
	twentyfour = "Jack of Hearts",
	twentyfive = "Queen of Hearts",
	twentysix = "King of Hearts",
	twentyseven = "Ace of Clubs",
	twentyeight = "2 of Clubs",
	twentynine = "3 of Clubs",
	thirty = "4 of Clubs",
	thirtyone = "5 of Clubs",
	thirtytwo = "6 of Clubs",
	thirtythree = "7 of Clubs",
	thirtyfour = "8 of Clubs",
	thirtyfive = "9 of Clubs",
	thirtysix = "10 of Clubs",
	thirtyseven = "Jack of Clubs",
	thirtyeight = "Queen of Clubs",
	thirtynine = "King of Clubs",
	fourty = "Ace of Diamonds",
	fourtyone = "2 of Diamonds",
	fourtytwo = "3 of Diamonds",
	fourtythree = "4 of Diamonds",
	fourtyfour = "5 of Diamonds",
	fourtyfive = "6 of Diamonds",
	fourtysix = "7 of Diamonds",
	fourtyseven = "8 of Diamonds",
	fourtyeight = "9 of Diamonds",
	fourtynine = "10 of Diamonds",
	fifty = "Jack of Diamonds",
	fiftyone = "Queen of Diamonds",
	fiftytwo = "King of Diamonds",
}

func _ready():
	SaveManager.load_savefile()
	reset_cards()
	Music.play_music_tavern()
	$Hit.visible = false
	$EndTurn.visible = false
	$Score.visible = false
	$EnemyScore.visible = false
	$Result.visible = false
	$NotEnough.visible = false
	
func _process(delta):
	update_materials()
	update_treasures()
	set_bet_win_amounts()

func update_treasures():
	$Gems/HBoxContainer/RedGem.text = ": " + str(PlayerManager.player.total_red_gem)
	$Gems/HBoxContainer/BlueGem.text = ": " + str(PlayerManager.player.total_blue_gem)
	$Gems/HBoxContainer/GreenGem.text = ": " + str(PlayerManager.player.total_green_gem)
	$Gems/HBoxContainer/YellowGem.text = ": " + str(PlayerManager.player.total_yellow_gem)
	$Material/HBoxContainer/Coin.text = ": " + str(PlayerManager.player.total_coins)
	
func update_materials():
	$Material/HBoxContainer/Wood.text = ": " + str(PlayerManager.player.total_wood)
	$Material/HBoxContainer/Stone.text = ": " + str(PlayerManager.player.total_stone)
	$Material/HBoxContainer/Iron.text = ": " + str(PlayerManager.player.total_iron)

	
func shufle_pack():
	cards_pack = {
	one = "Ace of Spades",
	two = "2 of Spades",
	three = "3 of Spades",
	four = "4 of Spades",
	five = "5 of Spades",
	six = "6 of Spades",
	seven = "7 of Spades",
	eight = "8 of Spades",
	nine = "9 of Spades",
	ten = "10 of Spades",
	eleven = "Jack of Spades",
	twelve = "Queen of Spades",
	thirteen = "King of Spades",
	fourteen = "Ace of Hearts",
	fifteen = "2 of Hearts",
	sixteen = "3 of Hearts",
	seventeen = "4 of Hearts",
	eighteen = "5 of Hearts",
	nineteen = "6 of Hearts",
	twenty = "7 of Hearts",
	twentyone = "8 of Hearts",
	twetytwo = "9 of Hearts",
	twentythree = "10 of Hearts",
	twentyfour = "Jack of Hearts",
	twentyfive = "Queen of Hearts",
	twentysix = "King of Hearts",
	twentyseven = "Ace of Clubs",
	twentyeight = "2 of Clubs",
	twentynine = "3 of Clubs",
	thirty = "4 of Clubs",
	thirtyone = "5 of Clubs",
	thirtytwo = "6 of Clubs",
	thirtythree = "7 of Clubs",
	thirtyfour = "8 of Clubs",
	thirtyfive = "9 of Clubs",
	thirtysix = "10 of Clubs",
	thirtyseven = "Jack of Clubs",
	thirtyeight = "Queen of Clubs",
	thirtynine = "King of Clubs",
	fourty = "Ace of Diamonds",
	fourtyone = "2 of Diamonds",
	fourtytwo = "3 of Diamonds",
	fourtythree = "4 of Diamonds",
	fourtyfour = "5 of Diamonds",
	fourtyfive = "6 of Diamonds",
	fourtysix = "7 of Diamonds",
	fourtyseven = "8 of Diamonds",
	fourtyeight = "9 of Diamonds",
	fourtynine = "10 of Diamonds",
	fifty = "Jack of Diamonds",
	fiftyone = "Queen of Diamonds",
	fiftytwo = "King of Diamonds",
	}

func get_card():
	if cards_pack.size() > 0 :
		var cards_pack_keys = cards_pack.keys()
		var random_card = cards_pack_keys[randi() % cards_pack.size()]
		var selected_card = cards_pack[random_card]
		cards_pack.erase(random_card)
		return selected_card

func update_score():
	$Score.text = "score is: " + str(score)
	$EnemyScore.text = "score is: " + str(enemy_score)

func reset_score():
	$Score.text = "score is: 0" 
	score = 0
	enemy_score = 0
	card_6_score = 0
	$Score.visible = false
	$EnemyScore.visible = false

func reset_cards():
	%Card1.texture = null
	%Card2.texture = null
	%Card3.texture = null
	%Card4.texture = null
	%Card5.texture = null
	%Card6.texture = null
	%Card7.texture = null
	%Card8.texture = null
	%Card1.visible = false
	%Card2.visible = false
	%Card3.visible = false
	%Card4.visible = false
	%Card5.visible = false
	%Card6.visible = false
	%Card7.visible = false
	%Card8.visible = false
	
	card_6 = null
	
func check_result():
	await get_tree().create_timer(1).timeout
	$Result.visible = true
	if score > 21:
		$Result.text = "You Lost!"
	elif score <= 21 and enemy_score <= 21 and enemy_score > score:
		$Result.text = "You Lost!"
	elif score <= 21 and enemy_score <= 21 and enemy_score < score:
		$Result.text = "You Won!"
		process_win(amount_win)
	elif score <= 21 and enemy_score > 21:
		$Result.text = "You Won!"
		process_win(amount_win)
	elif score == enemy_score:
		$Result.text = "Draw!"
		process_win(amount_bet)
	SaveManager.savefilesave()

func process_bet(amount):
	if $Bet/BetT/Row.position == red_gem_pos:
		PlayerManager.player.total_red_gem -= amount
	elif $Bet/BetT/Row.position == blue_gem_pos:
		PlayerManager.player.total_blue_gem -= amount
	elif $Bet/BetT/Row.position == green_gem_pos:
		PlayerManager.player.total_green_gem -= amount
	elif $Bet/BetT/Row.position == yellow_gem_pos:
		PlayerManager.player.total_yellow_gem -= amount
	elif $Bet/BetT/Row.position == coin_pos:
		PlayerManager.player.total_coins -= amount
		SaveManager.savefilesave()

func process_win(amount):
	if $Win/WinT/Row.position == red_gem_pos:
		PlayerManager.player.total_red_gem += amount
	elif $Win/WinT/Row.position == blue_gem_pos:
		PlayerManager.player.total_blue_gem += amount
	elif $Win/WinT/Row.position == green_gem_pos:
		PlayerManager.player.total_green_gem += amount
	elif $Win/WinT/Row.position == yellow_gem_pos:
		PlayerManager.player.total_yellow_gem += amount
	elif $Win/WinT/Row.position == coin_pos:
		PlayerManager.player.total_coins += amount
		SaveManager.savefilesave()

func check_enough(amount):
	if $Bet/BetT/Row.position == red_gem_pos:
		if PlayerManager.player.total_red_gem < amount:
			return false
		else:
			return true
	elif $Bet/BetT/Row.position == blue_gem_pos:
		if PlayerManager.player.total_blue_gem < amount:
			return false
		else:
			return true
	elif $Bet/BetT/Row.position == green_gem_pos:
		if PlayerManager.player.total_green_gem < amount:
			return false
		else:
			return true
	elif $Bet/BetT/Row.position == yellow_gem_pos:
		if PlayerManager.player.total_yellow_gem < amount:
			return false
		else:
			return true
	elif $Bet/BetT/Row.position == coin_pos:
		if PlayerManager.player.total_coins < amount:
			return false
		else:
			return true

func not_enough():
	Sfx.play_SFX(Sfx.upgrade_deny)
	$NotEnough.visible = true
	await get_tree().create_timer(1).timeout
	$NotEnough.visible = false

func pregame_info(action):
		$Bet.visible = action
		$Win.visible = action
		$PickCard.visible = action
		
	
func _on_pick_card_pressed():
	if check_enough(amount_bet):
		pregame_info(false)
		process_bet(amount_bet)
		
		pick_card(%Card1)
		%Card1.visible = true
		update_score()
		await get_tree().create_timer(card_wait_time).timeout
		pick_card(%Card2)
		%Card2.visible = true
		update_score()
		await get_tree().create_timer(card_wait_time).timeout
		pick_card(%Card5)
		$Score.visible = true
		%Card5.visible = true
		update_score()
		await get_tree().create_timer(card_wait_time).timeout
		pick_card(%Card6)
		%Card6.visible = true
		update_score()
		$EnemyScore.visible = true
		if score < 21:
			$Hit.visible = true
			$EndTurn.visible = true
		else:
			_on_end_turn_pressed()
			
	else:
		not_enough()

func pick_card(card):
	var card_to_change = card
	var selected_card = get_card()
	if selected_card == "Ace of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_17.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 11
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 11
		else:
			score += 11
	elif selected_card == "2 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_18.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 2
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 2
		else:
			score += 2
	elif selected_card == "3 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_19.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 3
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 3
		else:
			score += 3
	elif selected_card == "4 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_20.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 4
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 4
		else:
			score += 4
	elif selected_card == "5 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_21.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 5
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 5
		else:
			score += 5
	elif selected_card == "6 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_22.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 6
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 6
		else:
			score += 6
	elif selected_card == "7 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_23.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 7
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 7
		else:
			score += 7
	elif selected_card == "8 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_24.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 8
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 8
		else:
			score += 8
	elif selected_card == "9 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_25.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 9
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 9
		else:
			score += 9
	elif selected_card == "10 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_26.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Jack of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_27.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Queen of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_28.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "King of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_29.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Ace of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_2.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 11
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 11
		else:
			score += 11
	elif selected_card == "2 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_3.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 2
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 2
		else:
			score += 2
	elif selected_card == "3 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_4.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 3
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 3
		else:
			score += 3
	elif selected_card == "4 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_5.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 4
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 4
		else:
			score += 4
	elif selected_card == "5 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_6.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 5
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 5
		else:
			score += 5
	elif selected_card == "6 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_7.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 6
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 6
		else:
			score += 6
	elif selected_card == "7 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_8.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 7
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 7
		else:
			score += 7
	elif selected_card == "8 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_9.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 8
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 8
		else:
			score += 8
	elif selected_card == "9 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_10.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 9
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 9
		else:
			score += 9
	elif selected_card == "10 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_11.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Jack of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_12.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Queen of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_13.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "King of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_14.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Ace of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_47.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 11
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 11
		else:
			score += 11
	elif selected_card == "2 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_48.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 2
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 2
		else:
			score += 2
	elif selected_card == "3 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_49.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 3
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 3
		else:
			score += 3
	elif selected_card == "4 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_50.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 4
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 4
		else:
			score += 4
	elif selected_card == "5 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_51.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 5
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 5
		else:
			score += 5
	elif selected_card == "6 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_52.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 6
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 6
		else:
			score += 6
	elif selected_card == "7 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_53.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 7
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 7
		else:
			score += 7
	elif selected_card == "8 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_54.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 8
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 8
		else:
			score += 8
	elif selected_card == "9 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_55.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 9
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 9
		else:
			score += 9
	elif selected_card == "10 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_56.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Jack of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_57.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Queen of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_58.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "King of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_59.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Ace of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_32.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 11
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 11
		else:
			score += 11
	elif selected_card == "2 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_33.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 2
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 2
		else:
			score += 2
	elif selected_card == "3 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_34.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 3
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 3
		else:
			score += 3
	elif selected_card == "4 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_35.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 4
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 4
		else:
			score += 4
	elif selected_card == "5 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_36.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 5
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 5
		else:
			score += 5
	elif selected_card == "6 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_37.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 6
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 6
		else:
			score += 6
	elif selected_card == "7 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_38.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 7
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 7
		else:
			score += 7
	elif selected_card == "8 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_39.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 8
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 8
		else:
			score += 8
	elif selected_card == "9 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_40.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 9
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 9
		else:
			score += 9
	elif selected_card == "10 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_41.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Jack of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_42.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Queen of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_43.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "King of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_44.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		elif card == %Card5 or card == %Card7 or card == %Card8:
			enemy_score += 10
		else:
			score += 10

func enemy_play():
	if enemy_score > score:
		check_result()
		endgame()
	elif enemy_score == score: 
		check_result()
		endgame()
	else:
		await get_tree().create_timer(card_wait_time).timeout
		pick_card(%Card7)
		%Card7.visible = true
		update_score()
		if enemy_score >= 21:
			check_result()
			endgame()
		elif enemy_score < 21 and enemy_score < score:
			await get_tree().create_timer(card_wait_time).timeout
			pick_card(%Card8)
			%Card8.visible = true
			update_score()
			check_result()
			endgame()
		else:
			check_result()
			endgame()

func endgame():
	await get_tree().create_timer(3).timeout
	$Result.visible = false
	reset_score()
	reset_cards()
	shufle_pack()
	pregame_info(true)
	

func _on_shuffle_pressed():
	shufle_pack()


func _on_back_to_village_pressed():
	get_tree().change_scene_to_file("res://scenes/village.tscn")


func _on_end_turn_pressed():
	$Hit.visible = false
	$EndTurn.visible = false
	change_card_6(%Card6)
	enemy_score += card_6_score
	update_score()
	if score == 21 and enemy_score >= 21:
		check_result()
		endgame()
	elif score == 21 and enemy_score < 21:
		enemy_play()
	elif score > 21:
		check_result()
		endgame()
	elif score < 21 and enemy_score < 21:
		enemy_play()
	elif enemy_score > score:
		check_result()
		endgame()

func change_card_6(card):
	var card_to_change = card
	var selected_card = card_6
	if selected_card == "Ace of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_17.png")
	elif selected_card == "2 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_18.png")
	elif selected_card == "3 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_19.png")
	elif selected_card == "4 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_20.png")
	elif selected_card == "5 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_21.png")
	elif selected_card == "6 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_22.png")
	elif selected_card == "7 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_23.png")
	elif selected_card == "8 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_24.png")
	elif selected_card == "9 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_25.png")
	elif selected_card == "10 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_26.png")
	elif selected_card == "Jack of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_27.png")
	elif selected_card == "Queen of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_28.png")
	elif selected_card == "King of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_29.png")
	elif selected_card == "Ace of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_2.png")
	elif selected_card == "2 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_3.png")
	elif selected_card == "3 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_4.png")
	elif selected_card == "4 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_5.png")
	elif selected_card == "5 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_6.png")
	elif selected_card == "6 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_7.png")
	elif selected_card == "7 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_8.png")
	elif selected_card == "8 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_9.png")
	elif selected_card == "9 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_10.png")
	elif selected_card == "10 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_11.png")
	elif selected_card == "Jack of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_12.png")
	elif selected_card == "Queen of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_13.png")
	elif selected_card == "King of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_14.png")
	elif selected_card == "Ace of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_47.png")
	elif selected_card == "2 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_48.png")
	elif selected_card == "3 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_49.png")
	elif selected_card == "4 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_50.png")
	elif selected_card == "5 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_51.png")
	elif selected_card == "6 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_52.png")
	elif selected_card == "7 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_53.png")
	elif selected_card == "8 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_54.png")
	elif selected_card == "9 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_55.png")
	elif selected_card == "10 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_56.png")
	elif selected_card == "Jack of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_57.png")
	elif selected_card == "Queen of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_58.png")
	elif selected_card == "King of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_59.png")
	elif selected_card == "Ace of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_32.png")
	elif selected_card == "2 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_33.png")
	elif selected_card == "3 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_34.png")
	elif selected_card == "4 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_35.png")
	elif selected_card == "5 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_36.png")
	elif selected_card == "6 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_37.png")
	elif selected_card == "7 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_38.png")
	elif selected_card == "8 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_39.png")
	elif selected_card == "9 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_40.png")
	elif selected_card == "10 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_41.png")
	elif selected_card == "Jack of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_42.png")
	elif selected_card == "Queen of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_43.png")
	elif selected_card == "King of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_44.png")


func _on_hit_pressed():
	if %Card3.visible == false:
		pick_card(%Card3)
		%Card3.visible = true
		update_score()
		if score >= 21:
			_on_end_turn_pressed()
	else:
		pick_card(%Card4)
		%Card4.visible = true
		update_score()
		if score >= 21:
			_on_end_turn_pressed()
	if %Card3.visible == true and %Card4.visible == true:
		$Hit.visible = false

func scale_tween(object,siz,siz_f,time):
	var tween = create_tween()
	tween.tween_property(object,"scale",siz,time).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(object,"scale",siz_f,time).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
func _on_home_pressed():
	LevelManager.back_to_village()


func set_bet_win_amounts():
	$Bet/AmountBet.text = str(amount_bet)
	amount_win = amount_bet * 2
	$Win/AmountWin.text = str(amount_win)

func _on_amount_down_pressed():
	scale_tween($Bet/AmountDown,Vector2(2,2),Vector2(1.5,1.5),0.1)
	if amount_bet <= 5:
		amount_bet -= 1
		if amount_bet <= 0:
			amount_bet = 0
	elif amount_bet > 5:
		amount_bet -= 5
		if amount_bet <= 0:
			amount_bet = 0

func _on_amount_up_pressed():
	scale_tween($Bet/AmountUp,Vector2(2,2),Vector2(1.5,1.5),0.1)
	if amount_bet < 5:
		amount_bet += 1
		if amount_bet >= 95:
			amount_bet = 95
	elif amount_bet >= 5:
		amount_bet += 5
		if amount_bet >= 95:
			amount_bet = 95

func _on_bet_t_down_pressed():
	scale_tween($Bet/BetTDown,Vector2(2,2),Vector2(1.5,1.5),0.1)
	if $Bet/BetT/Row.position == coin_pos:
		$Bet/BetT/Row.position = blue_gem_pos
	elif $Bet/BetT/Row.position == blue_gem_pos:
		$Bet/BetT/Row.position = red_gem_pos
	elif $Bet/BetT/Row.position == red_gem_pos:
		$Bet/BetT/Row.position = green_gem_pos
	elif $Bet/BetT/Row.position == green_gem_pos:
		$Bet/BetT/Row.position = yellow_gem_pos
	elif $Bet/BetT/Row.position == yellow_gem_pos:
		$Bet/BetT/Row.position = coin_pos

func _on_bet_t_up_pressed():
	scale_tween($Bet/BetTUp,Vector2(2,2),Vector2(1.5,1.5),0.1)
	if $Bet/BetT/Row.position == coin_pos:
		$Bet/BetT/Row.position = yellow_gem_pos
	elif $Bet/BetT/Row.position == yellow_gem_pos:
		$Bet/BetT/Row.position = green_gem_pos
	elif $Bet/BetT/Row.position == green_gem_pos:
		$Bet/BetT/Row.position = red_gem_pos
	elif $Bet/BetT/Row.position == red_gem_pos:
		$Bet/BetT/Row.position = blue_gem_pos
	elif $Bet/BetT/Row.position == blue_gem_pos:
		$Bet/BetT/Row.position = coin_pos

func _on_win_t_down_pressed():
	scale_tween($Win/WinTDown,Vector2(2,2),Vector2(1.5,1.5),0.1)
	if $Win/WinT/Row.position == coin_pos:
		$Win/WinT/Row.position = blue_gem_pos
	elif $Win/WinT/Row.position == blue_gem_pos:
		$Win/WinT/Row.position = red_gem_pos
	elif $Win/WinT/Row.position == red_gem_pos:
		$Win/WinT/Row.position = green_gem_pos
	elif $Win/WinT/Row.position == green_gem_pos:
		$Win/WinT/Row.position = yellow_gem_pos
	elif $Win/WinT/Row.position == yellow_gem_pos:
		$Win/WinT/Row.position = coin_pos

func _on_win_t_up_pressed():
	scale_tween($Win/WinTUp,Vector2(2,2),Vector2(1.5,1.5),0.1)
	if $Win/WinT/Row.position == coin_pos:
		$Win/WinT/Row.position = yellow_gem_pos
	elif $Win/WinT/Row.position == yellow_gem_pos:
		$Win/WinT/Row.position = green_gem_pos
	elif $Win/WinT/Row.position == green_gem_pos:
		$Win/WinT/Row.position = red_gem_pos
	elif $Win/WinT/Row.position == red_gem_pos:
		$Win/WinT/Row.position = blue_gem_pos
	elif $Win/WinT/Row.position == blue_gem_pos:
		$Win/WinT/Row.position = coin_pos


func _on_pick_card_mouse_entered():
	$PickCard/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_pick_card_mouse_exited():
	$PickCard/Label.add_theme_color_override("font_color", Color.WHITE)
func _on_hit_mouse_entered():
	$Hit/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_hit_mouse_exited():
	$Hit/Label.add_theme_color_override("font_color", Color.WHITE)
func _on_end_turn_mouse_entered():
	$EndTurn/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_end_turn_mouse_exited():
	$EndTurn/Label.add_theme_color_override("font_color", Color.WHITE)
