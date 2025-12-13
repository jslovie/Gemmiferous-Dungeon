extends Node2D

var resolution: int = 2
var windows_mode: int = 0
var crt_on: bool = false
var master: float = 0.15
var music: float = 0.55
var sfx: float  = 0.8

func _ready():
	#print(str(resolution) + " Resolution before load")
	#load_settings()
	#print(str(resolution) + " Resolution after load")
	#await get_tree().process_frame
	#await get_tree().process_frame
	#apply_settings()
	#print(str(resolution) + " Resolution after apply")
	rendering_check()
	SaveManager.autosave()
	if LevelManager.is_mobile == true:
		#get_window().set_size(Vector2(288,512))
		get_viewport().size = DisplayServer.screen_get_size()


func rendering_check():
	var gpu := RenderingServer.get_video_adapter_name()
	var gpu_name := RenderingServer.get_video_adapter_name().to_lower()
	print("GPU detected: ", gpu)
	if gpu_name.find("amd") != -1:
		OS.alert("Your AMD GPU may have issues with the default renderer.\nIf you see a black screen, restart the game in Safe Mode (OpenGL).")

func load_settings():
	var config := ConfigFile.new()
	var err := config.load("user://settings.cfg")
	print("Config load result:", err)
	
	if err != OK:
		print("FAILED TO LOAD SETTINGS FILE")
		return
	
	print("Resolution key exists:",
		config.has_section_key("video", "resolution"))
	
	resolution = config.get_value("video", "resolution", resolution)
	windows_mode = config.get_value("video", "windows_mode", windows_mode)
	crt_on = config.get_value("video", "crt_on", crt_on)
	master = config.get_value("audio", "master", master)
	music = config.get_value("audio", "music", music)
	sfx = config.get_value("audio", "sfx", sfx)
	
func apply_settings() -> void:
	match windows_mode:
		0: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		2: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	match resolution:
		0: DisplayServer.window_set_size(Vector2i(960,540))
		1: DisplayServer.window_set_size(Vector2i(1280,720))
		2: DisplayServer.window_set_size(Vector2i(1920,1080))
		3: DisplayServer.window_set_size(Vector2i(2560,1440))
	
	Crt.crt_on = crt_on
	AudioServer.set_bus_volume_db(0, linear_to_db(master))
	AudioServer.set_bus_volume_db(1, linear_to_db(music))
	AudioServer.set_bus_volume_db(2, linear_to_db(sfx))
	AudioServer.set_bus_volume_db(3, linear_to_db(sfx))
		
#func set_resolution():
	#if str(DisplayServer.screen_get_size()) == "(960, 540)":
		#LevelManager.resolution = 0
	#elif str(DisplayServer.screen_get_size()) == "(1280, 720)":
		#LevelManager.resolution = 1
	#elif str(DisplayServer.screen_get_size()) == "(1920, 1080)":
		#LevelManager.resolution = 2
	#elif str(DisplayServer.screen_get_size()) == "(2500, 1440)":
		#LevelManager.resolution = 3
