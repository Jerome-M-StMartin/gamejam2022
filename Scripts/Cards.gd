extends Node2D


onready var t = get_child(2)
var start_scene = preload("res://Scenes/StartScreen.tscn")

func _ready():

	t.start(3)

func _on_Timer_timeout():
	queue_free()
	get_parent().add_child(start_scene.instance())

