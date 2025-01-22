extends Control


func _process(delta):
	%WaitTimeLabel.text = str(%WaitTimeTimer.time_left)
