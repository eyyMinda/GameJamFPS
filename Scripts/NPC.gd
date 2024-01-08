extends Node3D

@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.get_animation("Armature|Idle").loop = true
	animation.play("Armature|Idle")
	
	
