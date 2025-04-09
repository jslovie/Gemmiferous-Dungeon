extends Node

const RESOURCE_PATH = "user://resources/"

var relic_description = ""
var relic_name = ""

var current_relics = []
var current_pieces = []
var curret_pieces_for_check = []

#relics
var got_hit_health_potion = 0
var got_hit_armor = 0
var thorned_necklade = 0
var report = 0
var has_shuriken = false
var has_wealth_necklace = false
var has_gem_necklace = false

#pieces
var bolt_staff = preload("res://scenes/pieces/bolt_staff_piece.tscn")
var crossbow = preload("res://scenes/pieces/crossbow_piece.tscn")
var flail = preload("res://scenes/pieces/flail_piece.tscn")
var ice_staff = preload("res://scenes/pieces/ice_staff_piece.tscn")
var maul = preload("res://scenes/pieces/maul_piece.tscn")
var sickle = preload("res://scenes/pieces/sickle_piece.tscn")

func _process(delta):
	check_resource()

func check_resource():
	var dir = DirAccess.open("user://")
	var gem_necklace = "user://resources/GemNecklace.tres"
	if dir.file_exists(gem_necklace):
		RelicManager.has_gem_necklace = true
	
	
func reset_pieces_relics():
	current_relics.clear()
	current_pieces.clear()
	curret_pieces_for_check.clear()
	got_hit_health_potion = 0
	got_hit_armor = 0
	report = 0
	has_shuriken = false
	has_wealth_necklace = false
