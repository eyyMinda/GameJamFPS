extends CanvasLayer

@onready var menu = $Menu
@onready var panels = {
	"main" = %Main,
	"settings" = %Settings,
	"back" = %Back
}
@onready var start_btn = %Start

@onready var player_hud = $PlayerHUD
@onready var crosshair = %Crosshair
@onready var interact_label = %InteractPrompt

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var fov_label = %FOVLabel
@onready var fov_slider = %FOVSlider

@onready var gameover = $GameOver

@onready var bus_ids = {
	"master": AudioServer.get_bus_index("Master"),
	"music": AudioServer.get_bus_index("music"),
	"announcement": AudioServer.get_bus_index("announcement"),
	"sfx": AudioServer.get_bus_index("sfx")
}

func _ready():
	set_interact_prompt("")
	menu_reset()
	menu.visible = true
	player_hud.visible = false
	gameover.visible = false

# ============== Menu Navigation ====================
func _input(event):
	if event.is_action_pressed("exit"):
		if start_btn.text == "Start":
			start_btn.text = "Continue"
		player_hud.visible = menu.visible
		menu.visible = !menu.visible
		menu_reset()
		

func _on_start_pressed():
	menu.visible = false
	player_hud.visible = true
	if start_btn.text == "Start":
		get_tree().call_group("GameState", "start_game")

func _on_settings_pressed():
	toggle_menu_panel("settings", "back")

func on_back_button_pressed():
	menu_reset()

func _on_exit_pressed():
	get_tree().quit()

func menu_reset():
	toggle_menu_panel("main")
	fov_label.text = "FOV " + str(fov_slider.value)

func toggle_menu_panel(panel, second = null):
	for key in panels:
		panels[key].visible = key == panel || key == second


# ============== Audio Settings ====================
func on_master_slider_change(value):
	change_bus_volume(value, bus_ids.master)

func on_music_slider_change(value):
	change_bus_volume(value, bus_ids.music)

func on_announcement_slider_change(value):
	change_bus_volume(value, bus_ids.announcement)

func on_sfx_slider_change(value):
	change_bus_volume(value, bus_ids.sfx)

func change_bus_volume(value, bus_id):
	AudioServer.set_bus_volume_db(bus_id, linear_to_db(value))
	AudioServer.set_bus_mute(bus_id, value < 0.025)


# ============== Game Settings ====================
func on_fov_slider_change(value):
	fov_label.text = "FOV " + str(value)
	player.change_fov(value)

func _on_head_bob_toggled(toggled_on): player.toggle_headbob(toggled_on)
func _on_crosshair_toggled(toggled_on): crosshair.visible = toggled_on

# ============== Interact Prompt ====================
func set_interact_prompt(text):
	interact_label.text = text


# ============== Gameover HUD ====================
func toggle_gameover(val): gameover.visible = val
