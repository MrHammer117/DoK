extends CharacterBody2D
const MAX_SPEED = 150
const FRICTION = 500

const ACCELERATION = 500

func _ready():
	add_to_group("Player")
# I do not need to create velocity or what I originally had movement, because velocity is alreayd a 
# member of the class CharacterBody2D
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	#This line below takes input from the user and transmits it straight to the character
	#left and right
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#up and down
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized( )
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		#print(velocity)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		
	#This automatically uses the variable velocity, unlike the tutorial I am watching I do not need
	#to pass a variable, this already does everything for me!!!
	move_and_slide()
