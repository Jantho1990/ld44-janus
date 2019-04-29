extends Node

class_name LifeEventsHandler

###
# Configurable variables
###
export(String) var life_events_directory = "res://life_events/"

###
# Preloads
###
var LifeEvent = preload("res://systems/life_events/LifeEvent.tscn")

###
# Properties
###
var life_events = [] setget _private_set
var life_event_names = [] setget _private_set
var life_event_active = false setget _private_set
var current_life_event
var life_event_door

func _private_set(_throwaway_):
	print("Private set: " + get_class())

# Called when the node enters the scene tree for the first time.
func _ready():
	load_events_from_directory()
	
	EventBus.listen("door_accessed", self, "on_Door_accessed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_events_from_directory():
	var dir = Directory.new()
	if dir.open(life_events_directory) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if file_name != ".." and file_name != "." and file_name.find("json") == -1:
				add_life_event(load_event_from_resource(file_name.replace(".tres", "")))			
			file_name = dir.get_next()
	else:
		print("Invalid directory for life events: ", life_events_directory)


func load_event_from_file(file_id): # Load the life event from a file.
	var file = File.new()
	file.open('%s/%s.json' % [life_events_directory, file_id], file.READ)
	var json = file.get_as_text()
	var obj = JSON.parse(json).result
	file.close()
	obj.event_name = file_id
	return obj

func load_event_from_resource(resource_id):
	var res = load('%s/%s.tres' % [life_events_directory, resource_id])
	res.event_name = resource_id
	return res

func add_life_event(data):
	life_events.push_back(data)
	life_event_names.push_back(data.event_name)

func display_random():
	var lower = 0	
	var upper = life_event_names.size() - 1
	
	var e = math.rand(lower, upper)
	var event_name = life_event_names[e]
	
	display(event_name)

func display(event_name): # Display a new life event on screen.
	# Ensure we have no active life events
	if life_event_active:
		remove_life_event()
		
	var life_event_data
	for le in life_events:
		if le.event_name == event_name:
			life_event_data = le
			break
	
	var life_event = LifeEvent.instance()
	life_event.text = life_event_data.text
	life_event.cost = life_event_data.cost
	life_event.reward = life_event_data.reward
	
	add_child(life_event)
	current_life_event = life_event
	life_event_active = true

func on_Door_accessed(data):
	life_event_door = data.door
	display_random()

func reject_life_event():
	remove_life_event()
	print("Life event rejected!")

func remove_life_event():
	remove_child(current_life_event)
	life_event_active = false
	EventBus.dispatch("remove_door", { "entity": life_event_door })