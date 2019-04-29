extends MarginContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	random_background()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func random_background():
	var num = 3 # count of backgrounds minus 1
	var bkgd = math.rand(0, num)
	var i = 0
	for child in $BackgroundTiles.get_children():
		if i == bkgd:
			child.show()
		else:
			child.hide()
		i += 1

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