extends Control

func _ready():
	pass

func _process(delta):
	check_CRT_button()
	check_mode()
	check_resolution()
	check_mobile_version()
	
func _on_back_pressed():
	visible = false

func check_mobile_version():
	if LevelManager.is_mobile:
		$AudioOptions/MarginContainer/VBoxContainer/Resolution.visible = false
		%ResOptionButton.visible = false
		$AudioOptions/MarginContainer/VBoxContainer/Mode.visible = false
		%ModeOptionButton.visible = false

func check_resolution():
	if LevelManager.resolution == 0:
		%ResOptionButton.selected = 0
	elif LevelManager.resolution == 1:
		%ResOptionButton.selected = 1
	elif LevelManager.resolution == 2:
		%ResOptionButton.selected = 2
	elif LevelManager.resolution == 3:
		%ResOptionButton.selected = 3

func check_mode():
	if LevelManager.windows_mode == 0:
		%ModeOptionButton.selected = 0
	elif LevelManager.windows_mode == 1:
		%ModeOptionButton.selected = 1
	elif LevelManager.windows_mode == 2:
		%ModeOptionButton.selected = 2

func check_CRT_button():
	if Crt.crt_on == true:
		$AudioOptions/MarginContainer/VBoxContainer/CheckBox.button_pressed = true
	else:
		$AudioOptions/MarginContainer/VBoxContainer/CheckBox.button_pressed = false

func _on_check_box_toggled(_toggled_on):
	if $AudioOptions/MarginContainer/VBoxContainer/CheckBox.button_pressed == true:
		Crt.crt_on = true
	elif $AudioOptions/MarginContainer/VBoxContainer/CheckBox.button_pressed == false:
		Crt.crt_on = false


func _on_res_option_button_item_selected(index):
	match index:
		0:
			get_window().set_size(Vector2(960,540))
			LevelManager.resolution = 0
		1:
			get_window().set_size(Vector2(1280,720))
			LevelManager.resolution = 1
		2:
			get_window().set_size(Vector2(1920,1080))
			LevelManager.resolution = 2
		3:
			get_window().set_size(Vector2(2500,1440))
			LevelManager.resolution = 3



func _on_mode_option_button_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			LevelManager.windows_mode = 0
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			LevelManager.windows_mode = 1
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			LevelManager.windows_mode = 2
