extends Sprite

export var scroll_speed = 8

onready var WINDOW_SIZE: Vector2 = get_viewport().size

func _ready():
	self.position = WINDOW_SIZE / 2


func _process(delta):
	WINDOW_SIZE = get_viewport().size
	self.position.x -= scroll_speed * delta
	self.position.y = WINDOW_SIZE.y / 2
	self.scale = WINDOW_SIZE / $Sprite.texture.get_size()
	
	if self.position.x <= -WINDOW_SIZE.x / 2:
		self.position = WINDOW_SIZE / 2
