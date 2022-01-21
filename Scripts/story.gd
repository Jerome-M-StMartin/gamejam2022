extends Node

var game_running = preload("res://Scenes/GameRunning.tscn")

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
		b.connect("pressed", self, "on_finished_reading")
		b.visible = true
		
		#start tween to fade sprite background to black, for readability
		$Sprite.visible = true
		var t = $Tween
		$Sprite.set_modulate(Color(1,1,1))
		t.interpolate_property($Sprite, "modulate", null, Color(0.2,0.2,0.2), 5.0)
		t.connect("tween_completed", self, "show_text")
		t.start()

#call when message text is closed via button
func on_finished_reading():
	var label = $RichTextLabel
	label.clear()
	label.visible = false
	$Button.visible = false
	$Sprite.visible = false
	
	if msg_idx < messages.size():
		var n_nodes = get_parent().get_child_count()
		get_parent().get_child(n_nodes - 1).queue_free()
		get_parent().add_child(game_running.instance(), true)
		
	else:
		.get_parent().get_node("Soundtrack").queue_free()
		var end_scene = load("res://Scenes/GameEndScene.tscn")
		var n_nodes = get_parent().get_child_count()
		get_parent().get_child(n_nodes - 1).queue_free()
		get_parent().add_child(end_scene.instance())

func _input(_event):
	if Input.is_action_just_pressed("ui_down"):
		next_message()
