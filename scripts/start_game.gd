extends CanvasLayer

const SAVE_PATH = "user://"
var is_demo = false


func _ready():
	demo_setup()
	Music.play_music_menu()
	$Settings.visible = false
	$GameTitle.add_theme_color_override("font_color", Color.DARK_ORANGE)
	if FileAccess.file_exists(SAVE_PATH + "savefile.sav"):
		SaveManager.load_savefile()
	else:
		print("No")

func _process(_delta):
	if SaveManager.save_file == true:
		$StartGame.text = "Continue"
		$Buttons/StartGameNew/Label.text = "Continue"
	else:
		$StartGame.text = "New Game"
		$Buttons/StartGameNew/Label.text = "New Game"

func demo_setup():
	if OS.has_feature("Demo"):
		$DemoMessage.visible = true
		$Testing.visible = false
		$Remove.visible = false
		$AnimationPlayer.play("Demo")
		is_demo = true
		#$DemoVersion.add_theme_color_override("font_color", Color.ORANGE_RED)
		$DemoVersion.visible = true

func create_test_game():
	SaveManager.save_file = true
	SaveManager.remove_savefile()
	SaveManager.reset_savefile()
	VillageManager.reset_village_stats()
	PlayerManager.player.total_red_gem = 1000
	PlayerManager.player.total_green_gem = 1000
	PlayerManager.player.total_blue_gem = 1000
	PlayerManager.player.total_yellow_gem = 1000
	PlayerManager.player.total_coins = 1000
	PlayerManager.player.total_wood = 1000
	PlayerManager.player.total_stone = 1000
	PlayerManager.player.total_iron = 1000
	SaveManager.savefilesave()
	
func handle_new_game():
	SaveManager.save_file = true
	SaveManager.savefilesave()
	visible = false
	Loading.loading_1s()
	get_tree().change_scene_to_file("res://scenes/village.tscn")
	
func handle_continue_game():
	SaveManager.load_savefile()
	VillageManager.start_timers()
	visible = false
	Loading.loading_1s()
	get_tree().change_scene_to_file("res://scenes/village.tscn")

func _on_button_pressed():
	visible = false
	Loading.loading_1s()
	create_test_game()
	get_tree().change_scene_to_file("res://scenes/village.tscn")




func _on_quit_game_pressed():
	SaveManager.remove_autosave()
	get_tree().quit()


func _on_start_game_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
	if SaveManager.save_file == false:
		handle_new_game()
	else:
		handle_continue_game()
	


func _on_remove_pressed():
	SaveManager.save_file = false
	SaveManager.remove_savefile()
	SaveManager.reset_savefile()
	VillageManager.reset_village_stats()
	PlayerManager.player.reset_player_stats()


func _on_start_game_new_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
	if SaveManager.save_file == false:
		handle_new_game()
	else:
		handle_continue_game()


func _on_options_new_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
	$Settings.visible = true
	$MarginContainer.visible = true


func _on_quit_game_new_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
	SaveManager.remove_autosave()
	get_tree().quit()


func _on_start_game_new_mouse_entered():
	$Buttons/StartGameNew/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_start_game_new_mouse_exited():
	$Buttons/StartGameNew/Label.add_theme_color_override("font_color", Color.WHITE)
func _on_options_new_mouse_entered():
	$Buttons/OptionsNew/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_options_new_mouse_exited():
	$Buttons/OptionsNew/Label.add_theme_color_override("font_color", Color.WHITE)
func _on_quit_game_new_mouse_entered():
	$Buttons/QuitGameNew/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_quit_game_new_mouse_exited():
	$Buttons/QuitGameNew/Label.add_theme_color_override("font_color", Color.WHITE)


func _on_back_pressed():
	$Settings.visible = false
	$MarginContainer.visible = false


func _on_close_pressed():
	$DemoMessage.visible = false

func _on_close_mouse_entered():
	$DemoMessage/Close.modulate = Color.ORANGE_RED

func _on_close_mouse_exited():
	$DemoMessage/Close.modulate = Color.WHITE


func _on_wishlist_pressed():
	var res: int = OS.shell_open("steam://advertise/3507510")
	if res != OK:
		OS.shell_open("https://store.steampowered.com/app/3507510/Gemmiferous/")
	
func _on_wishlist_mouse_entered():
	$DemoMessage/Wishlist/Label.add_theme_color_override("font_color", Color.ORANGE_RED)

func _on_wishlist_mouse_exited():
	$DemoMessage/Wishlist/Label.add_theme_color_override("font_color", Color.WHITE)
