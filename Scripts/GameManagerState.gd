extends Node

var visit_count = 0
var is_game_over = false

func _ready():
	pass


func add_visit():
	visit_count += 1
	print("Visit added. Total visits: ", visit_count)
	get_tree().call_group("UsesScore", "updateScore", visit_count)

func reset_visits():
	visit_count = 0
	get_tree().call_group("UsesScore", "updateScore", visit_count)

func game_over():
	is_game_over = true
	get_tree().call_group("UI", "toggle_gameover", true)

func _input(event):
	if is_game_over:
		if event is InputEventKey or event is InputEventMouseButton:
			is_game_over = false
			start_game()
			print("Restart")
			get_tree().call_group("UI", "toggle_gameover", false)

# Function to restart the game
func start_game():
	reset_visits()
	get_tree().call_group("Timer", "ResetTimer")
	get_tree().call_group("Player", "ResetLocation")
	get_tree().call_group("Announcement", "Notify", 4.0, "Home Ship")


