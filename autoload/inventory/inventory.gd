class_name InventoryManager
extends Node

var items: Array[Item] = [null, null]

signal item_set(item: Item, slot:int)
const DROPPED_ITEM = preload("res://scenes/objects/dropped_item/dropped_item.tscn")

func set_item(item: Item):
	if item.double_slot:
		if items[0] != null:
			drop_item(items[0], 1)
		if items[1] != null:
			drop_item(items[1], 2)
		
		# Double slot items overwrite everything
		items[0] = item
		items[1] = null
	elif items[0] == null:
		# If the first slot is free use it
		items[0] = item
	elif items[0].double_slot:
		drop_item(items[0], 1)
		
		# If the inventory contained a double slot item replace it
		items[0] = item
	elif items[1] == null:
		# If the second slot is free use it
		items[1] = item
	else:
		drop_item(items[0], 1)
		# If all slots push the first item out of the queue
		items[0] = items[1]
		items[1] = item
	
	item_set.emit(items[0], 1)
	item_set.emit(items[1], 2)
	
func drop_item(item: Item, slot: int):
	var player = _find_player()
	
	var drop = DROPPED_ITEM.instantiate()
	player.get_parent().add_child(drop)
	drop.global_position = player.global_position + Vector2((slot - 1.5)*200, 0)

	drop.item = item
	
func _find_player() -> Player:
	for node in get_tree().get_nodes_in_group("player"):
		return node
		
	return null

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
