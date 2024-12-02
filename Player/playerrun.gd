extends CharacterBody2D

const healthMAX = 150
var health = 100
 
@onready var health_bar = $Health/Healthbar
@onready var health_bar_max_width = health_bar.size.x

var bulletSpeed = 300
var bullet = preload("res://Weapons/Bullet.tscn")

var player_health = 150
var hp = healthMAX


const MOVE_SPEED: float = 150
@export var speed_multiplier: int = 1

func _ready():
	add_to_group("Player")
	update_health_bar() 
	
func _process(delta: float) -> void:
	connect_enemy_signals()
	if player_health <= 0:
		get_tree().change_scene_to_file("res://Menus/Main_Menu.tscn")

func connect_enemy_signals():
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if enemy.has_signal("damage_dealt"):
			if enemy.damage_dealt.is_connected(damaged):
				enemy.damage_dealt.disconnect(damaged)
			enemy.damage_dealt.connect(damaged)

func move() -> void:
	var movement: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("Left"): movement.x -= 1.0
	if Input.is_action_pressed("Right"): movement.x += 1.0
	if Input.is_action_pressed("Up"): movement.y -= 1.0
	if Input.is_action_pressed("Down"): movement.y += 1.0
	velocity = movement.normalized() * (MOVE_SPEED * speed_multiplier)
	move_and_slide()
	

func _physics_process(delta: float) -> void:
	move()
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Shoot"):
		fire()

func fire():
	$"Blunderbuss-shot-101Soundboards".play()
	var bullet_instance = bullet.instantiate()
	owner.add_child(bullet_instance)
	bullet_instance.transform = $ShootFromHere.global_transform
	
	
func damaged(damage):
	player_health = player_health-damage
	player_health = clamp(player_health, 0, 150)
	update_health_bar()
	
func update_health_bar():
	var health_percentage = float(player_health) / healthMAX
	health_bar.size.x = health_bar_max_width * health_percentage
