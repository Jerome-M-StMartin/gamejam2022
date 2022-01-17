extends RigidBody2D

export var G = Vector2(0, 9.8)

signal bottle_pickup

func _ready():
	contact_monitor = true
	contacts_reported = 3
	gravity_scale = 0
	var message: Node = Node.new()
	message.name = "Message"
	add_child(message, true)

func _integrate_forces(_state):
	if position.y >= get_viewport().size.y - 50:
		linear_damp = 100

func _physics_process(_delta):
	.apply_central_impulse(G)

func on_message_delivered():
	pass

func _on_Bottle_body_entered(body):
	if body.name == "Pidgeon":
		emit_signal("bottle_pickup")
	self.queue_free()
