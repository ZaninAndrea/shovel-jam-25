class_name Chest extends Interactable

@export var key: Item = null
@export var drop: Item = null
@export var consume_key: bool = true
@export var consume_chest: bool = true
@export var drop_offset: Vector2 = Vector2(0, 32)
const DROPPED_ITEM = preload("res://scenes/objects/dropped_item/dropped_item.tscn")

func interact():
	var key_slot = Inventory.find_item(key)
	if key_slot == -1:
		print("You don't have the key")
		return
	
	# Remove the key if needed
	if consume_key:
		Inventory.remove_item(key_slot)

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
