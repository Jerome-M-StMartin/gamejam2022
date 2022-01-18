extends RigidBody2D

export var G = Vector2(0, 9.8)

var tween_start_pos
onready var amplitude = Vector2(0, -10)
var bobbing = false

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
		if !bobbing:
			bobbing = true
			linear_damp = 100
			var tween = Tween.new()
			$Sprite.add_child(tween)
			tween.connect("tween_completed", self, "_on_Wave_tween_completed")
			tween_start_pos = $Sprite.position
			_start_tween(null, tween_start_pos + amplitude)
	else:
		bobbing = false

func _physics_process(_delta):
	if !bobbing:
		.apply_central_impulse(G)

func on_message_delivered():
	pass

func _on_Bottle_dropped(new_pos):
	self.position = new_pos

func _on_Bottle_body_entered(body):
	if body.name == "Pidgeon":
		emit_signal("bottle_pickup")
		bobbing = false

func _start_tween(start, end):
	var tween = $Sprite.get_child(0)
	tween.interpolate_property($Sprite, "position", start, end, Tween.TRANS_SINE, 1)
	tween.start()
	
func _on_Wave_tween_completed(_object, _key):
	amplitude[1] *= -1
	_start_tween(null, tween_start_pos + amplitude)
