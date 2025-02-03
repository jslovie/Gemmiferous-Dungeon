extends Control

var score = 0


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
	$Card1.visible = false
	$Card2.visible = false

	
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

func reset_score():
	$Score.text = "score is: 0" 
	score = 0

func reset_cards():
	$Card1.texture = null
	$Card2.texture = null
	%Card3.texture = null
	%Card4.texture = null
	
func check_result():
	if score > 21:
		$Result.visible = true
		$Result.text = "You Lost!"
	if score <= 21:
		$Result.visible = true
		$Result.text = "You Won!"
	

	
func _on_button_pressed():
	pick_card1()
	$Card1.visible = true
	update_score()
	await get_tree().create_timer(1).timeout
	pick_card2()
	$Card2.visible = true
	update_score()
	
	check_result()
	
	await get_tree().create_timer(2).timeout
	$Result.visible = false
	reset_score()
	reset_cards()
	shufle_pack()
	
func pick_card1():
	var selected_card = get_card()
	if selected_card == "Ace of Spades":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_17.png")
		score += 11
	elif selected_card == "2 of Spades":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_18.png")
		score += 2
	elif selected_card == "3 of Spades":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_19.png")
		score += 3
	elif selected_card == "4 of Spades":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_20.png")
		score += 4
	elif selected_card == "5 of Spades":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_21.png")
		score += 5
	elif selected_card == "6 of Spades":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_22.png")
		score += 6
	elif selected_card == "7 of Spades":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_23.png")
		score += 7
	elif selected_card == "8 of Spades":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_24.png")
		score += 8
	elif selected_card == "9 of Spades":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_25.png")
		score += 9
	elif selected_card == "10 of Spades":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_26.png")
		score += 10
	elif selected_card == "Jack of Spades":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_27.png")
		score += 10
	elif selected_card == "Queen of Spades":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_28.png")
		score += 10
	elif selected_card == "King of Spades":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_29.png")
		score += 10
	elif selected_card == "Ace of Hearts":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_2.png")
		score += 11	
	elif selected_card == "2 of Hearts":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_3.png")
		score += 2
	elif selected_card == "3 of Hearts":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_4.png")
		score += 3
	elif selected_card == "4 of Hearts":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_5.png")
		score += 4
	elif selected_card == "5 of Hearts":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_6.png")
		score += 5
	elif selected_card == "6 of Hearts":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_7.png")
		score += 6
	elif selected_card == "7 of Hearts":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_8.png")
		score += 7
	elif selected_card == "8 of Hearts":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_9.png")
		score += 8
	elif selected_card == "9 of Hearts":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_10.png")
		score += 9
	elif selected_card == "10 of Hearts":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_11.png")
		score += 10
	elif selected_card == "Jack of Hearts":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_12.png")
		score += 10
	elif selected_card == "Queen of Hearts":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_13.png")
		score += 10
	elif selected_card == "King of Hearts":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_14.png")
		score += 10
	elif selected_card == "Ace of Clubs":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_47.png")
		score += 11	
	elif selected_card == "2 of Clubs":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_48.png")
		score += 2
	elif selected_card == "3 of Clubs":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_49.png")
		score += 3
	elif selected_card == "4 of Clubs":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_50.png")
		score += 4
	elif selected_card == "5 of Clubs":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_51.png")
		score += 5
	elif selected_card == "6 of Clubs":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_52.png")
		score += 6
	elif selected_card == "7 of Clubs":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_53.png")
		score += 7
	elif selected_card == "8 of Clubs":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_54.png")
		score += 8
	elif selected_card == "9 of Clubs":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_55.png")
		score += 9
	elif selected_card == "10 of Clubs":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_56.png")
		score += 10
	elif selected_card == "Jack of Clubs":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_57.png")
		score += 10
	elif selected_card == "Queen of Clubs":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_58.png")
		score += 10
	elif selected_card == "King of Clubs":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_59.png")
		score += 10
	elif selected_card == "Ace of Diamonds":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_32.png")
		score += 11	
	elif selected_card == "2 of Diamonds":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_33.png")
		score += 2
	elif selected_card == "3 of Diamonds":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_34.png")
		score += 3
	elif selected_card == "4 of Diamonds":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_35.png")
		score += 4
	elif selected_card == "5 of Diamonds":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_36.png")
		score += 5
	elif selected_card == "6 of Diamonds":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_37.png")
		score += 6
	elif selected_card == "7 of Diamonds":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_38.png")
		score += 7
	elif selected_card == "8 of Diamonds":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_39.png")
		score += 8
	elif selected_card == "9 of Diamonds":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_40.png")
		score += 9
	elif selected_card == "10 of Diamonds":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_41.png")
		score += 10
	elif selected_card == "Jack of Diamonds":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_42.png")
		score += 10
	elif selected_card == "Queen of Diamonds":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_43.png")
		score += 10
	elif selected_card == "King of Diamonds":
		$Card1.texture = load("res://assets/Cards/Cards Collection 1-2_tile_44.png")
		score += 10
	print(score)
	
func pick_card2():
	var selected_card = get_card()
	if selected_card == "Ace of Spades":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_17.png")
		score += 11
	elif selected_card == "2 of Spades":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_18.png")
		score += 2
	elif selected_card == "3 of Spades":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_19.png")
		score += 3
	elif selected_card == "4 of Spades":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_20.png")
		score += 4
	elif selected_card == "5 of Spades":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_21.png")
		score += 5
	elif selected_card == "6 of Spades":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_22.png")
		score += 6
	elif selected_card == "7 of Spades":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_23.png")
		score += 7
	elif selected_card == "8 of Spades":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_24.png")
		score += 8
	elif selected_card == "9 of Spades":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_25.png")
		score += 9
	elif selected_card == "10 of Spades":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_26.png")
		score += 10
	elif selected_card == "Jack of Spades":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_27.png")
		score += 10
	elif selected_card == "Queen of Spades":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_28.png")
		score += 10
	elif selected_card == "King of Spades":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_29.png")
		score += 10
	elif selected_card == "Ace of Hearts":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_2.png")
		score += 11	
	elif selected_card == "2 of Hearts":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_3.png")
		score += 2
	elif selected_card == "3 of Hearts":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_4.png")
		score += 3
	elif selected_card == "4 of Hearts":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_5.png")
		score += 4
	elif selected_card == "5 of Hearts":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_6.png")
		score += 5
	elif selected_card == "6 of Hearts":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_7.png")
		score += 6
	elif selected_card == "7 of Hearts":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_8.png")
		score += 7
	elif selected_card == "8 of Hearts":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_9.png")
		score += 8
	elif selected_card == "9 of Hearts":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_10.png")
		score += 9
	elif selected_card == "10 of Hearts":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_11.png")
		score += 10
	elif selected_card == "Jack of Hearts":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_12.png")
		score += 10
	elif selected_card == "Queen of Hearts":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_13.png")
		score += 10
	elif selected_card == "King of Hearts":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_14.png")
		score += 10
	elif selected_card == "Ace of Clubs":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_47.png")
		score += 11	
	elif selected_card == "2 of Clubs":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_48.png")
		score += 2
	elif selected_card == "3 of Clubs":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_49.png")
		score += 3
	elif selected_card == "4 of Clubs":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_50.png")
		score += 4
	elif selected_card == "5 of Clubs":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_51.png")
		score += 5
	elif selected_card == "6 of Clubs":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_52.png")
		score += 6
	elif selected_card == "7 of Clubs":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_53.png")
		score += 7
	elif selected_card == "8 of Clubs":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_54.png")
		score += 8
	elif selected_card == "9 of Clubs":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_55.png")
		score += 9
	elif selected_card == "10 of Clubs":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_56.png")
		score += 10
	elif selected_card == "Jack of Clubs":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_57.png")
		score += 10
	elif selected_card == "Queen of Clubs":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_58.png")
		score += 10
	elif selected_card == "King of Clubs":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_59.png")
		score += 10
	elif selected_card == "Ace of Diamonds":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_32.png")
		score += 11	
	elif selected_card == "2 of Diamonds":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_33.png")
		score += 2
	elif selected_card == "3 of Diamonds":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_34.png")
		score += 3
	elif selected_card == "4 of Diamonds":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_35.png")
		score += 4
	elif selected_card == "5 of Diamonds":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_36.png")
		score += 5
	elif selected_card == "6 of Diamonds":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_37.png")
		score += 6
	elif selected_card == "7 of Diamonds":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_38.png")
		score += 7
	elif selected_card == "8 of Diamonds":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_39.png")
		score += 8
	elif selected_card == "9 of Diamonds":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_40.png")
		score += 9
	elif selected_card == "10 of Diamonds":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_41.png")
		score += 10
	elif selected_card == "Jack of Diamonds":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_42.png")
		score += 10
	elif selected_card == "Queen of Diamonds":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_43.png")
		score += 10
	elif selected_card == "King of Diamonds":
		$Card2.texture = load("res://assets/Cards/Cards Collection 1-2_tile_44.png")
		score += 10
	print(score)
		


func _on_button_2_pressed():
	shufle_pack()
	print(cards_pack)


func _on_back_to_village_pressed():
	get_tree().change_scene_to_file("res://scenes/village.tscn")
