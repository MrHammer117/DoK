extends CharacterBody2D
const MAX_SPEED = 150
const FRICTION = 500

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true


@export var speed = 400

func _ready():
	add_to_group("Player")
# I do not need to create velocity or what I originally had movement, because velocity is alreayd a 
# member of the class CharacterBody2D

func get_input(delta):
	
	var motion = Vector2()
	
	position += Input.get_vector("left", "right", "up", "down") * speed * delta
	
	look_at(get_global_mouse_position())
	

func _physics_process(delta):
	get_input(delta)
	move_and_slide()

func player():
	pass


func _on_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range:
		print("damaged")
