extends Node2D

func _ready():
	var message: Node = Node.new()
	message.name = "Message"
	add_child(message, true)

func _process(delta):
	print($Message)

func on_message_delivered():
	pass

func on_pickup():
	pass
