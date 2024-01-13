class_name Player
extends CharacterBody3D

@export_category("Movement")
@export var MAX_SPEED_WALK := 3.5
@export var MAX_SPEED_SPRINT := 5.5
@export var ACCELERATION := 7.0
@export var ACCELERATION_SPRINT := 10.0
@export var DECELERATION := 2.0
@export var JUMP_VELOCITY := 4.5
var speed: float; var acceleration: float;

@export_category("Camera")
@export var SENSITIVITY := 0.002
@export var MAX_LOOK_DOWN := -75.0
@export var MAX_LOOK_UP := 100.0

@export_category("Head Bob")
@export var BOB_FREQ := 3.0
@export var BOB_AMP_DEFAULT := 0.06
const BOB_AMP_DISABLED := 0.01
var bob_amp = BOB_AMP_DEFAULT
var t_bob := 0.0

@export_category("FOV")
@export var base_fov := 75.0
@export var FOV_CHANGE := 1.5 # ratio of FOV change during movement based on speed

# Footsteps
var can_play: bool = true
signal step; signal jump # Play sound signal

@onready var starting_position = global_transform.origin

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var neck := $NeckPivot
@onready var camera := $NeckPivot/Camera3D

func _unhandled_input(event):
	# Preventing window exit & Camera rotation based on MOUSE MOTION
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * SENSITIVITY)
			camera.rotate_x(-event.relative.y * SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(MAX_LOOK_DOWN), deg_to_rad(MAX_LOOK_UP))


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		emit_signal("jump")
		
	if Input.is_action_pressed("sprint"):
		speed = MAX_SPEED_SPRINT
		acceleration = ACCELERATION_SPRINT
	else:
		speed = MAX_SPEED_WALK
		acceleration = ACCELERATION


	## Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
	# Uncomment this to remove acceleration during keypress, allows for quick direction swap - sidesteps
		#if direction:
			#velocity.x = direction.x * speed
			#velocity.z = direction.z * speed
		#else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * acceleration)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * acceleration)
	else: # To slow down a player changing directions mid-air
		velocity.x = lerp(velocity.x, direction.x * speed, delta * DECELERATION)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * DECELERATION)


	# FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, MAX_SPEED_SPRINT * 2)
	var target_fov = base_fov + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	# Head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)

	move_and_slide()


func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * bob_amp
	pos.x = cos(time * BOB_FREQ / 2) * bob_amp
	
	var low_pos = bob_amp / 2
	# Check if we have reached a high point so we restart can_play
	if pos.y > -low_pos:
		can_play = true
	# Check if the head position has reached a low point then turn off can play to avoid
	# multiple spam of the emit signal
	if pos.y < -low_pos and can_play:
		can_play = false
		emit_signal("step")
		
	return pos

# Player Settings
func change_fov(value): base_fov = value
func toggle_headbob(val): bob_amp = BOB_AMP_DEFAULT if val else BOB_AMP_DISABLED


func ResetLocation():
	global_transform.origin = starting_position
