extends Node3D
class_name RandomShipName

# Generates a random integer between a given range and adds that to a brand name "Exon".
# Number is between 100-1000.
#
# Returns:
#   A name of the ship with a random number suffix e.g., Exon148.
func getShipName():
	var shipName = "Exon"
	var min_value = 100
	var max_value = 1000
	randomize()
	var random_number = randi() % (max_value - min_value + 1) + min_value
	
	return shipName + str(random_number)
