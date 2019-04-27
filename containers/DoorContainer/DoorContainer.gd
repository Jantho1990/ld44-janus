extends "res://containers/EntityContainer/EntityContainer.gd"

class_name DoorContainer

func _init().():
	container_type = "Door"
	container_callback = "on_Add_door"

func on_Add_door(data):
	if data.container_id == container_id:
		var entity = data.entity
		if data.instance == true:
			entity = entity.instance()
	
		add_child(entity)