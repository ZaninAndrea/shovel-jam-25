class_name InvisibleDoor extends Door

@export var key: Item = null # Optional key, if set the player must hold the key to pass through the doo

func _on_body_entered(body: Node2D):
	if is_changing_room:
		return
		
	if not body.is_in_group("player"):
		return

	if key != null and Inventory.find_item(key) == -1:
		return

	if other_door == null:
		push_warning("No scene assigned to this door.")
		return

	var starting_room = find_parent_room(self)
	if starting_room == null:
		push_warning("This door is not inside a room")
		return
	
	var parent_room = find_parent_room(other_door)
	if parent_room == null:
		push_warning("Other door is not inside a room")
		return
		
	# Enable the new room
	parent_room.enable()
	
	# Move the player to the new room
	is_changing_room = true
	call_deferred("_move_player", body, starting_room, parent_room)
