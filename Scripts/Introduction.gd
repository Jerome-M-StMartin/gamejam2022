extends Node2D

var game_running = preload("res://Scenes/GameRunning.tscn")

func _input(_event):
	var up = Input.is_action_just_pressed("ui_up")
	var left = Input.is_action_just_pressed("ui_left")
	var right = Input.is_action_just_pressed("ui_right")
	if up or left or right:
		_on_NextButton_pressed()

func _on_NextButton_pressed():
	queue_free()
	get_parent().add_child(game_running.instance())
