extends Node

var relic_description = ""
var relic_name = ""

var current_relics = []
var current_pieces = []
var curret_pieces_for_check = []

#relics
var got_hit_health_potion = 0
var got_hit_armor = 0
var report = 0

#pieces
var bolt_staff = preload("res://scenes/pieces/bolt_staff_piece.tscn")
var crossbow = preload("res://scenes/pieces/crossbow_piece.tscn")
var flail = preload("res://scenes/pieces/flail_piece.tscn")
var ice_staff = preload("res://scenes/pieces/ice_staff_piece.tscn")
var maul = preload("res://scenes/pieces/maul_piece.tscn")
var sickle = preload("res://scenes/pieces/sickle_piece.tscn")

func reset_pieces_relics():
	current_relics.clear()
	current_pieces.clear()
	curret_pieces_for_check.clear()
