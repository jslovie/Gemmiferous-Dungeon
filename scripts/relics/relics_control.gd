extends Control

@onready var relics = %Relics

func _ready():
	for relic_ui: RelicUI in relics.get_children():
		relic_ui.free()
