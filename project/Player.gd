extends KinematicBody2D

const GRAVITY = 500
const WALK_SPEED = 300
const MAX_WALK_SPEED = 200
const JUMP_FORCE = 250
const MAX_JUMPS = 1
const EDGE_JUMP_HELP = 80

var acceleration = Vector2(0, GRAVITY)
var velocity = Vector2()
var number_of_jumps = 0

func _process(delta):
	#collision with barrel stuff here
	pass

func _physics_process(delta):
	# gravity first
	velocity.y += acceleration.y * delta

	if(Input.is_action_just_pressed("jump")):
		if(number_of_jumps < MAX_JUMPS):
			velocity.y = -JUMP_FORCE
			number_of_jumps += 1
	if(Input.is_action_just_released("jump")):
		velocity.y *= 0.6

	# left/right movement
	if(Input.is_action_pressed("left")):
		if(velocity.x > 0):
			velocity.x = velocity.x * 0.85
		acceleration.x = -WALK_SPEED
	elif(Input.is_action_pressed("right")):
		if(velocity.x < 0):
			velocity.x = velocity.x * 0.85
		acceleration.x = WALK_SPEED
	else:
		acceleration.x = 0
		velocity.x = velocity.x * 0.85

	velocity.x += acceleration.x * delta
	if(abs(velocity.x) > MAX_WALK_SPEED):
		velocity.x = sign(velocity.x) * MAX_WALK_SPEED

	if(is_on_wall()):
		velocity.x = 0
	if(is_on_ceiling()):
		velocity.y = 0

	move_and_slide(velocity, Vector2(0, -1))


	if(velocity.y > EDGE_JUMP_HELP):
		number_of_jumps = MAX_JUMPS

	if(is_on_floor()):
			velocity.y = 0
			number_of_jumps = 0