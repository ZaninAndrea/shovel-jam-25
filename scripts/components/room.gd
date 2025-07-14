class_name Room extends Node

@onready var camera_2d: Camera2D = $Camera2D

func enable():
	camera_2d.make_current()
