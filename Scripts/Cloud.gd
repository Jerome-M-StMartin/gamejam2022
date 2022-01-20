extends Node2D

func _ready():
	self.position.x = get_viewport().size.x + 120
	self.position.y = 100 + randi() % 100

func _process(delta):
	self.position.x -= 32 * delta
	if self.position.x < -20:
		self.queue_free()
