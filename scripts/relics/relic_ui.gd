extends Control
class_name RelicUI

@export var relic: Relic : set = set_relic

@onready var icon = $Icon
@onready var animation_player = $AnimationPlayer

func set_relic(new_relic: Relic):
	if not is_node_ready():
		await ready
		
	relic = new_relic
	icon.texture = relic.icon
