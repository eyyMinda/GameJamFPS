extends Node  # Change this to the appropriate node type (e.g., KinematicBody, RigidBody, etc.)

@export var health := 100

@export var hit_sound: AudioStreamWAV
@onready var rootScene = get_owner()

const DAMAGE_EFFECT = 30 # higher = more damage based on weapon and resistance

func _on_body_part_hit(damage, resistance, part):
	var true_damage = round(damage / resistance * DAMAGE_EFFECT)
	health -= true_damage
	play_hit_sound()
	print("Dealt " + str(true_damage) + " to " + rootScene.name + " " + part)
	
	if health <= 0: destroy_object(rootScene)

# Destroy the object when health reaches zero
func destroy_object(object: Object):
	object.queue_free()
	print("Entity killed")
	
func play_hit_sound():
	AudioManager.play_sound(hit_sound, "sfx", rootScene, randf_range(0.8, 1.2), -15.0)
