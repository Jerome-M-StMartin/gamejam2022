extends Node

onready var t = get_child(1)
var intro = preload("res://Scenes/Introduction.tscn")

func _on_Button_pressed():
	queue_free()
	get_parent().add_child(intro.instance())
