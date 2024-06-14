extends CharacterBody2D
class_name ElfMeleeSprite

func _ready():
	add_to_group("enemy")

func _physics_process(_delta):
	move_and_slide()
