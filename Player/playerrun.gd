extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
 
var bulletSpeed = 300
var bullet = preload("res://Weapons/Bullet.tscn")


const MOVE_SPEED: float = 500
@export var speed_multiplier: int = 1

func _ready():
	add_to_group("Player")

func move() -> void:
	var movement: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("left"): movement.x -= 1.0
	if Input.is_action_pressed("right"): movement.x += 1.0
	if Input.is_action_pressed("up"): movement.y -= 1.0
	if Input.is_action_pressed("down"): movement.y += 1.0
	velocity = movement.normalized() * (MOVE_SPEED * speed_multiplier)
	move_and_slide()
	

func _physics_process(delta: float) -> void:
	move()
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("click"):
		fire()

func player():
	pass

func fire():
	var bullet_instance = bullet.instantiate()
	owner.add_child(bullet_instance)
	bullet_instance.transform = $ShootFromHere.global_transform
	

func _on_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range:
		print("damaged")
