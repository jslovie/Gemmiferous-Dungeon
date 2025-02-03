extends Control


func _process(_delta):
	%WaitTimeLabel.text = str(%WaitTimeTimer.time_left)
