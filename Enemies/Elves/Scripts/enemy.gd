extends CharacterBody2D

@export var speed: float = 100.0
@export var attack_distance: float = 50.0
@export var attack_cooldown: float = 1.5  # Cooldown between attacks

enum State { IDLE, CHASE, ATTACK }
var current_state = State.IDLE
var attack_timer = 0.0
var player: Node2D  
var rng = RandomNumberGenerator.new()
signal damage_dealt(damage_amount)

func _ready():
	add_to_group("enemies")
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		player = players[0]  

func _physics_process(delta):
	if not player or not is_instance_valid(player):
		return 

	match current_state:
		State.IDLE:
			idle_behavior()
		State.CHASE:
			chase_behavior()
		State.ATTACK:
			attack_behavior(delta)

func idle_behavior():
	if global_position.distance_to(player.global_position) <= 300:
		current_state = State.CHASE  # Switch to chase immediately if player exists

func chase_behavior():
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	# Check if within attack distance
	if global_position.distance_to(player.global_position) <= attack_distance:
		current_state = State.ATTACK
		attack_timer = 0.0
		
	if global_position.distance_to(player.global_position) >= 300:
		current_state = State.IDLE

func attack_behavior(delta):
	attack_timer += delta
	if attack_timer >= attack_cooldown:
		# Attack logic here (e.g., apply damage, trigger animation)
		print("Attacking the player!")
		var my_random_number = rng.randf_range(8.0,12.0)
		
		emit_signal("damage_dealt", my_random_number)
		attack_timer = 0.0  # Reset timer
	
	# Return to chase if the player moves out of range
	if global_position.distance_to(player.global_position) > attack_distance:
		current_state = State.CHASE
