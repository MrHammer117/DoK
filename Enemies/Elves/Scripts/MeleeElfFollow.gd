extends State
class_name followElf

@export var enemy: CharacterBody2D
@export var move_speed := 150.0
var player: CharacterBody2D

# Signal to handle state transitions
signal transitioned(new_state: String)

func _ready():
	# Get the player node from the group "Player"
	player = get_tree().get_first_node_in_group("Player")

func Update(delta: float):
	return

func Physics_Update(delta: float):
	if enemy == null or player == null:
		return

	var direction = player.global_position - enemy.global_position
	
	print(direction.length())
	
	if direction.length() > 35:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
	
	if direction.length() > 500:
		Transitioned.emit(self, "elfMeleeIdle")
