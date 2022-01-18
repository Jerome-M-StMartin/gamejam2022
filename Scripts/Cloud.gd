extends Node2D

var start_y: int = 0

func _ready():
	self.position.x = get_viewport().size.x + 50

func _process(delta):
	self.position.x -= 16 * delta
	if self.position.x < -20:
		self.queue_free()
