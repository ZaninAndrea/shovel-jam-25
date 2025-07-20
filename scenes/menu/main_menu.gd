extends Control

const SHIP_WITH_TIME_TRAVEL = preload("res://scenes/rooms/ship_with_time_travel/ShipWithTimeTravel.tscn")

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var spaceship: Sprite2D = $Spaceship
@onready var title: Label = $Title
@onready var menu: Control = $Menu
@onready var settings_menu: Control = $SettingsMenu

@export var swing_amplitude := Vector2(40, 20)  # How wide/tall the motion is
@export var speed := 1.0  # Speed of motion

var time := 0.0
var base_position := Vector2.ZERO

var master_bus
var music_bus
var sfx_bus


func _ready() -> void:
	base_position = spaceship.position  # Save the original position
	
	# Set audio
	master_bus = AudioServer.get_bus_index("Master")
	music_bus = AudioServer.get_bus_index("Soundtrack")
	sfx_bus = AudioServer.get_bus_index("Effects")
	default_volume()
	
	# Play music
	audio_stream_player.play()


func _process(delta):
	time += delta * speed
	var x = sin(time) * swing_amplitude.x
	var y = sin(time * 2) * swing_amplitude.y  # Double frequency = figure eight
	spaceship.position = base_position + Vector2(x, y)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(SHIP_WITH_TIME_TRAVEL)


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	menu.hide()
	title.hide()
	spaceship.hide()
	settings_menu.show()
	
	%MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus))
	%MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))
	%SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus))


func _on_close_settings_pressed() -> void:
	menu.show()
	title.show()
	spaceship.show()
	settings_menu.hide()


# AUDIO SETTINGS ----

func default_volume() -> void:
	%MasterSlider.value = 0.5
	%MusicSlider.value = 1
	%SFXSlider.value = 0.3

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		master_bus,
		linear_to_db(value)
	)

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		music_bus,
		linear_to_db(value)
	)

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		sfx_bus,
		linear_to_db(value)
	)
