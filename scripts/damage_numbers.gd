extends Node

func display_number(value, position: Vector2, is_top: bool = false, is_critical: bool = false, is_poison: bool = false, is_bleed: bool = false, is_ice: bool = false, is_fire: bool = false, is_electric: bool = false):
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()

	# Set color based on type
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
	number.pivot_offset = number.size / 2

	var arc_height = randi_range(120, 200)
	var arc_x_offset = randi_range(-64, 64)
	var rotation_angle = deg_to_rad(randi_range(-15, 15))

	var start_pos = number.position
	var peak_pos = start_pos + Vector2(arc_x_offset / 2.0, -arc_height)
	var end_pos = start_pos + Vector2(arc_x_offset, -arc_height / 2.0)

	var tween = get_tree().create_tween()
	tween.set_parallel(true)

	tween.tween_property(number, "position", peak_pos, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(number, "rotation", rotation_angle, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(number, "position", end_pos, 0.4).set_delay(0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(number, "rotation", 0, 0.4).set_delay(0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

	tween.tween_property(number, "modulate:a", 0, 0.5).set_delay(0.8)
	tween.tween_property(number, "scale", Vector2.ZERO, 0.5).set_delay(0.8)

	await tween.finished
	number.queue_free()
