extends Node

var total_enemies_killed: int = 0
var total_damage_taken: int = 0
var total_damage_done: int = 0

# Signal to notify when damage is updated
signal damage_taken_updated(new_value: int)
signal damage_done_updated(new_value: int)
signal kills_updated(new_value: int)

# Method to register damage taken
func register_damage(damage: int) -> void:
	total_damage_taken += damage  # Update damage
	damage_taken_updated.emit(total_damage_taken)  # Emit signal
	
func register_damage_done(damage: int) -> void:
	total_damage_done += damage  # Update damage
	damage_done_updated.emit(total_damage_done)  # Emit signal
	
func register_kills(kills: int) -> void:
	total_enemies_killed += kills
	kills_updated.emit(total_enemies_killed)
