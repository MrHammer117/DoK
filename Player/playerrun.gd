extends CharacterBody2D
const MAX_SPEED = 150
const FRICTION = 500

const ACCELERATION = 500
var movement = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	#This line below takes input from the user and transmits it straight to the character
	#left and right
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#up and down
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized( )
	if input_vector != Vector2.ZERO:
		movement = movement.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		print(movement)
	else:
		movement = movement.move_toward(Vector2.ZERO, FRICTION * delta)
		
		
	# The velocity (movement) is multiplied by delta (the framerate) to keep the game consistent
	# This is pixels per second now instead of pixels per frame
	move_and_collide(movement * delta)
