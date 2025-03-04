extends CanvasLayer

func _ready():
	visible = false

func transition():
	visible = true
	$AnimationPlayer.play("Fade")
	await $AnimationPlayer.animation_finished
	visible = false
	
