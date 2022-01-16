extends RigidBody2D

export var gravity = Vector2(0, 9.8)
export var flap_vec = Vector2(0, -20)

var flap: bool = false

func _input(event):
	if Input.is_action_pressed("ui_up"):
		flap = true

func _physics_process(delta):
	if flap:
		.add_central_force(flap_vec)
		return
	.add_central_force(gravity)
