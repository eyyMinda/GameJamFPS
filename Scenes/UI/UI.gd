extends CanvasLayer

@onready var menu = $Menu
@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("music")
@onready var ANNOUNCEMENT_BUS_ID = AudioServer.get_bus_index("announcement")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("sfx")



func _input(event):
	if event.is_action_pressed("exit"):
		menu.visible = !menu.visible


func on_master_slider_change(value):
	change_bus_volume(value, MASTER_BUS_ID)

func on_music_slider_change(value):
	change_bus_volume(value, MUSIC_BUS_ID)

func on_announcement_slider_change(value):
	change_bus_volume(value, ANNOUNCEMENT_BUS_ID)

func on_sfx_slider_change(value):
	change_bus_volume(value, SFX_BUS_ID)

func change_bus_volume(value, bus_id):
	AudioServer.set_bus_volume_db(bus_id, linear_to_db(value))
	AudioServer.set_bus_mute(bus_id, value < 0.025)


func on_fov_slider_change(value):
	pass # Replace with function body.
