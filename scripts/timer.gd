extends Control

var time_in_secs = 0

var total_time_in_secs : int = 0

func _ready():
	LevelManager.timer_stop = false
	# start Timer at specific time:
	# (or use 'Autostart' property)
	#$Timer.start()
	pass

func _process(delta):
	if LevelManager.timer_stop == true:
		timer_stop()

func timer_start():
	$Timer.start()

func timer_stop():
	$Timer.stop()

func _on_timer_timeout():
	total_time_in_secs += 1
	var m = int(total_time_in_secs / 60.0)
	var s = total_time_in_secs - m * 60
	$Label.text = '%02d:%02d' % [m, s]
