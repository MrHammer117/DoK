extends Area2D

class_name Projectile

var speed: float = 25.0
var randomNumber = RandomNumberGenerator.new()
signal Enemy_damage_dealt(damage_amount)

func _ready() -> void:
	add_to_group("projectile")

func _physics_process(delta: float) -> void:
	position += transform.x * speed

		

	
