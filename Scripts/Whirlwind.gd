extends Node2D

signal drop_bottle

var speed: int

func _ready():
	self.speed = 64 + randi() % 128
	self.position.y = randi() % 290
	self.position.x = get_viewport().size.x + 70
	.connect("drop_bottle", .get_parent().get_parent().get_node("Pidgeon"), "on_drop_bottle")

func _process(delta):
	self.position.x -= speed * delta
	if self.position.x < -20:
		self.queue_free()
	
func _on_body_entered(body):
	if body.name == "Pidgeon":
		emit_signal("drop_bottle")
