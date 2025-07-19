class_name Room extends Node

@onready var camera_2d: Camera2D = $Camera2D
@export var speed: Vector2 = Vector2(400,400)
@export var bottom_scale: float = 3.0
@export var top_scale: float= 2.0
@export var top_position: float = 1.0

func enable():
	camera_2d.make_current()
