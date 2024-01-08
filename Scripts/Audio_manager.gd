extends Node3D

func play_sound(stream, type = "3D", parent = self, pitchscale = 1, volume = -10):
	var audio_player
	match type:
		"3D": audio_player = AudioStreamPlayer3D.new()
		"2D": audio_player = AudioStreamPlayer2D.new()
	audio_player.stream = stream
	audio_player.pitch_scale = pitchscale
	audio_player.volume_db = volume
	parent.add_child(audio_player)
	
	audio_player.play()
	audio_player.finished.connect(func destory(): audio_player.queue_free())
