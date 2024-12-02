extends SubViewport

@onready var camera = $Camera2D
@onready var player = $"../../.."

func _physics_process(delta):
	camera.position = player.position
