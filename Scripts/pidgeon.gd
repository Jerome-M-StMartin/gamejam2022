extends RigidBody2D

onready var amplitude = Vector2(0, -15)
var tween_start_pos;

export var G = Vector2(0, 9.8)
export var FLAP_VEC = Vector2(0, -300)
export var MAX_VEL = 500

var flap: bool = false
var move: Vector2 = Vector2(0,0)

func _ready():
	gravity_scale = 0

func _input(event):
	if Input.is_action_just_pressed("ui_up"):
		flap = true
	
	if Input.is_action_just_pressed("ui_left"):
		move = Vector2(-100, 0)
	
	if Input.is_action_just_pressed("ui_right"):
		move = Vector2(100, 0)

func _physics_process(delta):
	if flap:
		mode = MODE_RIGID
		$Wave.stop_all()
		linear_damp = -1
		.apply_central_impulse(FLAP_VEC)
		flap = false
		return
	
	if position.x < 0:
		.apply_central_impulse(Vector2(10, 0))
	elif position.x > get_viewport().size.x:
		.apply_central_impulse(Vector2(-10, 0))
	else:
		.apply_central_impulse(move)
		.apply_central_impulse(G)
	
	move = Vector2(0,0)

func _integrate_forces(state):
	state.linear_velocity = Vector2(
								clamp(self.linear_velocity[0], -MAX_VEL, MAX_VEL),
								clamp(self.linear_velocity[1], -MAX_VEL, MAX_VEL)
							)
	if position.y >= get_viewport().size.y - 15: #Keep us above the water
		if !mode == MODE_KINEMATIC:
			mode = MODE_KINEMATIC
			linear_damp = 100
			tween_start_pos = self.position
			_start_tween(tween_start_pos, tween_start_pos + amplitude)

func _on_Bottle_pickup():
	$Sprite.visible = !$Sprite.visible
	$Sprite2.visible = !$Sprite2.visible

func _start_tween(start, end):
	$Wave.interpolate_property(self, "position", start, end, Tween.TRANS_SINE, 1)
	$Wave.start()

func _on_Wave_tween_completed(object, key):
	amplitude[1] *= -1
	_start_tween(null, self.position + amplitude)
