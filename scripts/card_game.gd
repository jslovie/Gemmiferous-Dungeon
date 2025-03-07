extends Control

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
	%Card1.visible = false
	%Card2.visible = false
	%Card3.visible = false
	%Card4.visible = false
	%Card5.visible = false
	%Card6.visible = false
	$Score.visible = false
	$EnemyScore.visible = false
	
	
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
		print(selected_card)
		print(cards_pack)
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
	$Card1.texture = null
	$Card2.texture = null
	%Card3.texture = null
	%Card4.texture = null
	%Card5.texture = null
	%Card6.texture = null
	card_6 = null
	
func check_result():
	if score > 21:
		$Result.visible = true
		$Result.text = "You Lost!"
	elif score <= 21 and enemy_score <= 21 and enemy_score > score:
		$Result.visible = true
		$Result.text = "You Lost!"
	elif score <= 21 and enemy_score <= 21 and enemy_score < score:
		$Result.visible = true
		$Result.text = "You Won!"
	elif score <= 21 and enemy_score > 21:
		$Result.visible = true
		$Result.text = "You Won!"

	
func _on_pick_card_pressed():
	pick_card($Card1)
	$Card1.visible = true
	update_score()
	await get_tree().create_timer(card_wait_time).timeout
	pick_card($Card2)
	$Card2.visible = true
	update_score()
	await get_tree().create_timer(card_wait_time).timeout
	pick_card($Card5)
	$Score.visible = true
	$Card5.visible = true
	update_score()
	await get_tree().create_timer(card_wait_time).timeout
	pick_card($Card6)
	$Card6.visible = true
	update_score()
	$EnemyScore.visible = true
	
	pass

func pick_card(card):
	var card_to_change = card
	var selected_card = get_card()
	if selected_card == "Ace of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_17.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 11
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 11
		else:
			score += 11
	elif selected_card == "2 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_18.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 2
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 2
		else:
			score += 2
	elif selected_card == "3 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_19.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 3
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 3
		else:
			score += 3
	elif selected_card == "4 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_20.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 4
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 4
		else:
			score += 4
	elif selected_card == "5 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_21.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 5
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 5
		else:
			score += 5
	elif selected_card == "6 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_22.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 6
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 6
		else:
			score += 6
	elif selected_card == "7 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_23.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 7
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 7
		else:
			score += 7
	elif selected_card == "8 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_24.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 8
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 8
		else:
			score += 8
	elif selected_card == "9 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_25.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 9
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 9
		else:
			score += 9
	elif selected_card == "10 of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_26.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Jack of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_27.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Queen of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_28.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "King of Spades":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_29.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Ace of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_2.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 11
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 11
		else:
			score += 11
	elif selected_card == "2 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_3.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 2
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 2
		else:
			score += 2
	elif selected_card == "3 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_4.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 3
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 3
		else:
			score += 3
	elif selected_card == "4 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_5.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 4
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 4
		else:
			score += 4
	elif selected_card == "5 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_6.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 5
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 5
		else:
			score += 5
	elif selected_card == "6 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_7.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 6
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 6
		else:
			score += 6
	elif selected_card == "7 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_8.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 7
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 7
		else:
			score += 7
	elif selected_card == "8 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_9.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 8
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 8
		else:
			score += 8
	elif selected_card == "9 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_10.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 9
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 9
		else:
			score += 9
	elif selected_card == "10 of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_11.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Jack of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_12.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Queen of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_13.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "King of Hearts":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_14.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Ace of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_47.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 11
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 11
		else:
			score += 11
	elif selected_card == "2 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_48.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 2
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 2
		else:
			score += 2
	elif selected_card == "3 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_49.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 3
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 3
		else:
			score += 3
	elif selected_card == "4 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_50.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 4
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 4
		else:
			score += 4
	elif selected_card == "5 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_51.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 5
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 5
		else:
			score += 5
	elif selected_card == "6 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_52.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 6
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 6
		else:
			score += 6
	elif selected_card == "7 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_53.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 7
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 7
		else:
			score += 7
	elif selected_card == "8 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_54.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 8
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 8
		else:
			score += 8
	elif selected_card == "9 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_55.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 9
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 9
		else:
			score += 9
	elif selected_card == "10 of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_56.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Jack of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_57.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Queen of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_58.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "King of Clubs":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_59.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Ace of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_32.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 11
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 11
		else:
			score += 11
	elif selected_card == "2 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_33.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 2
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 2
		else:
			score += 2
	elif selected_card == "3 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_34.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 3
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 3
		else:
			score += 3
	elif selected_card == "4 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_35.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 4
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 4
		else:
			score += 4
	elif selected_card == "5 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_36.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 5
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 5
		else:
			score += 5
	elif selected_card == "6 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_37.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 6
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 6
		else:
			score += 6
	elif selected_card == "7 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_38.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 7
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 7
		else:
			score += 7
	elif selected_card == "8 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_39.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 8
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 8
		else:
			score += 8
	elif selected_card == "9 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_40.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 9
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 9
		else:
			score += 9
	elif selected_card == "10 of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_41.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Jack of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_42.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "Queen of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_43.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	elif selected_card == "King of Diamonds":
		card_to_change.texture = load("res://assets/Cards/Cards Collection 1-2_tile_44.png")
		if card == %Card6:
			card_6 = selected_card
			card_6_score += 10
			card_to_change.texture = load("res://assets/cards/Cards Collection 1-2_tile_65.png")
		if card == %Card5:
			enemy_score += 10
		else:
			score += 10
	print(score)


func _on_shuffle_pressed():
	shufle_pack()
	print(cards_pack)


func _on_back_to_village_pressed():
	get_tree().change_scene_to_file("res://scenes/village.tscn")


func _on_end_turn_pressed():
	change_card_6(%Card6)
	enemy_score += card_6_score
	update_score()
	
	check_result()
	
	await get_tree().create_timer(2).timeout
	$Result.visible = false
	reset_score()
	reset_cards()
	shufle_pack()


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
