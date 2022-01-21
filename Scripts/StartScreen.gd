extends Node

onready var t = get_child(1)
var intro = preload("res://Scenes/Introduction.tscn")

func _input(_event):
	var up = Input.is_action_just_pressed("ui_up")
	var left = Input.is_action_just_pressed("ui_left")
	var right = Input.is_action_just_pressed("ui_right")
	if up or left or right:
		_on_Button_pressed()

func _on_Button_pressed():
	queue_free()
	get_parent().add_child(intro.instance())
