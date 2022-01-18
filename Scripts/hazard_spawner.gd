extends Node

var stormcloud = preload("res://Scenes/Lightning.tscn")
var cloud = preload("res://Scenes/Cloud.tscn")
var whirlwind = preload("res://Scenes/Whirlwind.tscn")

var spawn_interval: float = 2.0

onready var hazard: Node = cloud.instance()

func _ready():
	$Timer.start(spawn_interval)

func _on_Timer_timeout():
	var random = randi() % 3
	match random:
		0:
			hazard = stormcloud.instance()
		1:
			hazard = cloud.instance()
		2:
			hazard = whirlwind.instance()
	
	hazard.start_y = randi() % 300
	.add_child(hazard)
	
	spawn_interval = rand_range(1.0, 3.0)
	$Timer.start(spawn_interval)
