extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var amplitude = Vector2(0, 300)

func _ready():
	_start_tween(null, self.position + amplitude)


func _start_tween(start, end):
	$Wave.interpolate_property(self, "position", start, end, Tween.TRANS_SINE, 1)
	$Wave.start()

func _on_Tween_wave_completed(object, key):
	amplitude[1] *= -1
	_start_tween(null, self.position + amplitude)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if !tween.is_active():
	pass	

func _input(event):
	if Input.is_action_pressed("ui_left"):
		self.position[0] -= 100
		
	if Input.is_action_pressed("ui_right"):
		self.position[0] += 100
		
	if Input.is_action_pressed("ui_up"):
		self.position[1] -= 100
		
	if Input.is_action_pressed("ui_down"):
		self.position[0] += 100


