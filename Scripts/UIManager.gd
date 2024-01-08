extends Node

@onready var prompt := $Prompt

func _on_interact_ray_raycast_hit(value):
	prompt.set_text(value)
