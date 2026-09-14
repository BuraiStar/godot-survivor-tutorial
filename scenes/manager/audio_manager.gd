extends Node

var players: Array[AudioStreamPlayer2D] = []


func play_2d(
	stream: AudioStream,
	volume_db: float = 0.0
):
	if stream == null:
		return
	

	var player := _get_available_player()
	
	player.stream = stream
	player.volume_db = volume_db
	player.play()


func _get_available_player() -> AudioStreamPlayer2D:
	# Look for an unused player
	for player in players:
		if not player.playing:
			return player

	# No available player, create one
	var new_player := AudioStreamPlayer2D.new()
	add_child(new_player)
	players.append(new_player)

	return new_player
