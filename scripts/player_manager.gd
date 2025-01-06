extends Node

const PLAYER = preload("res://scenes/player.tscn")

var player : Player

var sword_damage = 3.0
var magic_damage = 3.0
var bow_damage = 3.0
var health = 50
var max_health = 50
var shield = 0
var shield_load = 0
var xp = 0
var coins = 0

var show_map = true

func update_stats():
	var p : Player = PlayerManager.player
	sword_damage = p.sword_damage
	magic_damage = p.magic_damage
	bow_damage = p.bow_damage
	health = p.health
	max_health = p.max_health
	shield = p.shield
	shield_load = p.shield_load
	xp = p.xp
	coins = p.coins

func set_player_stats(sword_damage, magic_damage, bow_damage, health, max_health, shield, shield_load, xp, coins, first_spawn):
	player.sword_damage = sword_damage
	player.magic_damage = magic_damage
	player.bow_damage = bow_damage
	player.health = health
	player.max_health = max_health
	player.shield = shield
	player.shield_load = shield_load
	player.xp = xp
	player.coins = coins
	player.first_spawn = first_spawn
