@tool class_name MechanicalDoor extends Door

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var door_lock: StaticBody2D = $DoorLock

@export var key: Item = null # Optional key, if set the player must hold the key to pass through the doo
@export_enum("locked", "unlocked", "open") var state: String = "unlocked":
	set(value):
		apply_state(value)
		state = value
@export var sprites: SpriteFrames = null:
	set(value):
		sprites = value
		if animated_sprite_2d != null:
			animated_sprite_2d.sprite_frames = sprites
			animated_sprite_2d.play(state)
			
func _ready() -> void:
	animated_sprite_2d.sprite_frames = sprites
	animated_sprite_2d.play(state)
	apply_state(state)
	
	Inventory.item_set.connect(check_lock_again)

func apply_state(new_state: String):
	# This function may be called before @onready
	if animated_sprite_2d != null:
		animated_sprite_2d.play(new_state)
		
	if door_lock != null:
		if new_state == "open" and state != "open":
			door_lock.position.y -= 30
		elif new_state != "open" and state == "open":
			door_lock.position.y += 30
			
func check_lock_again(a, b):
	if key == null:
		return
		
	if Inventory.find_item(key) == -1:
		state = "locked"
		return


func _on_enter_door_area_body_entered(body: Node2D) -> void:
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
	
	# Move the player over the door

func _on_unlock_door_area_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	
	if state == "unlocked":
		state = "open"

func _on_unlock_door_area_body_exited(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	if state == "open":
		state = "unlocked"

func interact():
	if state == "locked":
		if key == null:
			push_error("Null key with locked door")
			return
		
		if Inventory.find_item(key) == -1:
			SFX.play("boop")
			UIManager.show_feedback("This door is locked", 3)
			return
		
		state = "open"
