extends RayCast3D
signal start_shooting

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("shoot"):
		var col_point = null
		if is_colliding(): col_point = get_collision_point()
		startShooting(col_point)

func startShooting(col_point):
	emit_signal("start_shooting", col_point)
	
