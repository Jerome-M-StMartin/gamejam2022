extends RigidBody2D

onready var amplitude = Vector2(0, -15)
var tween_start_pos;

export var G = Vector2(0, 9.8)
export var FLAP_VEC = Vector2(0, -300)
export var MAX_VEL = 500

var flap: bool = true
var move: Vector2 = Vector2(0,0)
var bobbing = false

var have_bottle = false
var bottle;

signal bottle_dropped(new_pos)

func _ready():
	gravity_scale = 0
	mode = MODE_CHARACTER
	.connect("bottle_dropped", get_parent(), "on_bottle_dropped")

func _input(_event):
	if Input.is_action_just_pressed("ui_up"):
		flap = true
	
	if Input.is_action_just_pressed("ui_left"):
		move = Vector2(-100, 0)
	
	if Input.is_action_just_pressed("ui_right"):
		move = Vector2(100, 0)

#func _process(_delta):
#	if have_bottle:
#		bottle.position = self.position + Vector2(0, 15)

func _physics_process(_delta):
	if flap:
		if bobbing:
			bobbing = false
			var tween = $AnimatedSprite.get_child(0)
			if is_instance_valid(tween):
				tween.queue_free()
			linear_damp = -1
			$AnimatedSprite.position = Vector2(0,0)
			
			if have_bottle:
				get_parent().get_node("MailboxTimer").set_paused(false)
			
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
	if position.y >= get_viewport().size.y - 35: #Keep us above the water
		if !bobbing:
			bobbing = true
			linear_damp = 100
			var tween = Tween.new()
			$AnimatedSprite.add_child(tween)
			tween.connect("tween_completed", self, "_on_Wave_tween_completed")
			tween_start_pos = $AnimatedSprite.position
			_start_tween(null, tween_start_pos + amplitude)
			
			if have_bottle:
				.get_parent().get_node("MailboxTimer").set_paused(true)

func on_bottle_pickup():
	bottle = .get_parent().get_node("Bottle")
	have_bottle = true
	$BottleSprite.visible = true
	.get_parent().get_node("MailboxTimer").set_paused(false)
	
func on_drop_bottle():
	if have_bottle:
		emit_signal("bottle_dropped", position + Vector2(0, 15))
	$BottleSprite.visible = false
	have_bottle = false
	bottle = null

func _start_tween(start, end):
	var tween = $AnimatedSprite.get_child(0)
	tween.interpolate_property($AnimatedSprite, "position", start, end, Tween.TRANS_SINE, 1)
	tween.start()

func _on_Wave_tween_completed(_object, _key):
	amplitude[1] *= -1
	_start_tween(null, tween_start_pos + amplitude)
