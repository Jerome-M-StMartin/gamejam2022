extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var t = get_child(1)
var game_running = preload("res://Scenes/GameRunning.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NextButton_pressed():
	queue_free()
	get_parent().add_child(game_running.instance())
