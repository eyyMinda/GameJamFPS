extends Timer

enum TimerState { HOME, VISIT, GAME_OVER }
var currentState = TimerState.HOME

var seconds = 0
var minutes = 0

var homeSeconds = 10
var homeMinutes = 0

var visitSeconds = 30
var visitMinutes = 0

@export var tick_sound: AudioStreamWAV

var visitAdded = false
var escapedToHome = true; # for testing, replace with 'player location in home ship?' boolean

func _ready():
	reset_timer()
	start()
	
func _process(_delta):
	if seconds < 0 and minutes <= 0:
		if currentState != TimerState.GAME_OVER:
			if currentState == TimerState.HOME:
				switch_to_state(TimerState.VISIT)
			elif currentState == TimerState.VISIT and escapedToHome:
				switch_to_state(TimerState.HOME)
				get_tree().call_group("AirlockDoor", "lock_airlock")
			else:
				currentState = TimerState.GAME_OVER
				get_tree().call_group("AirlockDoor", "lock_airlock")
				get_tree().call_group("GameState", "game_over")
	elif seconds == visitSeconds and minutes == visitMinutes and not visitAdded:
		visitAdded = true
		get_tree().call_group("GameState", "add_visit")
		get_tree().call_group("Announcement", "Notify", 5.0, "A ship has Docked")
		get_tree().call_group("AirlockDoor", "unlock_airlock")
		get_tree().call_group("DockedModel", "change_model")
	elif not (seconds == visitSeconds and minutes == visitMinutes):
		visitAdded = false

func _on_timeout():
	if currentState != TimerState.GAME_OVER:
		run_timer()
		update_timer_label()

func run_timer():
	if seconds == 0 and minutes > 0:
		minutes -= 1
		seconds = 60
	seconds -= 1
	if seconds <= 10 and seconds >= 0:
		play_tick_sound()

func update_timer_label():
	%TimerLabel.text = "%02d:%02d" % [minutes, seconds]

func play_tick_sound():
	var args = [tick_sound, "2D", get_owner(), randf_range(.9, 1.1), -5]
	get_tree().get_nodes_in_group("Audio")[0].callv("play_sound", args)

func reset_timer():
	if currentState == TimerState.HOME:
		minutes = homeMinutes
		seconds = homeSeconds
	else:
		minutes = visitMinutes
		seconds = visitSeconds
	update_timer_label()

func switch_to_state(newState):
	currentState = newState
	reset_timer()

func ResetTimer():
	switch_to_state(TimerState.HOME)
	
func PlayerisHomeUpdate(state):
	escapedToHome = state
