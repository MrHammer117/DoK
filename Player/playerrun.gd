extends CharacterBody2D

var health = 100
 
var bulletSpeed = 300
var bullet = preload("res://Weapons/Bullet.tscn")

var player_health = 150


const MOVE_SPEED: float = 500
@export var speed_multiplier: int = 1

func _ready():
	add_to_group("Player")
	
	
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

func fire():
	var bullet_instance = bullet.instantiate()
	owner.add_child(bullet_instance)
	bullet_instance.transform = $ShootFromHere.global_transform
	
func damaged(damage):
	player_health = player_health-damage
