extends Control

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


func _unhandled_input(event): 
	if  event.is_action_pressed("Esc"):
		pause_menu()
	if  event.is_action_pressed("Pause"):
		pause()
	
func pause_menu():
	if get_parent().pause_game == true and $"../Pause".visible == false:
		$"../Pause".visible = true
		return
	elif get_parent().pause_game == true and $"../Pause".visible == true:
		$"../Pause".visible = false
		return
	elif get_tree().paused == true:
		$"../Pause".visible = false
		get_tree().paused = false
	else:
		$"../Pause".visible = true
		get_tree().paused = true

func pause():
	if $"../Pause".visible == true:
		return
	else:
		get_parent()._on_pause_game_pressed()
