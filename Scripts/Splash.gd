extends Node2D


onready var t = get_child(1)
var start_scene = preload("res://Scenes/StartScreen.tscn")

func _ready():
	#check if moving to next level or if game was just launched
	var check = get_parent().get_node("Story").msg_idx
	if check > 0:
		start_scene = load("res//Scenes/GameRunning.tscn")
	
	t.start(3)

func _on_Transition_timeout():
	queue_free()
	get_parent().add_child(start_scene.instance())
