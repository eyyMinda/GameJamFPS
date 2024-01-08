extends Node3D

const SPEED: float = 50.0
const DAMAGE: float = 30

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@onready var particles = $GPUParticles3D

func _process(delta):
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if ray.is_colliding():
		mesh.visible = false
		particles.emitting = true
		ray.enabled = false
		
		var collider = ray.get_collider()
		if collider.is_in_group("entity"):
			collider.hit(DAMAGE)
		await get_tree().create_timer(1).timeout
		# Delete bullet after 1 second of allowing particles to emit
		queue_free()

# Delete bullet that dont hit anything and a fallback if previous deletion doesn't work
func _on_timeout():
	queue_free()
