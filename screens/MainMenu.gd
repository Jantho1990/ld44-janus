extends MarginContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_StartButton_pressed():
	# Make sure there aren't any lingering events in the EventBus.
	EventBus.clear()
	
	get_tree().change_scene("res://screens/Intro.tscn")


func _on_Music_finished():
	$Sounds/Music.play()


func _on_OptionsButton_pressed():
	$CenterContainer.hide()
	$OptionsMenu.show()

func _on_Options_exit():
	$CenterContainer.show()