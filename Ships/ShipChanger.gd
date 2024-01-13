extends Node3D

var ship_instance

@export var PossibleShipModels: Array[PackedScene]

# Function to change the model of the ship
func change_model():
	var rand_index = randi_range(0, PossibleShipModels.size() - 1)
	var ship_model = PossibleShipModels[rand_index]
	destroy_previous()
	
	ship_instance = ship_model.instantiate()
	add_child(ship_instance)
	get_tree().call_group("Nav", "UpdateNavmesh")
	print("Updated navmesh with new docked ship.")

func destroy_previous():
	if ship_instance:
		ship_instance.queue_free()
