extends Node3D

var sound_types = {
	"music": Callable(AudioStreamPlayer2D, "new"),
	"announcement": Callable(AudioStreamPlayer2D, "new"),
	"sfx": Callable(AudioStreamPlayer3D, "new")
}

func _ready(): pass

func play_sound(stream, sound_type = "sfx", parent = self, pitchscale = 1.0, volume = 0.0):
	var audio_player = find_audio_stream_player(parent, stream)
	
	if audio_player: audio_player.stop()
	else:
		audio_player = sound_types[sound_type].call()
		parent.add_child(audio_player)
		audio_player.finished.connect(func destory(): audio_player.queue_free())

	audio_player.stream = stream
	audio_player.pitch_scale = pitchscale
	audio_player.bus = sound_type
	audio_player.volume_db = volume
	audio_player.play()


func find_audio_stream_player(parent, stream):
	for child in parent.get_children():
		if child is AudioStreamPlayer2D or child is AudioStreamPlayer3D:
			if child.stream == stream: return child
	return null

func on_music_player_finished():
	$MusicPlayer.play()
