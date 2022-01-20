extends Node2D

signal drop_bottle

func _ready():
	self.position.x = get_viewport().size.x + 120
	self.position.y = randi() % 120
	.connect("drop_bottle", get_parent().get_parent().get_node("Pidgeon"), "on_drop_bottle")
	
func _process(delta):
	self.position.x -= 32 * delta
	if self.position.x < -20:
		self.queue_free()

func _on_body_entered(body):
	if body.name == "Pidgeon":
		emit_signal("drop_bottle")
