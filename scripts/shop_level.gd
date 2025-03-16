extends Node2D


func _ready():
	Music.play_music_shop()
	PlayerManager.player.update_player_texture()
