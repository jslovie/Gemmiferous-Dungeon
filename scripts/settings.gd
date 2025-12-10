extends Control

var resolution: int = 2
var windows_mode: int = 0
var crt_on: bool = false
var	master = db_to_linear(AudioServer.get_bus_volume_db(0))
var	music = db_to_linear(AudioServer.get_bus_volume_db(1))
var	sfx = db_to_linear(AudioServer.get_bus_volume_db(2))

func _ready():
	load_settings()
	await get_tree().process_frame
	await get_tree().process_frame
	apply_settings()

func _process(_delta):
	check_CRT_button()
	check_mode()
	check_resolution()
	check_mobile_version()

func save_settings():
	var config := ConfigFile.new()
	master = db_to_linear(AudioServer.get_bus_volume_db(0))
	music = db_to_linear(AudioServer.get_bus_volume_db(1))
	sfx = db_to_linear(AudioServer.get_bus_volume_db(2))
	
	config.set_value("video", "resolution", resolution)
	config.set_value("video", "windows_mode", windows_mode)
	config.set_value("video", "crt_on", crt_on)
	config.set_value("audio", "master", master)
	config.set_value("audio", "music", music)
	config.set_value("audio", "sfx", sfx)
	config.save("user://settings.cfg")

func load_settings():
	var config := ConfigFile.new()
	if config.load("user://settings.cfg") != OK:
		return
	
	resolution = config.get_value("video", "resolution", resolution)
	windows_mode = config.get_value("video", "windows_mode", windows_mode)
	crt_on = config.get_value("video", "crt_on", crt_on)
	master = config.get_value("audio", "master", master)
	music = config.get_value("audio", "music", music)
	sfx = config.get_value("audio", "sfx", sfx)

func apply_settings():
	match windows_mode:
		0: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		2: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
	match resolution:
		0: DisplayServer.window_set_size(Vector2i(960,540))
		1: DisplayServer.window_set_size(Vector2i(1280,720))
		2: DisplayServer.window_set_size(Vector2i(1920,1080))
		3: DisplayServer.window_set_size(Vector2i(2560,1440))

	Crt.crt_on = crt_on
	$AudioOptions/MarginContainer/VBoxContainer/CheckBox.button_pressed = crt_on
	
	var audio = $AudioOptions
	audio.apply_audio_settings(master, music, sfx)

func _on_back_pressed():
	save_settings()
	visible = false
	LevelManager.in_pause = false

func check_mobile_version():
	if LevelManager.is_mobile:
		$AudioOptions/MarginContainer/VBoxContainer/Resolution.visible = false
		%ResOptionButton.visible = false
		$AudioOptions/MarginContainer/VBoxContainer/Mode.visible = false
		%ModeOptionButton.visible = false


func check_resolution():
	if resolution == 0:
		%ResOptionButton.selected = 0
	elif resolution == 1:
		%ResOptionButton.selected = 1
	elif resolution == 2:
		%ResOptionButton.selected = 2
	elif resolution == 3:
		%ResOptionButton.selected = 3

func check_mode():
	if windows_mode == 0:
		%ModeOptionButton.selected = 0
	elif windows_mode == 1:
		%ModeOptionButton.selected = 1
	elif windows_mode == 2:
		%ModeOptionButton.selected = 2

func check_CRT_button():
	if Crt.crt_on == true:
		$AudioOptions/MarginContainer/VBoxContainer/CheckBox.button_pressed = true
	else:
		$AudioOptions/MarginContainer/VBoxContainer/CheckBox.button_pressed = false



func _on_check_box_toggled(_toggled_on):
	Sfx.play_SFX(Sfx.button_confirm)
	if $AudioOptions/MarginContainer/VBoxContainer/CheckBox.button_pressed == true:
		Crt.crt_on = true
		crt_on = true
	elif $AudioOptions/MarginContainer/VBoxContainer/CheckBox.button_pressed == false:
		Crt.crt_on = false
		crt_on = false
	save_settings()


func _on_res_option_button_item_selected(index):
	match index:
		0:
			get_window().set_size(Vector2(960,540))
			resolution = 0
		1:
			get_window().set_size(Vector2(1280,720))
			resolution = 1
		2:
			get_window().set_size(Vector2(1920,1080))
			resolution = 2
		3:
			get_window().set_size(Vector2(2560,1440))
			resolution = 3
	apply_settings()
	save_settings()



func _on_mode_option_button_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			windows_mode = 0
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			windows_mode = 1
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			windows_mode = 2
	apply_settings()
	save_settings()
