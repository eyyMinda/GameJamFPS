class_name MuzzleFlash
extends Node3D

@export var particles: GPUParticles3D;
@export var life_time: float = 0.3;

func _ready():
	particles.emitting = true;

	await get_tree().create_timer(life_time).timeout;
	queue_free();
