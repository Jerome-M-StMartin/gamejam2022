extends Node

export var difficulty = 0

var mailbox = preload("res://Scenes/Mailbox.tscn")
var mailbox_instanced = false
var mailbox_spawn_time = 10

var new_bottle = null
var new_pos: Vector2

func _ready():
	difficulty = get_parent().get_node("Story").msg_idx
	mailbox_spawn_time += difficulty * 10
	var mailbox_timer = Timer.new()
	mailbox_timer.name = "MailboxTimer"
	mailbox_timer.wait_time = mailbox_spawn_time
	mailbox_timer.one_shot = true
	.add_child(mailbox_timer, true)
	$MailboxTimer.start()
	$MailboxTimer.set_paused(true)
	$MailboxTimer.connect("timeout", self, "on_timeout_spawn_mailbox")

func _process(delta):
	
	if new_bottle != null:
		.add_child(new_bottle.instance())
		.get_node("Bottle").position = new_pos
		new_bottle = null
	
	var time_display = $TimeToMailbox
	time_display.clear()
	time_display.add_text("Distance to Mailbox: " + str(floor($MailboxTimer.time_left)))
	
	scale_sky_sprite()
	move_mailbox_leftward(delta)

func on_bottle_dropped(pos):
	$MailboxTimer.set_paused(true)
	new_bottle = load("res://Scenes/Bottle.tscn")
	new_pos = pos

func on_timeout_spawn_mailbox():
	.add_child(mailbox.instance())
	$Mailbox.position.x = get_viewport().size.x + 100
	mailbox_instanced = true

func scale_sky_sprite():
	var sky = $Sky
	var window = get_viewport().size
	sky.scale.x = window.x / sky.texture.get_size().x
	sky.scale.y = window.y / sky.texture.get_size().y
	sky.position.x = window.x / 2
	sky.position.y = window.y / 2

func move_mailbox_leftward(delta):
	if mailbox_instanced:
		var pos = $Mailbox.position.x
		if pos > get_viewport().size.x - 100:
			$Mailbox.position.x -= 32 * delta
		else:
			$Mailbox.position.x = get_viewport().size.x - 100
