extends KinematicBody2D

export(Vector2) var origin

var distance_traveled = 0

export(float) var speed = 500
export(Vector2) var dir
export(float) var dir_x
export(float) var dir_y
export(float) var bullet_range = 200
export(float) var damage = 10

var pos = Vector2()

func _ready():
	position = origin
	if sign(dir.x) > 0:
		$Sprite/AnimationPlayer.play("burn_right")
	else:
		$Sprite/AnimationPlayer.play("burn_left")

func _physics_process(delta):
	#position.x += speed * dir_x * delta
	#position.y += speed * dir_y * delta
	#pos += Vector2(speed * dir.x * delta, speed * dir.y * delta)
	pos += speed * dir * delta
	var collision = move_and_collide(pos)
	if (collision != null):
		# If this is an enemy, apply damage
		print("Collision! ", collision.collider)
		if collision.collider.has_method("hit"):
			collision.collider.hit(damage)
		queue_free()
	#distance_traveled += 
