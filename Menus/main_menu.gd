extends Control
@onready var optionsMenu = $CanvasLayer/Options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Map1.tscn")


func _on_options_button_pressed() -> void:
	optionsMenu.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()
