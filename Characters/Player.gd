extends KinematicBody2D

export (int) var speed = 100
export (int) var jump_strength = 150
export (int) var gravity = 20
var max_gravity : int = 2000
var is_jumping = false

var velocity : Vector2
const UP : Vector2 = Vector2(0, -1)

### SKILLS/UNLOCKABLE ABILITIES ###
export (bool) var double_jump = false
const jumps : int = 2
var jumped : int = 0
var wall_jump : bool = false
# Stop player from using a slide if HP < 33%
var slide : bool = false 
var back_dash : bool = false

func _physics_process(delta):
	velocity.y += gravity
	if velocity.y > max_gravity:
		velocity.y = max_gravity
	
	move()

func move():
	velocity.x = (Input.get_action_strength("Right") - Input.get_action_strength("Left")) * speed
	
	if Input.is_action_pressed("Jump"):
		if double_jump and jumped == jumps:
			jumped += 1
			print(jumped)
			is_jumping = true
			velocity.y = -jump_strength
		elif is_on_floor():
			is_jumping = true
			velocity.y = -jump_strength
			
#		is_jumping = true
#		velocity.y = -jump_strength
	elif not is_on_floor() and Input.is_action_just_released("Jump") and is_jumping:
		is_jumping = false
		if velocity.y > 0:
			pass
		else:
			velocity.y = gravity
			velocity.y += gravity

	velocity = move_and_slide(velocity, UP)
