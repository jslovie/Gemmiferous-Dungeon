extends Control

var time_in_secs = 0

var total_time_in_secs : int = 0

func _ready():
	# start Timer at specific time:
	# (or use 'Autostart' property)
	#$Timer.start()
	pass

func timer_start():
	$Timer.start()

func _on_timer_timeout():
	total_time_in_secs += 1
	var m = int(total_time_in_secs / 60.0)
	var s = total_time_in_secs - m * 60
	$Label.text = '%02d:%02d' % [m, s]
