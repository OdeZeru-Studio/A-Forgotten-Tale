extends KinematicBody2D

export (int) var speed = 100
export (int) var gravity = 200
var moving_left : bool = true

var velocity : Vector2
const UP : Vector2 = Vector2(0, -1)

onready var rc = $RayCast2D

func _process(delta):
	detect_turn_around()
	move()
	
func detect_turn_around():
	if not rc.is_colliding() and is_on_floor():
		moving_left = !moving_left
		scale.x = -scale.x
	else:
		scale.x = -scale.x

func move():
	velocity.y = gravity
	
	velocity.x = -speed if moving_left else speed
	

	velocity = move_and_slide(velocity, UP)
