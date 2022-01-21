extends Node2D

func _process(_delta):
	var window_size = get_viewport().get_size()
	var texture_size = $EndScreen.texture.get_size()
	var img = $EndScreen
	img.scale.x = window_size.x / texture_size.x
	img.scale.y = window_size.y / texture_size.y
	img.position.x = window_size.x / 2
	img.position.y = window_size.y / 2

func quit_game():
	get_tree().quit()
