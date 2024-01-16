extends Node3D

@export_category("Bullet Stats")
@export var speed := 50.0
@export var pierce_damage := 30.0
@export var max_distance: float
@export var life_time := 1.0

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@onready var particles = $GPUParticles3D

var trail_mesh_height: float

func _ready():
	trail_mesh_height = mesh.mesh.height
	if max_distance == 0:
		await get_tree().create_timer(life_time).timeout;
		queue_free();

func _process(delta):
	position += transform.basis * Vector3(0, 0, -speed) * delta
	#position += Vector3.FORWARD * speed * delta;
		
	if ray.is_colliding() or max_distance > 0 and \
		global_position.distance_to(\
		mesh.global_position) >= (max_distance - (trail_mesh_height * 2)):
		mesh.visible = false
		particles.emitting = true
		ray.enabled = false
		
		var collider = ray.get_collider()
		if collider and collider.is_in_group("entity"):
			collider.hit(pierce_damage)
			await get_tree().create_timer(1).timeout
		queue_free()

# Delete bullet that dont hit anything and a fallback if previous deletion doesn't work
func _on_timeout():
	queue_free()
