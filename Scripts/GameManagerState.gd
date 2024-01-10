extends Node

var visit_count = 0
var is_game_over = true
var game_over_hud_scene
var game_over_hud


# Function to increment visit count
func add_visit():
	visit_count += 1
	print("Visit added. Total visits: ", visit_count)
	# Emit signal when a visit is added
	get_tree().call_group("UsesScore", "updateScore", visit_count)
	
func reset_visits():
	visit_count = 0
	# Emit signal when a visit is added
	get_tree().call_group("UsesScore", "updateScore", visit_count)
	
# Function to handle game over
func game_over():
	if is_game_over == false:
		game_over_hud_scene = preload("res://Scenes/UI/GameOverHud.tscn") # Replace with your Game Over HUD scene path
		game_over_hud = game_over_hud_scene.instantiate()
		var HUDVisitCounterLabel = game_over_hud.get_node("HBoxContainer/Survived Visit Count")
		HUDVisitCounterLabel.text = (str(visit_count))
		add_child(game_over_hud)
	is_game_over = true

# Function to restart the game
func restart_game():
	# Reload the current scene (replace 'YourMainScene.tscn' with your main scene file)
	reset_visits()
	is_game_over = false
	if game_over_hud:
		game_over_hud.queue_free()
	get_tree().call_group("Timer", "ResetTimer")
	get_tree().call_group("Player", "ResetLocation")
	get_tree().call_group("Announcement", "Notify", 4.0, "Home Ship")
	# get_tree().call_group("RestartReset", "RestartReset") # Not Used
	#change_scene("res://World.tscn")
	print("Restart")

# Example: Connect signals for adding visits, game over, and restart
func _ready():
	get_tree().call_group("UsesScore", "updateScore", visit_count)
	restart_game()
	pass
	
func _input(event):
	if is_game_over:
		if event is InputEventKey:
			if event.pressed:
				restart_game()

