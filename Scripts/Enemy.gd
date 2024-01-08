extends CharacterBody3D 

var player = null
var state_machine

const SPEED = 3.4
const ATTACK_RANGE = 1.5

@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree = $AnimationTree
@onready var anim_player = $Model/AnimationPlayer

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	state_machine = anim_tree.get("parameters/playback")
	
func _process(_float):
	velocity = Vector3.ZERO
	
	# State Machine
	match state_machine.get_current_node():
		"Armature|Walk":
			# Navigation
			nav_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = nav_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			look_at(Vector3(global_position.x + velocity.x, global_position.y, player.global_position.z + velocity.z), Vector3.UP)
			pass
		"Armature|Slap":
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
			pass

	# Conditions
	anim_tree.set("parameters/conditions/attack", _target_in_range())
	anim_tree.set("parameters/conditions/run", !_target_in_range())
	
	move_and_slide()
	
func _target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE
	
func _enemy_attack():
	if global_position.distance_to(player.global_position) < ATTACK_RANGE + 0.5:
		# player getting hit
		# stagger, screen effect
		pass
	pass
