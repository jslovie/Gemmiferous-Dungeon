extends AudioStreamPlayer

var menu_music = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Dark Fog.wav")
var village_music_1 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/The Wizard's Hut.wav")
var village_music_2 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Wintertime Venture.wav")
var village_music_3 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Hallowed Place.wav")
var tavern_music = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/A Hidden Tavern.wav")
var selection_music = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Visiting the Tribe.wav")
var shop_music = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Talking to the Peasants (Part I).wav")
var rest_music = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/By the Meadow.wav")
var random_event_music_1 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Talking to the Peasants (Part II).wav")
var random_event_music_2 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Talking to the Peasants (Part II).wav")
var treasure_music = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Moonlight Lullaby.wav")
var combat_music_1 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Adrenaline Blasts 1 (ordinary).wav")
var combat_music_2 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Adrenaline Blasts 1 (smooth).wav")
var combat_music_3 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Adrenaline Blasts 1 (tough).wav")
var combat_music_4 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Adrenaline Blasts 2 (ordinary).wav")
var combat_music_5 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Adrenaline Blasts 2 (smooth).wav")
var combat_music_6 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Adrenaline Blasts 2 (tough).wav")
var combat_music_7 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Adrenaline Blasts 3 (ordinary).wav")
var combat_music_8 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Adrenaline Blasts 3 (smooth).wav")
var combat_music_9 = preload("res://audio/music/16-Bit Fantasy Music Pack/Loops/Adrenaline Blasts 3 (tough).wav")

func _play_music(music: AudioStreamWAV):
	if stream == music:
		return
	stream = music
	play()

func play_music_menu():
	_play_music(menu_music)

func play_music_village():
	var random_music
	var random = randi_range(1,3)
	if random == 1:
		random_music = village_music_1
	elif random == 2:
		random_music = village_music_2
	elif random == 3:
		random_music = village_music_3
	_play_music(random_music)

func play_music_tavern():
	_play_music(tavern_music)

func play_music_selection():
	_play_music(selection_music)

func play_music_shop():
	_play_music(shop_music)

func play_music_rest():
	_play_music(rest_music)

func play_music_random_event():
	var random_music
	var random = randi_range(1,2)
	if random == 1:
		random_music = random_event_music_1
	elif random == 2:
		random_music = random_event_music_2
	_play_music(random_music)

func play_music_treasure():
	_play_music(treasure_music)

func play_music_combat():
	var random_music
	var random = randi_range(1,9)
	if random == 1:
		random_music = combat_music_1
	elif random == 2:
		random_music = combat_music_2
	elif random == 3:
		random_music = combat_music_3
	elif random == 4:
		random_music = combat_music_4
	elif random == 5:
		random_music = combat_music_5
	elif random == 6:
		random_music = combat_music_6
	elif random == 7:
		random_music = combat_music_7
	elif random == 8:
		random_music = combat_music_8
	elif random == 9:
		random_music = combat_music_9
	_play_music(random_music)
