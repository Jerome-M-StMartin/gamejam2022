extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _on_message_body_entered(body):
	if body.name == "Player":
		get_tree().queue_delete(self)
