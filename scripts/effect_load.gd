extends Node2D


func material_effect(effect, pos):
	var current = effect.instantiate()
	current.position = pos
	add_child(current)
