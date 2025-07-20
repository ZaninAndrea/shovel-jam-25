class_name Door extends Node

@export var other_door: Door = null
@export var exit_shift: Vector2 = Vector2.ZERO
var is_changing_room: bool = false
	
func _move_player(player: Player, starting_room: Room, new_room: Room):
	# Update player
	player.get_parent().remove_child(player)
	new_room.add_child(player)
	player.scale = Vector2.ONE
	player.global_position = other_door.global_position + other_door.exit_shift
	player.speed = new_room.speed;
	player.bottom_scale = new_room.bottom_scale;
	player.top_scale = new_room.top_scale;
	player.top_position = new_room.top_position;
	player.previous_room_rotation = new_room.movement_rotation - starting_room.movement_rotation
	
	# Update other door
	if other_door is MechanicalDoor:
		other_door.state = "open"
	
	is_changing_room = false
	
func _find_player() -> Node:
	for node in get_tree().get_nodes_in_group("player"):
		return node
		
	return null
	
func find_parent_room(node: Node) -> Room:
	while node != null:
		if node is Room:
			return node
		
		node = node.get_parent()

	return null
