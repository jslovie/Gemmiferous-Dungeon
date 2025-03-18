extends HBoxContainer

class_name RelicHandler

signal relick_activated

const RELIC_UI = preload("res://scenes/relic/relic_ui.tscn")

@onready var relics_control = $RelicsControl
@onready var relics = %Relics

func add_relics(relics_array: Array[Relic]):
	for relic: Relic in relics_array:
		add_relic(relic)
		
func add_relic(relic: Relic):
	if has_relic(relic.relic_name):
		return
	
	var new_relic_ui := RELIC_UI.instantiate() as RelicUI
	relics.add_child(new_relic_ui)
	new_relic_ui.relic = relic
	new_relic_ui.relic.initialize_relic(new_relic_ui)
	
func has_relic(relic_name: String):
	for relic_ui: RelicUI in relics.get_children():
		if relic_ui.relic.relic_name == relic_name and is_instance_valid(relic_ui):
			print("has relic")
			return true
			
	print("No relic")
	return false
