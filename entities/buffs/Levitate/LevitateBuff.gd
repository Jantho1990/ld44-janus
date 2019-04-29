extends Node

const ACCELERATION = 25
const MAX_SPEED = 150

var duration = 3

var target
var remaining

func _ready():
	remaining = duration
	target.get_node('MovementHandler').set_overrides({
		"down": funcref(self, "down"),
		"idle": funcref(self, "idle"),
		"left": funcref(self, "left"),
		"right": funcref(self, "right"),
		"up": funcref(self, "up")
	})
	target.is_flying = true

func _input(event):
	if event.is_action_pressed("cast"):
		remaining = 0

func _physics_process(delta):
	remaining -= delta
	if remaining >= 0:
		#TODO: Add sound, maybe anim
		if not $Sounds/Levitate.playing:
			$Sounds/Levitate.play()
		pass
	else:
		target.get_node('MovementHandler').clear_overrides()
		target.is_flying = false
		queue_free()

func down():
	target.motion.y = min(target.motion.y + ACCELERATION, MAX_SPEED)

func idle():
	if target.motion.y > 0:
		target.motion.y = max(target.motion.y - ACCELERATION, 0)
	elif target.motion.y < 0:
		target.motion.y = min(target.motion.y + ACCELERATION, 0)

func left():
	target.motion.x = max(target.motion.x - ACCELERATION, -MAX_SPEED)
	target.get_node("Sprite").flip_h = true
	target.dir_x = -1
	#playAnim('run')

func right():
	#target.motion.x += ACCELERATION
	target.motion.x = min(target.motion.x + ACCELERATION, MAX_SPEED)
	target.get_node("Sprite").flip_h = false
	target.dir_x = 1
	#playAnim('run')

func up():
	#target.motion.y += ACCELERATION
	target.motion.y = max(target.motion.y - ACCELERATION, -MAX_SPEED)