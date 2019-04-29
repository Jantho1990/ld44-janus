extends MarginContainer

onready var OptionsMenu = $OptionsMenu

func _input(event):
	if event.is_action_pressed("pause"):
		print("pause action")
		match get_tree().paused:
			false:
				on_pause_button_pressed()
			true:
				on_pause_popup_close_pressed()

func on_pause_button_pressed():
	get_tree().paused = true
	show()

func on_pause_popup_close_pressed():
	print("hit")
	hide()
	get_tree().paused = false

func _on_Resume_pressed():
	on_pause_popup_close_pressed()


func _on_Quit_pressed():
	get_tree().change_scene("res://screens/MainMenu.tscn")
	get_tree().paused = false


func _on_Options_pressed():
	OptionsMenu.show()
