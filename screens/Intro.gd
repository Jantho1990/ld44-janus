extends MarginContainer

func _input(event):
	if event.is_action_pressed("cast"):
		get_tree().change_scene("res://screens/Game.tscn")