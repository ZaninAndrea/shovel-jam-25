class_name InventoryManager
extends Node

var items: Array[Item] = [null, null]

signal item_set(item: Item, slot:int)

func set_item(item: Item, slot: int):
	if slot <= 0 or slot > 2:
		push_error("Cannot set slot ", slot)
	
	items[slot-1] = item
	item_set.emit(item, slot)

func get_item(slot: int) -> Item:
	if slot <= 0 or slot > 2:
		push_error("Cannot get slot ", slot)
	
	return items[slot-1]
	
