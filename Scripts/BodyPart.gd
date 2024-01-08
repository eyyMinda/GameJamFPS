extends Node
signal body_part_hit

@export var resistance := 80
@onready var part = get_parent().name

	
func hit(damage):
	emit_signal("body_part_hit", damage, resistance, part)
