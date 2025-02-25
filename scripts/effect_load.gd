extends Node2D


func material_effect(effect, position):
	var current = effect.instantiate()
	current.position = position
	add_child(current)
