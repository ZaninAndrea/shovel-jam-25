class_name Ship extends Node2D
@onready var rooms_container: Node = $Rooms
@export var active_room: int = 0

func _ready():
	rooms_container

func _input(event):
	if event.is_action_pressed("ui_select"):
		active_room = (active_room + 1) % rooms_container.get_child_count()
		rooms_container.get_child(active_room).find_child("Camera2D").make_current()
