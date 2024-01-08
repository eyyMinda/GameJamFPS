extends NavigationRegion3D

@export var Enemy:PackedScene
	
func UpdateNavmesh():
	bake_navigation_mesh()
	await get_tree().create_timer(1).timeout # Wait for Navmesh to finish baking
	SpawnEnemyOnRandom()

func SpawnEnemyOnRandom():
	var max_attempts = 100
	var attempts = 0
	var navigation_map = get_navigation_map()
	
	while attempts < max_attempts:
		var random_point = generate_random_point_within_bounds()
		var point_on_navmesh = NavigationServer3D.map_get_closest_point(navigation_map, random_point)
		
		# Check if the point is on the NavMesh
		if random_point.distance_to(point_on_navmesh) < 1.0:
			# Spawn enemy at point_on_navmesh
			spawn_enemy_at(point_on_navmesh)
			print(point_on_navmesh)
			return point_on_navmesh

		attempts += 1
	return null # Return null if no suitable point found

func generate_random_point_within_bounds():
	var extent_x = -7 # Define the extent of your level in x
	var extent_z = 10 # Define the extent of your level in z
	return Vector3(randf_range(extent_x, extent_x * 6), 0, randf_range(-extent_z, extent_z))

# function to spawn an enemy
func spawn_enemy_at(pos):
	var enemy = Enemy.instantiate()
	enemy.global_transform.origin = pos
	add_child(enemy)
