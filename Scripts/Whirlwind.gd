extends Node2D

var start_y: int = 0

func _ready():
	self.position.x = get_viewport().size.x + 50
	.connect("drop_bottle", get_tree().get_root().get_node("Pidgeon"), "on_drop_bottle")

func _process(delta):
	self.position.x -= 16 * delta
	if self.position.x < -20:
		self.queue_free()
	
func _on_body_entered(body):
	if body.name == "Pidegon":
		emit_signal("drop_bottle", body)
