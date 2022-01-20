extends Node

onready var t = get_child(1)
var start_scene = preload("res://Scenes/Introduction.tscn")

func _on_Button_pressed():
	print("yep!")
	queue_free()
	get_parent().add_child(start_scene.instance())
