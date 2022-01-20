extends Node

var stormcloud = preload("res://Scenes/Lightning.tscn")
var cloud = preload("res://Scenes/Cloud.tscn")
var whirlwind = preload("res://Scenes/Whirlwind.tscn")

var spawn_interval: float = 3.5

onready var hazard: Node = cloud.instance()

func _ready():
	$Timer.start(spawn_interval)

func _on_Timer_timeout():
	randomize()
	var random = randi() % 5
	match random:
		0:
			hazard = stormcloud.instance()
		1:
			hazard = cloud.instance()
		2:
			hazard = whirlwind.instance()
		3:
			hazard = whirlwind.instance()
		4:
			hazard = whirlwind.instance()
	
	.add_child(hazard)
	
	spawn_interval = rand_range(2.5, 6.0)
	$Timer.start(spawn_interval)
