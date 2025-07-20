extends Control

@onready var spaceship: Sprite2D = $Spaceship

@export var swing_amplitude := Vector2(40, 20)  # How wide/tall the motion is
@export var speed := 1.0  # Speed of motion

var time := 0.0
var base_position := Vector2.ZERO


func _ready() -> void:
	base_position = spaceship.position  # Save the original position


func _process(delta):
	time += delta * speed
	var x = sin(time) * swing_amplitude.x
	var y = sin(time * 2) * swing_amplitude.y  # Double frequency = figure eight
	spaceship.position = base_position + Vector2(x, y)
