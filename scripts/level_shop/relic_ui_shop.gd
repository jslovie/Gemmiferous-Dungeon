extends TextureButton

@export var relic: Relic : set = set_relic

@onready var icon = $Icon
@onready var price_label = %PriceLabel
@onready var texture_rect = $TextureRect

func _ready():
	$NotEnough.visible = false

func set_relic(new_relic: Relic):
	if not is_node_ready():
		await ready
		
	relic = new_relic
	icon.texture = relic.relic_texture
	price_label.text = str(relic.price)
	texture_rect.modulate = relic.color

func check_enough_coins(coins):
	if PlayerManager.player.coins >= coins:
		return true
	else:
		return false

func process_cost(coins):
	PlayerManager.player.coins -= coins
	SaveManager.savefilesave()

func not_enough():
	$NotEnough.visible = true
	await get_tree().create_timer(1).timeout
	$NotEnough.visible = false
	
func purchase_relic():
	if relic.is_relic == true:
		if check_enough_coins(relic.price):
			process_cost(relic.price)
			get_parent().add_relic(relic)
			get_parent().spawn_effect(position)
			visible = false
		else:
			not_enough()
	else:
		if check_enough_coins(relic.price):
			process_cost(relic.price)
			get_parent().add_piece(relic.relic_name, relic)
			get_parent().spawn_effect_pieces(position, relic.color)
			visible = false
		else:
			not_enough()
func _on_pressed():
	purchase_relic()


func _on_mouse_entered():
	RelicManager.relic_name = relic.relic_name
	RelicManager.relic_description = relic.description


func _on_mouse_exited():
	RelicManager.relic_name = ""
	RelicManager.relic_description = ""
