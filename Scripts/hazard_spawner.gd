extends Node

var stormcloud = preload("res://Scenes/Lightning.tscn")
var cloud = preload("res://Scenes/Cloud.tscn")
var whirlwind = preload("res://Scenes/Whirlwind.tscn")

var spawn_interval: float = 3.5

onready var hazard: Node = cloud.instance()

func _ready():
	$Timer.start(spawn_interval)

func _on_Timer_timeout():
	var difficulty = .get_parent().difficulty
	select_hazard(difficulty)
	.add_child(hazard)
	spawn_interval = rand_range(2.5 - (difficulty / 4), 6.0 - (difficulty / 4))
	$Timer.start(spawn_interval)

func select_hazard(difficulty):
	randomize()
	match difficulty:
		0:
			var random = randi() % 4
			match random:
				1:
					hazard = cloud.instance()
				2:
					hazard = whirlwind.instance()
				3:
					hazard = whirlwind.instance()
				4:
					hazard = whirlwind.instance()
		1:
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
		2:
			var random = randi() % 6
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
				5:
					hazard = whirlwind.instance()
		3:
			var random = randi() % 6
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
				5:
					hazard = whirlwind.instance()
		4:
			var random = randi() % 6
			match random:
				0:
					hazard = stormcloud.instance()
				1:
					hazard = stormcloud.instance()
				2:
					hazard = whirlwind.instance()
				3:
					hazard = whirlwind.instance()
				4:
					hazard = whirlwind.instance()
				5:
					hazard = whirlwind.instance()
		5:
			var random = randi() % 6
			match random:
				0:
					hazard = stormcloud.instance()
				1:
					hazard = stormcloud.instance()
				2:
					hazard = whirlwind.instance()
				3:
					hazard = whirlwind.instance()
				4:
					hazard = whirlwind.instance()
				5:
					hazard = whirlwind.instance()
