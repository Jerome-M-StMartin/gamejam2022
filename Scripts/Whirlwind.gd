extends Node2D

signal drop_bottle

var speed: int

export var volume = 11

func _ready():
	self.speed = 64 + randi() % 128
	self.position.y = randi() % 290
	self.position.x = get_viewport().size.x + 70
	.connect("drop_bottle", .get_parent().get_parent().get_node("Pidgeon"), "on_drop_bottle")
	
	#init audio effect
	var node = AudioStreamPlayer2D.new()
	var audio
	var x = randi() % 3
	match x:
		0:
			audio = load("res://Assets/Tornado_One.ogg")
		1:
			audio = load("res://Assets/Tornado_Two.ogg")
		2:
			audio = load("res://Assets/Tornado_Three.ogg")
	node.set_stream(audio)
	node.set_autoplay(true)
	node.set_volume_db(volume)
	.add_child(node)

func _process(delta):
	self.position.x -= speed * delta
	if self.position.x < -20:
		self.queue_free()
	
func _on_body_entered(body):
	if body.name == "Pidgeon":
		emit_signal("drop_bottle")
