extends Control


func _ready():
	$MarginContainer/VBoxContainer/MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	$MarginContainer/VBoxContainer/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$MarginContainer/VBoxContainer/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	
	$MarginContainer/VBoxContainer/CRTSlider.value = Crt.get_CRT_parameter()
	
func _process(delta):
	$MarginContainer/VBoxContainer/MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	$MarginContainer/VBoxContainer/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$MarginContainer/VBoxContainer/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))

func apply_audio_settings(master, music, sfx):
	AudioServer.set_bus_volume_db(0, linear_to_db(master))
	AudioServer.set_bus_volume_db(1, linear_to_db(music))
	AudioServer.set_bus_volume_db(2, linear_to_db(sfx))
	AudioServer.set_bus_volume_db(3, linear_to_db(sfx))


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
	
func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	
func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	AudioServer.set_bus_volume_db(3, linear_to_db(value))



func _on_master_slider_mouse_entered():
	%SFXAudio.play()


func _on_sfx_slider_mouse_entered():
	%SFXAudio.play()


func _on_crt_slider_value_changed(value):
	Crt.change_CRT_parameter(value)
