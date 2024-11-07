extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
 
var bulletSpeed = 3000
var bullet = preload("res://Weapons/Bullet.tscn")


@export var speed = 250

func _ready():
	add_to_group("Player")

func get_input(delta):
	position += Input.get_vector("left", "right", "up", "down") * speed * delta
	look_at(get_global_mouse_position())

func _physics_process(delta):
	get_input(delta)
	move_and_slide()

func player():
	pass

func fire():
	var bullet_instance
	#finish implementation

func _on_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range:
		print("damaged")
