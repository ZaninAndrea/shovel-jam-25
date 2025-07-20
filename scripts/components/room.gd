class_name Room extends Node

@onready var chest_2: Chest = $Chest2
@onready var camera_2d: Camera2D = $Camera2D
@onready var poster: Area2D = $Poster

@export var speed: Vector2 = Vector2(150,400)
@export var bottom_scale: float = 3.0
@export var top_scale: float= 2.0
@export var top_position: float = 1.0
@export_range(-360, 360, 1, "radians_as_degrees") var movement_rotation: float = 0.0


func enable():
	camera_2d.make_current()


func _process(delta: float) -> void:
	if chest_2 == null:
		if poster:
			poster.show()
