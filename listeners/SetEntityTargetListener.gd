extends Node2D

export(String) var entity_type
export(String) var event_name
export(String) var event_type
export(NodePath) var target_entity

func _ready():
	if target_entity == null:
		print("SetEntityTargetListener has no valid target entity.")
	else:
		target_entity = get_node(target_entity)
	
	EventBus.listen(event_name, self, "on_Event_name")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func on_Event_name(data):
	set_entity_target(data[event_type.to_lower()])

func set_entity_target(entity):
	if entity.type == entity_type:
		entity.target = target_entity