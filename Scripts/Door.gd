extends Node3D

@export var isOpen = false
@export var isLocked = true
@export var DoorOpen: AudioStreamWAV
@export var DoorClose: AudioStreamWAV

const TRANSITION_SPEED: float = 0.5
const TRANSLATION_AMOUNT: float = 3.0
var stream
var initialPositionY: float  # Store the initial position

@onready var DoorMeshRef = $Door
var LockedMat = load("res://Art/EmissiveGlowRed.tres")
var UnlockedMat = load("res://Art/EmissiveGlow.tres")

func _ready():
	initialPositionY = position.y
	DoorMeshRef.set_surface_override_material(2, LockedMat)
	
func toggle_door(body):
	if !isLocked:
		isOpen = !isOpen
		var targetPositionY = initialPositionY + (TRANSLATION_AMOUNT * float(isOpen))
		move_door(targetPositionY)
		
		if isOpen: stream = DoorOpen
		else: stream = DoorClose
		var args = [stream, "3D", self, 1.2, -15]
		get_tree().get_nodes_in_group("Audio")[0].callv("play_sound", args)
		
	else:
		get_tree().call_group("Announcement", "Notify", 2.0, body + " is inaccessible")


func move_door(targetPos):
	var startPos = position.y
	var elapsed = 0.0
	while elapsed < 1.0:
		elapsed += TRANSITION_SPEED * get_process_delta_time()
		var easedProgress = ease_in_out(elapsed)
		position.y = lerp(startPos, targetPos, easedProgress)
		await get_tree().create_timer(0.0).timeout
		
	position.y = targetPos
	
func ease_in_out(t):
	if t < 0.5:
		return 4 * t * t * t
	else:
		return 1 - pow(-2 * t + 2, 3) / 2

func unlock_airlock():
	isLocked = false
	DoorMeshRef.set_surface_override_material(2, UnlockedMat)

func lock_airlock():
	if isOpen:
		toggle_door("Airlock")
	isLocked = true
	DoorMeshRef.set_surface_override_material(2, LockedMat)
