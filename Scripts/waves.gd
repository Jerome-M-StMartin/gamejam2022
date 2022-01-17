extends Sprite

export var scroll_speed = 32
onready var WINDOW_SIZE: Vector2 = get_viewport().size

func _ready():
	self.position = WINDOW_SIZE / 2

func _process(delta):
	WINDOW_SIZE = get_viewport().size
	self.position.x -= scroll_speed * delta
	self.position.y = WINDOW_SIZE.y / 2
	self.scale.x = WINDOW_SIZE.x / texture.get_size().x
	self.scale.y = WINDOW_SIZE.y / texture.get_size().y
	
	if self.position.x <= -WINDOW_SIZE.x / 2:
		self.position = WINDOW_SIZE / 2
