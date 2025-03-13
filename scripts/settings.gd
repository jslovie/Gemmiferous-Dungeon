extends Control







func _on_confirm_pressed():
	AudioServer.set_bus_volume_db(0, linear_to_db($AudioOptions/MarginContainer/VBoxContainer/MasterSlider.value))
	AudioServer.set_bus_volume_db(1, linear_to_db($AudioOptions/MarginContainer/VBoxContainer/MusicSlider.value))
	AudioServer.set_bus_volume_db(2, linear_to_db($AudioOptions/MarginContainer/VBoxContainer/SFXSlider.value))


func _on_back_pressed():
	visible = false


func _on_check_box_toggled(toggled_on):
	if $AudioOptions/MarginContainer/VBoxContainer/CheckBox.button_pressed == true:
		Crt.crt_on = true
	elif $AudioOptions/MarginContainer/VBoxContainer/CheckBox.button_pressed == false:
		Crt.crt_on = false
