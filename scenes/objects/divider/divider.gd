extends StaticBody2D

@export var key: Item = null
@export var consume_key: bool = false

func interact():
	var key_slot = Inventory.find_item(key)
	if key_slot == -1:
		UIManager.show_feedback("This looks rusty and just about to break")
		return
	
	# Remove the key if needed
	if consume_key:
		Inventory.remove_item(key_slot)

	self.queue_free()
