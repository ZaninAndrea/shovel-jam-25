class_name InventoryManager
extends Node

var items: Array[Item] = [null, null]

signal item_set(item: Item, slot:int)

func set_item(item: Item, slot: int):
	if slot <= 0 or slot > 2:
		push_error("Cannot set slot ", slot)
	
	items[slot-1] = item
	item_set.emit(item, slot)

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
