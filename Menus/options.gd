extends Control

@onready var input_button_scene = preload("res://Menus/Input Button Scene/inputbutton.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList

var is_remapping = false
var action_to_remap = null
var remapping_button = null


func _ready():
	_create_action_list()
	
func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
		
	
	 # Get all action names from the InputMap
	var action_names = InputMap.get_actions()

	# Iterate over each action and create a button for it
	for action_name in action_names:
		if str(action_name).begins_with("ui"):
			continue
		else:
			var button = input_button_scene.instantiate()
			var action_label = button.find_child("LabelAction")  # Change to the correct label node
			var input_label = button.find_child("LabelInput")  # Change to the correct label node
			action_label.text = action_name  # Set the action name in the label

			var input_strings = []
			for input_event in InputMap.action_get_events(action_name):
				input_strings.append(input_event.as_text())
				
			# Manually join the input strings with a comma
			var joined_inputs = ""
			for i in range(input_strings.size()):
				joined_inputs += input_strings[i]
				if i < input_strings.size() - 1:
					joined_inputs += ", "  # Add a comma between inputs

			input_label.text = joined_inputs  # Set the joined input string to the label

			input_label.text = joined_inputs  # Join multiple inputs with commas
			
			action_list.add_child(button)
			button.pressed.connect(_on_input_button_pressed.bind(button, action_name))
			

func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Press key to bind..."

func _input(event):
	if is_remapping:
		if(event is InputEventKey || (event is InputEventMouseButton && event.pressed)
		):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()

func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")
	


func _on_exit_pressed() -> void:
	self.visible = false
