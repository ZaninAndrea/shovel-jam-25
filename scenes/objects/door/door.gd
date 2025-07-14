class_name Door extends Area2D

@export var other_door: Door = null
@export var key: Item = null # Optional key, if set the player must hold the key to pass through the doo
@export var exit_shift: Vector2 = Vector2.ZERO
var is_changing_room: bool = false

func _on_body_entered(body: Node2D):
	if is_changing_room:
		return
		
	if not body.is_in_group("player"):
		return

	if key != null and Inventory.find_item(key) == -1:
		print("This door is locked")
		return

	if other_door == null:
		push_warning("No scene assigned to this door.")
		return

	var parent_room = find_parent_room(other_door)
	if parent_room == null:
		push_warning("Other door is not inside a room")
		return
		
	# Enable the new room
	parent_room.enable()
	
	# Move the player to the new room
	is_changing_room = true
	call_deferred("_move_player", body, parent_room)
	
	# Move the player over the door
	
func _move_player(player: Node, new_room: Room):
	player.get_parent().remove_child(player)
	new_room.add_child(player)
	player.global_position = other_door.global_position + other_door.exit_shift
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
