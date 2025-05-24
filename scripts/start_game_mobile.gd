extends CanvasLayer

const SAVE_PATH = "user://"
var is_demo = false


func _ready():
	visible = false
	if LevelManager.is_mobile:
		visible = true
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
		$Buttons/Continue.modulate = Color(1, 1, 1, 1)
		$Buttons/Continue.disabled = false
	else:
		$Buttons/Continue.modulate = Color(1, 1, 1, 0.50)
		$Buttons/Continue.disabled = true

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
	SaveManager.save_file_2 = true
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
	SaveManager.save_file_2 = true
	SaveManager.savefilesave()
	visible = false
	Loading.loading_1s()
	get_tree().change_scene_to_file("res://scenes/village.tscn")
	
func handle_continue_game():
	visible = false
	Loading.loading_1s()
	SaveManager.load_savefile()
	if SaveManager.save_file_2 == false:
		SaveManager.save_file_2 = true
		SaveManager.savefilesave()
	else:
		SaveManager.load_savefile_2()
	await get_tree().create_timer(0.5).timeout
	SaveManager.load_savefile()
	SaveManager.load_savefile_2()
	VillageManager.start_timers()

	get_tree().change_scene_to_file("res://scenes/village.tscn")

func enter_credits():
	if is_demo:
		$DemoMessage.visible = false
		$DemoVersion.visible = false
	$Buttons.visible = false
	$Credits.visible = true
	
func exit_credits():
	if is_demo:
		$DemoMessage.visible = true
		$DemoVersion.visible = true
	$Buttons.visible = true
	$Credits.visible = false


func remove_savefile():
	SaveManager.save_file = false
	SaveManager.save_file_2 = false
	SaveManager.remove_savefile()
	SaveManager.reset_savefile()
	VillageManager.reset_village_stats()
	PlayerManager.player.reset_player_stats()
	
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
	if SaveManager.save_file:
		$Removesavefile.visible = true
	else:
		handle_new_game()
	


func _on_remove_pressed():
	SaveManager.save_file = false
	SaveManager.save_file_2 = false
	SaveManager.remove_savefile()
	SaveManager.reset_savefile()
	VillageManager.reset_village_stats()
	PlayerManager.player.reset_player_stats()


func _on_start_game_new_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
	if SaveManager.save_file:
		$Removesavefile.visible = true
	else:
		handle_new_game()

func _on_continue_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
	handle_continue_game()


func _on_options_new_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
	$Settings.visible = true
	$MarginContainer.visible = true
	if LevelManager.is_mobile == true:
		$Buttons.visible = false
	
	
func _on_credits_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
	enter_credits()



func _on_quit_game_new_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
	SaveManager.remove_autosave()
	if OS.has_feature("Demo"):
		var res: int = OS.shell_open("steam://advertise/3507510")
		if res != OK:
			OS.shell_open("https://store.steampowered.com/app/3507510/Gemmiferous/")
	get_tree().quit()


func _on_start_game_new_mouse_entered():
	$Buttons/StartGameNew/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_start_game_new_mouse_exited():
	$Buttons/StartGameNew/Label.add_theme_color_override("font_color", Color.WHITE)
func _on_continue_mouse_entered():
	if SaveManager.save_file:
		$Buttons/Continue/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_continue_mouse_exited():
	if SaveManager.save_file:
		$Buttons/Continue/Label.add_theme_color_override("font_color", Color.WHITE)
func _on_options_new_mouse_entered():
	$Buttons/OptionsNew/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_options_new_mouse_exited():
	$Buttons/OptionsNew/Label.add_theme_color_override("font_color", Color.WHITE)
func _on_credits_mouse_entered():
	$Buttons/Credits/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_credits_mouse_exited():
	$Buttons/Credits/Label.add_theme_color_override("font_color", Color.WHITE)
func _on_quit_game_new_mouse_entered():
	$Buttons/QuitGameNew/Label.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_quit_game_new_mouse_exited():
	$Buttons/QuitGameNew/Label.add_theme_color_override("font_color", Color.WHITE)
func _on_exit_credits_mouse_entered():
	$Credits/ExitCredits/ExitCreditsLabel.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_exit_credits_mouse_exited():
	$Credits/ExitCredits/ExitCreditsLabel.add_theme_color_override("font_color", Color.WHITE)

func _on_back_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
	$Settings.visible = false
	$MarginContainer.visible = false
	if LevelManager.is_mobile == true:
		$Buttons.visible = true


func _on_close_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
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


func _on_yes_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
	remove_savefile()
	handle_new_game()
	$Removesavefile.visible = false
func _on_yes_mouse_entered():
	$Removesavefile/Yes/YesLabel.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_yes_mouse_exited():
	$Removesavefile/Yes/YesLabel.add_theme_color_override("font_color", Color.WHITE)
func _on_no_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
	$Removesavefile.visible = false
func _on_no_mouse_entered():
	$Removesavefile/No/NoLabel.add_theme_color_override("font_color", Color.ORANGE_RED)
func _on_no_mouse_exited():
	$Removesavefile/No/NoLabel.add_theme_color_override("font_color", Color.WHITE)


func _on_exit_credits_pressed():
	Sfx.play_SFX(Sfx.menu_confirm)
	exit_credits()
