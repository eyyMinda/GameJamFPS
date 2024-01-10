extends CanvasLayer

@onready var menu = $Menu
@onready var panels = {
	"main" = %Main,
	"settings" = %Settings,
	"back" = %Back
}
@onready var start_btn = %Start

@onready var player_hud = $PlayerHUD
@onready var interact_label = %InteractPrompt

@onready var fov_label = %FOVLabel
@onready var fov_slider = %FOVSlider

@onready var bus_ids = {
	"master": AudioServer.get_bus_index("Master"),
	"music": AudioServer.get_bus_index("music"),
	"announcement": AudioServer.get_bus_index("announcement"),
	"sfx": AudioServer.get_bus_index("sfx")
}

func _ready():
	set_interact_prompt("")
	menu_reset()
	player_hud.visible = false

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


# ============== Audio ====================
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


# ============== FOV ====================
func on_fov_slider_change(value):
	fov_label.text = "FOV " + str(value)
	get_tree().get_first_node_in_group("Player").change_fov(value)


# ============== Interact Prompt ====================
func set_interact_prompt(text):
	interact_label.text = text
