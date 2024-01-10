extends Node3D

@export var footstep_sounds: Array[AudioStreamWAV]
@export var jump_sound: AudioStreamWAV
@export var ground_pos: Marker3D

@onready var player: CharacterBody3D = get_parent()

func _ready():
	player.step.connect(play_step_sound)
	player.jump.connect(play_jump_sound)


func play_step_sound():
	var random_index: int = randi_range(0, footstep_sounds.size() - 1)
	var stream = footstep_sounds[random_index]
	AudioManager.play_sound(stream, "sfx", ground_pos, randf_range(1, 1.8), -30.0)

func play_jump_sound():
	AudioManager.play_sound(jump_sound, "sfx", ground_pos, randf_range(0.95, 1.05), -30.0)
