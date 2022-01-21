extends Node2D

func _process(_delta):
	var window_size = get_viewport().size()
	var texture_size = $EndScreen.get_size()
	$EndScreen.scale.x = window_size.x / texture_size.x

func end_game():
	get_tree().quit()


func quit_game():
	pass # Replace with function body.
