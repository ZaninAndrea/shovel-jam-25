class_name InventoryManager
extends Node

var items: Array[Item] = [null, null]

signal item_set(item: Item, slot:int)

func set_item(item: Item):
	if item.double_slot:
		# Double slot items overwrite everything
		items[0] = item
		items[1] = null
	elif items[0] == null:
		# If the first slot is free use it
		items[0] = item
	elif items[0].double_slot:
		# If the inventory contained a double slot item replace it
		items[0] = item
	elif items[1] == null:
		# If the second slot is free use it
		items[1] = item
	else:
		# If all slots are used up replace the first slot
		items[0] = item
	
	item_set.emit(items[0], 1)
	item_set.emit(items[1], 2)

func remove_item(slot: int):
	items[slot-1] = null
	item_set.emit(null, slot)

func get_item(slot: int) -> Item:
	if slot <= 0 or slot > 2:
		push_error("Cannot get slot ", slot)
	
	return items[slot-1]
	
func find_item(item: Item) -> int:
	var item_1 = get_item(1)
	var item_2 = get_item(2)
	if item_1 != null and item_1.id == item.id:
		return 1
	elif item_2 !=null and item_2.id == item.id:
		return 2
	else:
		return -1
