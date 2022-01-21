extends Node2D


onready var t = get_child(1)
var card_scene = preload("res://Scenes/Cards.tscn")
var start_scene = preload("res://Scenes/GameRunning.tscn")

func _ready():
	#check if moving to next level or if game was just launched
	var check = get_parent().get_node("Story").msg_idx
	if check > 0:
		start_scene = load("res//Scenes/GameRunning.tscn")
	
	t.start(3)

func _process(_delta):
	var window_size = get_viewport().get_size()
	var texture_size = $StudioSplash.texture.get_size()
	var img = $StudioSplash
	img.scale.x = window_size.x / texture_size.x
	img.scale.y = window_size.y / texture_size.y
	img.position.x = window_size.x / 2
	img.position.y = window_size.y / 2

func _on_Transition_timeout():
	queue_free()
	get_parent().add_child(card_scene.instance())
