extends AudioStreamPlayer

var menu_music = preload("res://audio/music/music/Dark Fog.wav")
var village_music_1 = preload("res://audio/music/music/The Wizard's Hut.wav")
var village_music_2 = preload("res://audio/music/music/Wintertime Venture.wav")
var village_music_3 = preload("res://audio/music/music/Hallowed Place.wav")
var tavern_music = preload("res://audio/music/music/A Hidden Tavern.wav")
var selection_music = preload("res://audio/music/music/Credits(loop).wav")
var shop_music = preload("res://audio/music/music/Talking to the Peasants (Part I).wav")
var rest_music = preload("res://audio/music/music/By the Meadow.wav")
var random_event_music = preload("res://audio/music/music/Talking to the Peasants (Part II).wav")
var treasure_music_intro = preload("res://audio/music/music/BossFight(intro-loop).wav")
var treasure_music = preload("res://audio/music/music/BossFight(loop)(110).wav")
var combat_music_1 = preload("res://audio/music/music/Level1(loop).wav")
var combat_music_2 = preload("res://audio/music/music/Level2(loop).wav")
var combat_music_3 = preload("res://audio/music/music/Level3(loop).wav")
var combat_music_4 = preload("res://audio/music/music/BulletWitch-Level1(loop)(125).wav")
var combat_music_5 = preload("res://audio/music/music/Level2(loop)(84).wav")
var combat_music_elite_1 = preload("res://audio/music/music/Hellmouth(loop)(100).wav")
var combat_music_elite_2 = preload("res://audio/music/music/TheFinalBase(intro-loop).wav")
var combat_music_elite_3 = preload("res://audio/music/music/BulletWitch-Level3(loop)(125).wav")
var combat_music_elite_4 = preload("res://audio/music/music/Level3(loop)(100).wav")
var boss_music = preload("res://audio/music/music/BossFight(loop).wav")
var game_over_music = preload("res://audio/music/music/GameOverCountdown(loop)(120).wav")



func dim_music():
	var current_db = AudioServer.get_bus_volume_db(1)
	var current_linear = db_to_linear(current_db)
	var new_linear = current_linear / 3
	var new_db = linear_to_db(new_linear)
	AudioServer.set_bus_volume_db(1, new_db)

func music_to_normal():
	var current_db = AudioServer.get_bus_volume_db(1)
	var current_linear = db_to_linear(current_db)
	var new_linear = current_linear * 3
	var new_db = linear_to_db(new_linear)
	AudioServer.set_bus_volume_db(1, new_db)


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
	_play_music(random_event_music)

func play_music_treasure():
	_play_music(treasure_music_intro)
	await get_tree().create_timer(3.01).timeout
	_play_music(treasure_music)

func play_music_combat():
	var random_music
	var random = randi_range(1,5)
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

	_play_music(random_music)

func play_music_combat_elite():
	var random_music
	var random = randi_range(1,4)
	if random == 1:
		random_music = combat_music_elite_1
	elif random == 2:
		random_music = combat_music_elite_2
	elif random == 3:
		random_music = combat_music_elite_3
	elif random == 4:
		random_music = combat_music_elite_4


	_play_music(random_music)

func play_music_boss():
	_play_music(boss_music)

func play_music_game_over():
	_play_music(game_over_music)
