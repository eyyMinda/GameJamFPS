extends RayCast3D

signal raycast_hit

var last_detected_name = ""

func _physics_process(_delta):
	var current_detected_name = ""

	if is_colliding():
		var detected = get_collider()
		if detected is Interactable:
			current_detected_name = detected.get_prompt()
			if Input.is_action_just_pressed(detected.prompt_action):
				detected.interact(detected.get_interactable_name())
				
	# Check if the detected name has changed or if there's no longer a collision
	if current_detected_name != last_detected_name or (last_detected_name != "" and not is_colliding()):
		raycast_hit.emit(current_detected_name)
		last_detected_name = current_detected_name
