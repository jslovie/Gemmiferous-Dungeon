extends AudioStreamPlayer

#Combat
var sword = preload("res://audio/SFX/SFX/Sword2.wav")
var bow = preload("res://audio/SFX/SFX/03_Bow_Release.wav")
var invisibility = preload("res://audio/SFX/SFX/03_Holy_Aura.wav")

var axe = preload("res://audio/SFX/SFX/Axe.wav")
var mace = preload("res://audio/SFX/SFX/Mace.wav")
var rage = preload("res://audio/SFX/SFX/10_Buff_02.wav")

var shield = preload("res://audio/SFX/SFX/Paladin_Damage.wav")
var material = preload("res://audio/SFX/SFX/05_Woodwork_Wood_Handling_3.wav")
var gem = preload("res://audio/SFX/SFX/Buff_Start.wav")

var ice = preload("res://audio/SFX/SFX/Ice.wav")
var electric = preload("res://audio/SFX/SFX/Electric.wav")

var relic = preload("res://audio/SFX/SFX/11_Buff_03.wav")

var damage = preload("res://audio/SFX/SFX/04_Fighter_Damage_2.wav")
var death = preload("res://audio/SFX/SFX/Barbarian_Death.wav")
var victory = preload("res://audio/SFX/SFX/Battle_Victory_Fanfare.wav")
#
var slot_win = preload("res://audio/SFX/SFX/mixkit-magical-coin-win-1936.wav")
var slot_spin = preload("res://audio/SFX/SFX/mixkit-arcade-slot-machine-wheel-1933.wav")
var key = preload("res://audio/SFX/SFX/double-door-lock-101210.mp3")
#Menu
var menu_confirm = preload("res://audio/SFX/Menu/MainMenu.wav")
var enter_dungeon = preload("res://audio/SFX/Menu/Dungeon.wav")
var level_selection = preload("res://audio/SFX/Menu/LevelSelection.wav")
var open_book = preload("res://audio/SFX/Menu/OpenBook.wav")
var confirm_book = preload("res://audio/SFX/Menu/BookConfirm.wav")
var door_open = preload("res://audio/SFX/Menu/DoorOpen.mp3")
var door_close = preload("res://audio/SFX/Menu/DoorClose.mp3")
var manor_open = preload("res://audio/SFX/Menu/ManorOpen.wav")
var manor_close = preload("res://audio/SFX/Menu/ManorClose.wav")
var upgrade = preload("res://audio/SFX/Menu/Upgrade.wav")
var upgrade_deny = preload("res://audio/SFX/Menu/UpgradeDeny.wav")
var buy = preload("res://audio/SFX/SFX/081_Buy_sell_03.wav")
var deny = preload("res://audio/SFX/SFX/033_Denied_03.wav")

func play_SFX(stream: AudioStream):
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = stream
	sfx_player.name = "SFX_PLAYER"
	add_child(sfx_player)
	sfx_player.play()
	
	await  sfx_player.finished
	
	sfx_player.queue_free()
