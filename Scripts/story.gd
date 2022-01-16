extends Node

onready var file = "test.txt"
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
		
		curr_msg += line
	f.close()

func on_message_delivered():
	$RichTextLabel.add_text(messages[msg_idx])
	msg_idx += 1

#func _input(event):
#	if Input.is_action_just_pressed("ui_down"):
#		$RichTextLabel.add_text(messages[msg_idx])
#		msg_idx += 1
