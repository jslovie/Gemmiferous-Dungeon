extends Control



func apply_audio_settings(master, music, sfx, crt_parameter):
	AudioServer.set_bus_volume_db(0, linear_to_db(master))
	AudioServer.set_bus_volume_db(1, linear_to_db(music))
	AudioServer.set_bus_volume_db(2, linear_to_db(sfx))
	AudioServer.set_bus_volume_db(3, linear_to_db(sfx))
	$MarginContainer/VBoxContainer/MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	$MarginContainer/VBoxContainer/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$MarginContainer/VBoxContainer/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	
	Crt.change_CRT_parameter(crt_parameter)
	$MarginContainer/VBoxContainer/CRTSlider.value = crt_parameter

func _on_master_slider_mouse_exited():
	release_focus()
	%SFXAudio.stop()


func _on_music_slider_mouse_exited():
	release_focus()


func _on_sfx_slider_mouse_exited():
	release_focus()
	%SFXAudio.stop()
	

func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
	$MarginContainer/VBoxContainer/MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	get_parent().save_settings()
	
func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	$MarginContainer/VBoxContainer/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	get_parent().save_settings()
	
func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	AudioServer.set_bus_volume_db(3, linear_to_db(value))
	$MarginContainer/VBoxContainer/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	get_parent().save_settings()


func _on_master_slider_mouse_entered():
	%SFXAudio.play()


func _on_sfx_slider_mouse_entered():
	%SFXAudio.play()


func _on_crt_slider_value_changed(value):
	Crt.change_CRT_parameter(value)
	get_parent().crt_parameter = value
	get_parent().save_settings()
