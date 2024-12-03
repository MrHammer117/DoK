extends Control

func _ready() -> void:
	# Connect to the signal from Godclass (this is the singleton)
	Godclass.damage_taken_updated.connect(_on_damage_taken_updated)
	Godclass.damage_done_updated.connect(_on_damage_Done_updated)
	Godclass.kills_updated.connect(_on_kill_updated)

	# Initialize with the current value
	_on_damage_taken_updated(Godclass.total_damage_taken)
	_on_damage_Done_updated(Godclass.total_damage_done)
	_on_kill_updated(Godclass.total_enemies_killed)

func _on_damage_taken_updated(new_value: int) -> void:
	$VBoxContainer/DamageTaken.text = "Total Damage Taken: %d" % new_value
	
func _on_damage_Done_updated(new_value: int) -> void:
	$VBoxContainer/DamageDone.text = "Total Damage Done: %d" % new_value
	
func _on_kill_updated(new_value: int) -> void:
	$VBoxContainer/Kills.text = "Total Kills: %d" % new_value

func _process(delta: float) -> void:
	pass


func _on_exit_pressed() -> void:
	self.visible = false
