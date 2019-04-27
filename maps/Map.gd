extends Node

signal map_loaded

onready var Tilemap = $TileMap
onready var tome = $Tome


var has_exit_portal = false
var exit_portal
var auto_link

var map_index = null
var portals = null
var totem

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	print("loading map...", map_index)
	
	if get_parent().get("auto_link") != null:
		auto_link = get_parent().auto_link
	
	# Randomly spawn the portal locations
	var i = null
	var total_maps = null
	portals = helpers.array_filter(get_children(), funcref(self, "find_portals"))
	if auto_link:
		total_maps = get_parent().maps.size()
		i = map_index - 1
		if i < 0:
			i = total_maps - 1
#	for portal in portals:
#		random_spawn(portal)
#		portal.current_map_index = self.map_index
#		if auto_link:
#			portal.map_index = i
#			i += 2
#			if i >= total_maps:
#				i -= total_maps
		
	# For now, assume there will only ever be two portals
#	while have_same_spawn(portals[0], portals[1]):
#		random_spawn(portals[0])
	
	# Randomly spawn the location of the tome
#	random_spawn(tome)
#	tome.position += Vector2(tome.width / 2, 0)
	
	# If this map has the exit portal, create it.
	if has_exit_portal == true:
#		exit_portal.instance()
		random_spawn(exit_portal)
		add_child(exit_portal)
	
	# Map is loaded, trigger any code that is waiting on this.
	EventBus.dispatch(name + "_loaded", {
		"node": self
	})
#	emit_signal("map_loaded")

# Find Portal nodes.
func find_portals(node):
	#if node.has("_class_name") && node._class_name == "Portal":
	if "_class_name" in node && node._class_name == "Portal":
		return true
	return false

# Get player from parent WorldMap
func get_player_from_parent():
	return get_parent().player

# Return true if entities have the same spawn position.
func have_same_spawn(ent1, ent2):
	return ent1.position == ent2.position

# Spawn an entity in a random tile location on the map.
func random_spawn(entity):
	var valid = false
	var spawn = null
	
	var failct = 0
	while not valid:
		# Generate a random cell from the map grid
		spawn = Tilemap.random_cell_pos()
		
		# Validate that this random cell is a valid spawn point
		if not entity.has_method("spawn_acceptable"):
			print("ERROR: Cannot random spawn entity without spawn_acceptable method. ", entity)
			return
		elif not entity.spawn_acceptable(Tilemap, spawn):
			valid = false
		else:
			valid = true
	
	# Create the entity
	entity.position = spawn

# Return a random tile from that map.
func random_tile():
	return Tilemap.random_cell()

# Return a random tile location on the map.
func random_tile_pos():
	return Tilemap.random_cell_pos()