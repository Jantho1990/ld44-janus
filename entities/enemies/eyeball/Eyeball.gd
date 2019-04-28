extends KinematicBody2D

export(float) var speed = 120
export(float) var attack_boost = 1.75
export(float) var attack_range = 100.00
export(float) var attack_damage = 0.25
export(float) var health = 1

var type = "email"

enum STATES {
	WANDER = 0,
	ATTACK = 1,
	FLEE = 2
}

export(float) var waypoint_range = 200

var target setget set_target, get_target
var waypoint

# This will be set if the entity is spawned by a generator
var generator

onready var state = preload("res://handlers/State.tscn").instance()

func _ready():
	make_new_waypoint()
	state.set_state(STATES.WANDER)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	if $Health.current == 0:
		die()
	
	var coordinates = get_coordinates()
	var angle = self.get_angle_to(coordinates)
	var distance = self.position.distance_to(coordinates)
	var xo = 0
	var yo = 0
	
#	if target != null:
#		face_target()
#	else:
#		face_direction(angle)
	
	match state.current:
		STATES.ATTACK:
			xo = cos(angle) * speed * delta * attack_boost
			yo = sin(angle) * speed * delta * attack_boost
			if distance < 60:
				state.set_state(STATES.FLEE)
		STATES.FLEE:
			xo = -cos(angle) * speed * delta
			yo = -sin(angle) * speed * delta
			if distance > 120:
				if math.randOneIn(2):
					state.set_state(STATES.WANDER)
					make_new_waypoint()
				else:
					state.set_state(STATES.ATTACK)
		STATES.WANDER:
			xo = cos(angle) * speed * delta
			yo = sin(angle) * speed * delta
			if distance < 60:
				state.set_state(STATES.FLEE)
	
	# Bob a bit
	yo += sin(global.run_time / 0.1) * 0.5
	
	position += Vector2(xo, yo)
	
	if is_near_target():
		attack_target()
	
	if math.randOneIn(177):
		playAnim("blink")
	
	if $Sprite/AnimationPlayer.current_animation == "":
		playAnim("flying")
		

func on_Animation_finished(anim):
	print("finished")
	playAnim(anim)

func attack_target():
	target.hit(attack_damage)

func die():
	EventBus.dispatch("enemy_dead", {
		"enemy": self,
	})
	queue_free()

func face_direction(angle):
	var rad = PI / 2
	
	# Direction x
	if abs(angle) >= rad:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true
	
	# Direction y
	if sign(angle) < 0:
		$Sprite.flip_v = false
	else:
		$Sprite.flip_v = true

func face_target():
	var angle = get_angle_to(target.position)
	face_direction(angle)

func get_coordinates():
	match target == null or state.current == STATES.WANDER:
		true:
			return waypoint
		false:
			return target.position

func hit(damage):
	$Health.hurt(damage)

func is_near_target():
	if target == null:
		return false
	
	if self.position.distance_to(target.position) <= attack_range:
		return true

func get_waypoint():
	pass

func make_new_waypoint():
	waypoint = Vector2(
		math.rand(-waypoint_range, waypoint_range),
		math.rand(-waypoint_range, waypoint_range)
	)

func playAnim(anim):
	if $Sprite/AnimationPlayer.current_animation != anim || !$Sprite/AnimationPlayer.is_playing():
		$Sprite/AnimationPlayer.play(anim)

func set_target(new_target):
	if new_target == null:
		print("Do not set target to null, use unset_target() instead.")
	
	target = new_target
	add_collision_exception_with(target)

func get_target():
	return target

func unset_target():
	target = null

func spawn_acceptable(Tilemap, spawn):
	return true