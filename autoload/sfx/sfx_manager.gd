class_name SFXManager extends Node

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2
@onready var audio_stream_player_3: AudioStreamPlayer = $AudioStreamPlayer3
@onready var audio_stream_player_4: AudioStreamPlayer = $AudioStreamPlayer4
@onready var audio_stream_player_5: AudioStreamPlayer = $AudioStreamPlayer5
@export var effects: Dictionary[String, AudioStream]
var players = []
var last_used_player = 0

func _ready() -> void:
	players = [
		audio_stream_player,
		audio_stream_player_2,
		audio_stream_player_3,
		audio_stream_player_4,
		audio_stream_player_5
	]

func play(effect: String):
	var next_player_idx = (last_used_player + 1) % len(players)
	players[next_player_idx].stream = effects.get(effect)
	players[next_player_idx].play(0.0)
	last_used_player = next_player_idx

func stop_all():
	for player in players:
		player.stop()
