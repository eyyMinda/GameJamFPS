extends Node3D

@export var gun_frequency: float = .8
@export var gun_sound: AudioStream
@export var bullet: PackedScene
@export var muzzle_flash: PackedScene


@onready var gun_anim = $AnimationPlayer
@onready var gun_barrel = $RayCast3D
@onready var aim_cast = %AimCast
@onready var muzzle_flash_marker = $MuzzleMarker3D

var canShoot: bool = true
var bullet_instance

func start_shooting(col_point):
	if canShoot:
		spawnBullet(col_point)
		playAnimSound()
		startCooldown()


func startCooldown():
	canShoot = false
	await get_tree().create_timer(gun_frequency).timeout
	canShoot = true

func playAnimSound():
	gun_anim.play("Shoot")
	AudioManager.play_sound(gun_sound, "sfx", gun_barrel, randf_range(.7, 1.5), -24.5)

func spawnBullet(col_point):
	print(col_point)
	bullet_instance = bullet.instantiate()
	#var look_at_point: Vector3 = gun_barrel.global_position + \
		#(-gun_barrel.global_transform.basis.z * 100);
	bullet_instance.position = gun_barrel.global_position
	bullet_instance.transform.basis = gun_barrel.global_transform.basis
	bullet_instance.rotation += Vector3(0.02, 0.02, 0) # Slight adjustment to possibly match the cursor
	
	#if aim_cast.is_colliding():
		#var aim_col_point = aim_cast.get_collision_point()
		#bullet_instance.max_distance = muzzle_flash_marker.global_position.distance_to(aim_col_point);
		#look_at_point = aim_col_point;
		#
	#bullet_instance.look_at(look_at_point, Vector3.UP);
	
	get_tree().get_root().add_child(bullet_instance)
	var muzzle_instance: MuzzleFlash = muzzle_flash.instantiate();
	muzzle_flash_marker.add_child(muzzle_instance);

# Aim Assist backup
#func spawnBullet(col_point):
	#bullet_instance = bullet.instantiate()
	#bullet_instance.position = gun_barrel.global_position
	##bullet_instance.transform.basis = gun_barrel.global_transform.basis
	#
	#var directionTo = gun_barrel.global_position.direction_to(col_point)
	#var target_point = gun_barrel.global_transform.origin + directionTo
	## Orient the bullet to face the target point
	#if directionTo:
		#bullet_instance.transform = gun_barrel.global_transform.looking_at(target_point, Vector3.UP)
	#else:
		#bullet_instance.transform.basis = gun_barrel.global_transform.basis
	#
	##bullet_instance.rotation += Vector3(0.02, 0.02, 0) # Slight adjustment to possibly match the cursor
	#get_tree().root.get_child(0).add_child(bullet_instance)
