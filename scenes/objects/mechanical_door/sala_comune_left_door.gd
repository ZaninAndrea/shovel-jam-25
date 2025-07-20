@tool class_name SalaComuneRightDoor extends MechanicalDoor

@export var torch: Item = null

func _on_enter_door_area_body_entered(body: Node2D) -> void:
	if torch == null:
		push_error("Null torch with locked door")
		return
	
	if Inventory.find_item(torch) == -1:
		SFX.play("boop")
		UIManager.show_feedback("This room is too dark, I need a light", 3)
		return
	
	if is_changing_room:
		return
	
	if state != "open":
		return
		
	if not body.is_in_group("player"):
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
