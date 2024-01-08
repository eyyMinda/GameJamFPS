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
	var args = [stream, "3D", ground_pos, randf_range(1, 1.8), -30]
	play_sound(args)
	
func play_jump_sound():
	var args = [jump_sound, "3D", ground_pos, randf_range(0.95, 1.05), -30]
	play_sound(args)


func play_sound(args: Array):
	get_tree().get_nodes_in_group("Audio")[0].callv("play_sound", args)
	
