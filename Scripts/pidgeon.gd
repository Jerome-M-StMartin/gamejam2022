extends RigidBody2D

export var G = Vector2(0, 9.8)
export var FLAP_VEC = Vector2(0, -300)
export var MAX_VEL = 500

enum SpriteMode { UNLADEN, LADEN }
export(SpriteMode) var sprite_mode = SpriteMode.UNLADEN

var flap: bool = false
var move: Vector2 = Vector2(0,0)

func _input(event):
	if Input.is_action_just_pressed("ui_up"):
		flap = true
		return
	
	if Input.is_action_just_pressed("ui_left"):
		move = Vector2(-100, 0)
	
	if Input.is_action_just_pressed("ui_right"):
		move = Vector2(100, 0)

func _physics_process(delta):
	if flap:
		.apply_central_impulse(FLAP_VEC)
		flap = false
		return
	
	.apply_central_impulse(move)
	.apply_central_impulse(G)
	move = Vector2(0,0)

func _integrate_forces(state):
	state.linear_velocity = Vector2(
								clamp(self.linear_velocity[0], -MAX_VEL, MAX_VEL),
								clamp(self.linear_velocity[1], -MAX_VEL, MAX_VEL)
							)
