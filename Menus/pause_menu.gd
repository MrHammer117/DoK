extends Control

@onready var optionsMenu = $Options
@onready var statsMenu = $StatsMenu

var _is_paused:bool = false:
	set(value):
		_is_paused = value
		get_tree().paused = _is_paused
		visible = _is_paused

func _unhandled_input(event:InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		_is_paused = !_is_paused

func _on_resume_button_pressed() -> void:
	_is_paused = false

func _on_options_button_pressed() -> void:
	optionsMenu.visible = true


func _on_stats_button_pressed() -> void:
	statsMenu.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()
