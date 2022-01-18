extends Node2D

var BASELINE = 500
var ROOT: Node

func _ready():
	ROOT = get_parent()

func _process(delta):
	var pidgeon_vel = ROOT.get_node("Pidgeon").linear_velocity #pidgeon y-speed
	var x_vel = pidgeon_vel[0]
	var y_vel = clamp(pidgeon_vel[1], -BASELINE, BASELINE)
	
	var y_ratio = clamp(y_vel / BASELINE, 0.5, 2)
	var x = 1
	if x_vel < 0:
		x = -1
	
	$Sprite.scale = Vector2(x * y_ratio, y_ratio)
	$Sprite.rotation_degrees = (Vector2(x_vel, y_vel).angle() * 57.29) + 180
