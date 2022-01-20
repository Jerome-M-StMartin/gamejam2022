extends Node

var file = "res://Assets/story.txt"
var messages = PoolStringArray([])
var msg_idx = 0

func _ready():
	load_file(file)

func load_file(file):
	var f = File.new()
	f.open(file, File.READ)
	var curr_msg: String = ""
	
	while not f.eof_reached():
		var line = f.get_line()
		if line == "[new]": #if new message reached
			messages.append(curr_msg)
			curr_msg = "\n"
			continue
		
		curr_msg += line + "\n"
	f.close()

func next_message():
	if msg_idx < messages.size():
		var label = $RichTextLabel
		label.clear()
		label.add_text(messages[msg_idx])
		label.visible = true
		msg_idx += 1
		
		#spawn "close message" button
		var b = $Button
		b.set_text("Close Message")
		b.connect("pressed", self, "on_finished_reading")
		b.visible = true

#call when message text is closed via button
func on_finished_reading():
	var label = $RichTextLabel
	label.clear()
	label.visible = false
	$Button.visible = false

func _input(_event):
	if Input.is_action_just_pressed("ui_down"):
		next_message()
