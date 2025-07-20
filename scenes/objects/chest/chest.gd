class_name Chest extends CharacterBody2D

@export var key: Item = null
@export var drop: Item = null
@export var consume_key: bool = true
@export var consume_chest: bool = true
@export var drop_offset: Vector2 = Vector2(0, 32)
const DROPPED_ITEM = preload("res://scenes/objects/dropped_item/dropped_item.tscn")

var external_push := Vector2.ZERO # Temporary push input from the player

func _physics_process(delta):
	if external_push.length() > 0.1:
		# Only move if there's a push
		velocity = external_push
		move_and_slide()
		
		# Reset push so it doesn't continue moving on its own
		external_push = Vector2.ZERO
	else:
		velocity = Vector2.ZERO # Stay still when not pushed

func push(force: Vector2):
	# Called by the player to apply a push
	external_push = force


func interact():
	var key_slot = Inventory.find_item(key)
	if key_slot == -1:
		SFX.play("boop")
		UIManager.show_feedback("I need something to open this chest", 4.0)
		return
	
	# Remove the key if needed
	if consume_key:
		Inventory.remove_item(key_slot)

	SFX.play("click")

	# Spawn the dropped item
	if drop:
		var dropped = DROPPED_ITEM.instantiate()
		dropped.item = drop
		get_parent().add_child(dropped)
		dropped.global_position = self.global_position + drop_offset
		print("Dropped item spawned at ", dropped.global_position)

	#	Remove the checst if needed
	if consume_chest:
		self.queue_free()
