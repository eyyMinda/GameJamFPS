extends CharacterBody3D 

# Enemy stats
const SPEED = 3.4
const ATTACK_RANGE = 1.5
const DETECT_RANGE = 8

@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("Player")
@onready var state_machine = anim_tree.get("parameters/playback")

@onready var distance_to_player: float = get_distance_to_player()
var detected: bool # Is player in range for enemy to see
var attack_range: bool # Is player in attack range for enemy to attack

func _ready():
	pass

func _process(_float):
	velocity = Vector3.ZERO
	update_animation_params()
	
	# State Machine
	match state_machine.get_current_node():
		"Armature|Idle":
			pass
		"Armature|Walk":
			move_to_player()
		"Armature|Slap":
			attack_player()
	
	move_and_slide()


func update_animation_params():
	detected = target_detected()
	attack_range = target_in_range() if detected else false
	
	anim_tree.set("parameters/conditions/attack", detected && attack_range)
	anim_tree.set("parameters/conditions/walk", detected && !attack_range)
	anim_tree.set("parameters/conditions/idle", !detected || attack_range)
	

func attack_player():
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)

func move_to_player():
	nav_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	look_at(Vector3(global_position.x + velocity.x, global_position.y, player.global_position.z + velocity.z), Vector3.UP)


func get_distance_to_player():
	return global_position.distance_to(player.global_position)

func target_detected():
	distance_to_player = get_distance_to_player()
	return distance_to_player < DETECT_RANGE

func target_in_range():
	return distance_to_player < ATTACK_RANGE


func _enemy_attack():
	if distance_to_player < ATTACK_RANGE + 0.5:
		# player getting hit
		# stagger, screen effect
		pass
	pass

