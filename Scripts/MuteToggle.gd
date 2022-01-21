extends Node2D


func _on_MuteButton_pressed():
	var music = .get_parent().get_child(0)
	music.playing = !music.playing


func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))
	print(value)
