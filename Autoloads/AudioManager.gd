extends AudioStreamPlayer

const game_music = preload("res://audio/music/Devonshire_Waltz_Moderato.mp3")

func _play_music(music: AudioStream, volume = 0.0): 
	if stream == music:
		return
	stream = music
	bus = "Music"
	volume_db = volume
	play()
	
func play_music_level(volume = 0.0):
	_play_music(game_music, volume)
	
func play_fx(stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.bus = "SFX"
	fx_player.name = "FX_Player"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	fx_player.queue_free()
