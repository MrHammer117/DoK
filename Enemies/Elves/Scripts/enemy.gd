extends CharacterBody2D

@export var speed: float = 100.0
@export var attack_distance: float = 35
@export var attack_cooldown: float = .2  # Cooldown between attacks

var wanderDirection : Vector2
var wanderTime : float

enum State { IDLE, CHASE, ATTACK, FLEE, DEATH }
var current_state = State.IDLE
var attack_timer = 0.0
var player: Node2D  
var rng = RandomNumberGenerator.new()
signal damage_dealt(damage_amount)
var enemy_health = 80
var dead = false

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
		State.FLEE:
			flee_behavior()
		State.DEATH:
			death()

func idle_behavior():

	wanderDirection = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wanderTime = randf_range(1, 3)
	velocity = wanderDirection * speed
	move_and_slide()
	
	if global_position.distance_to(player.global_position) <= 1000:
		current_state = State.CHASE  # Switch to chase immediately if player exists
	
	if enemy_health < 20:
		current_state = State.FLEE
		
	if enemy_health <= 0:
		current_state = State.DEATH

func chase_behavior():
	look_at(player.global_position)
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	# Check if within attack distance
	if global_position.distance_to(player.global_position) <= attack_distance:
		current_state = State.ATTACK
		attack_timer = 0.0
		
	if global_position.distance_to(player.global_position) >= 1000:
		current_state = State.IDLE
		
	if enemy_health < 20:
		current_state = State.FLEE
		
	if enemy_health <= 0:
		current_state = State.DEATH

func attack_behavior(delta):
	look_at(player.global_position)
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
	
	if enemy_health < 20:
		current_state = State.FLEE
	
	if enemy_health <= 0:
		current_state = State.DEATH
		
func flee_behavior():
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed * -1
	move_and_slide()
	
	if enemy_health <= 0:
		current_state = State.DEATH
	
	

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		var my_random_number = rng.randf_range(10.0, 20.0)
		enemy_damaged(my_random_number)
		area.queue_free()
		
func enemy_damaged(damage):
	enemy_health -= damage

func death():
	enemy_health = 0
	dead = true
	queue_free()

func Update(delta: float):
	if wanderTime > 0:
		wanderTime -= delta
	else: 
		idle_behavior()
		
