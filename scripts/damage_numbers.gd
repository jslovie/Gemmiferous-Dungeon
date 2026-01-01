extends Node


func display_number(value, position: Vector2, is_top: bool = false, is_critical: bool = false, is_poison: bool = false, is_bleed: bool = false, is_ice: bool = false, is_fire: bool = false, is_electric: bool = false):
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var color = Color.WHITE
	if is_top:
		color = Color.RED
	if is_critical:
		color = Color.WEB_PURPLE
	if is_poison:
		color = Color.GREEN
	if is_bleed:
		color = Color.FIREBRICK
	if is_ice:
		color = Color.SKY_BLUE
	if is_fire:
		color = Color.ORANGE_RED
	if is_electric:
		color = Color.YELLOW

	
	number.label_settings.font_color = color
	number.label_settings.font_size = 96
	number.label_settings.font = load("res://assets/alagard.ttf")
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	var random_x = randi_range(-32, 32)
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(number, "position:y", number.position.y - 100, 0.25).set_ease(Tween.EASE_OUT)
	tween.tween_property(number, "position:y", number.position.y, 0.5).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(number, "position:x", number.position.x + random_x, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(number, "scale", Vector2.ZERO, 0.25).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await tween.finished
	number.queue_free()
	
	
