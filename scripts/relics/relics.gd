extends Resource
class_name Relic


@export var relic_name: String
@export var relic_texture: Texture
@export var description: String
@export var resource_naming: String

func initialize_relic(_owner: RelicUI):
	pass
	
func activate_relic(_owner: RelicUI):
	pass
	
func get_description():
	return description
