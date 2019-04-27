extends MarginContainer

func _on_Master_volume_changed(value):
	Sound.set_volume("Master", value)

func _on_Return_pressed():
	hide()


func _on_SFX_volume_changed(value):
	Sound.set_volume("SFX", value)


func _on_Dialogue_volume_changed(value):
	Sound.set_volume("Dialogue", value)


func _on_Music_volume_changed(value):
	Sound.set_volume("Music", value)
