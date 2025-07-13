extends Control
@onready var slot_1: TextureRect = $Slot1
@onready var slot_2: TextureRect = $Slot2

func _ready():
	Inventory.item_set.connect(func(a,b): update_slots())
	update_slots()

func update_slots():
	var item1 = Inventory.get_item(1)
	var item2 = Inventory.get_item(2)
	
	if item1 and item1.icon:
		slot_1.texture = item1.icon
	else:
		slot_1.texture = null
	
	if item2 and item2.icon:
		slot_2.texture = item2.icon
	else:
		slot_2.texture = null
