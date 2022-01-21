extends Node2D

export var G = 98

var tween_start_pos
onready var amplitude = Vector2(0, -10)
var bobbing = false

signal bottle_pickup

func _ready():
	self.position.x = 750
	self.position.y = get_viewport().size.y - 100
	
	.connect("bottle_pickup", .get_parent().get_node("Pidgeon"), "on_bottle_pickup")
	$Area2D.connect("body_entered", self, "on_bottle_area_entered")
	
	var message: Node = Node.new()
	message.name = "Message"
	add_child(message, true)

func _physics_process(delta):
	#Drift leftward
	self.position.x -= 32 * delta
	
	#Prevent permanent movement off left of screen
	if self.position.x < -50:
		self.position.x = 950
	
	#Prevent sinking
	if position.y >= get_viewport().size.y - 50:
		if !bobbing:
			$Plop.play()
			G = 98
			bobbing = true
			$Sprite.add_child(Tween.new())
			$Sprite.get_child(0).connect("tween_completed", self, "on_tween_completed")
			tween_start_pos = $Sprite.position
			start_tween(null, tween_start_pos + amplitude)
	else:
		bobbing = false
		$Sprite.position = Vector2(0,0)
		self.position.y += G * delta
		G += 200 * delta
		self.rotate(0.1)

func on_bottle_area_entered(body):
	if bobbing and body.name == "Pidgeon":
		emit_signal("bottle_pickup")
		bobbing = false
		self.queue_free()

func start_tween(start, end):
	var tween = $Sprite.get_child(0)
	tween.interpolate_property($Sprite, "position", start, end, Tween.TRANS_SINE, 1)
	tween.start()
	
func on_tween_completed(_object, _key):
	amplitude[1] *= -1
	start_tween(null, tween_start_pos + amplitude)
