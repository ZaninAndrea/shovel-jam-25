extends Control

const SHIP_WITH_TIME_TRAVEL = preload("res://scenes/rooms/ship_with_time_travel/ShipWithTimeTravel.tscn")

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var spaceship: Sprite2D = $Spaceship

@export var swing_amplitude := Vector2(40, 20)  # How wide/tall the motion is
@export var speed := 1.0  # Speed of motion

var time := 0.0
var base_position := Vector2.ZERO

func _ready() -> void:
	base_position = spaceship.position  # Save the original position
	audio_stream_player.play()
	
func _process(delta):
	time += delta * speed
	var x = sin(time) * swing_amplitude.x
	var y = sin(time * 2) * swing_amplitude.y  # Double frequency = figure eight
	spaceship.position = base_position + Vector2(x, y)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(SHIP_WITH_TIME_TRAVEL)


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
