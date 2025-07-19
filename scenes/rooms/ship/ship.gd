class_name Ship extends Node2D
@onready var rooms_container: Node = $Rooms
@export var active_room: int = 0

func _ready():
	var room :Room= rooms_container.get_child(0)
	var player :Player = _find_player()
	
	player.scale = Vector2.ONE
	player.speed = room.speed;
	player.bottom_scale = room.bottom_scale;
	player.top_scale = room.top_scale;
	player.top_position = room.top_position;

	
func _find_player() -> Player:
	for node in get_tree().get_nodes_in_group("player"):
		return node
		
	return null
