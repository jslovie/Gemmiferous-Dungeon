extends Control

func _ready():
	get_viewport().size = DisplayServer.screen_get_size()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_back_pressed():
	visible = false


func _on_check_box_toggled(toggled_on):
	if $AudioOptions/MarginContainer/VBoxContainer/CheckBox.button_pressed == true:
		Crt.crt_on = true
	elif $AudioOptions/MarginContainer/VBoxContainer/CheckBox.button_pressed == false:
		Crt.crt_on = false


func _on_res_option_button_item_selected(index):
	match index:
		0:
			get_window().set_size(Vector2(960,540))
		1:
			get_window().set_size(Vector2(1280,720))
		2:
			get_window().set_size(Vector2(1920,1080))
		3:
			get_window().set_size(Vector2(2500,1440))



func _on_mode_option_button_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
