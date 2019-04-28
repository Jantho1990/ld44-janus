extends Area2D

class_name Door


const MINIMUM_SPAWN_DISTANCE = 20

var player_overlap = false
var map_index = null
var generator

func _ready():
	self.connect("body_entered", self, "on_Body_entered")
	self.connect("body_exited", self, "on_Body_exited")
#	$Sprite/AnimationPlayer.play("idle")

func _physics_process(delta):
	if player_overlap and Input.is_action_just_pressed("interact"):
		print("Door accessed: ", map_index)
		handle_interaction()
		

func spawn_acceptable(tilemap, pos):
	var cell = tilemap.world_to_map(pos)
	var above = tilemap.tile_above_pos(pos)
	var below = tilemap.tile_below_pos(pos)

	# Code for JungleDirt tileset
	if tilemap.get_cell(above.x, above.y) == -1 \
		and tilemap.get_cell(cell.x, cell.y) == -1 \
		and tilemap.get_cell(below.x, below.y) != -1:
	# Code for SanityBrick tileset
#	if tilemap.get_cell(above.x, above.y) == -1 \
#		and tilemap.get_cell(cell.x, cell.y) == 0 \
#		and tilemap.get_cell(below.x, below.y) >= 1:
			return true
	return false

func on_Body_entered(body):
	print(body)
	if body.name == "Player":
		player_overlap = true

func on_Body_exited(body):
	if body.name == "Player":
		player_overlap = false

func handle_interaction():
	print("interaction")
	EventBus.dispatch("door_accessed", {
		"map_index": map_index,
		"door": self
	})
	
func destroy():
	get_parent().remove_child(self)