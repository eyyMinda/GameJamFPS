extends PhysicsBody3D
class_name Interactable

signal interacted(body)

@export_category("Hover Prompt Info")
@export var prompt_message = "Interact"
@export var prompt_action = "interact"
# NOTE: Must set the collision layer/mask to 3

func get_prompt():
	var key_name = ""
	var action = InputMap.action_get_events(prompt_action)[0]
	if action is InputEventKey:
		key_name = OS.get_keycode_string(action.physical_keycode)
		return prompt_message + " [" + key_name + "]"

func get_interactable_name():
	return prompt_message

func interact(body):
	emit_signal("interacted", body)
