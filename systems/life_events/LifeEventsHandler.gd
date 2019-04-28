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
var life_event_active = false setget _private_set

func _private_set(_throwaway_):
	print("Private set: " + get_class())

# Called when the node enters the scene tree for the first time.
func _ready():
	load_events_from_directory()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_events_from_directory():
	var dir = Directory.new()
	if dir.open(life_events_directory) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if file_name != ".." and file_name != ".":
				add_life_event(load_event_from_file(file_name.replace(".json", "")))			
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

func add_life_event(data):
	life_events.push_back(data)

func display(event_name): # Display a new life event on screen.
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
	life_event_active = true