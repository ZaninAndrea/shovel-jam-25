extends Control
@onready var slot_1: TextureRect = $Slot1
@onready var slot_2: TextureRect = $Slot2
@export var plancia_doppia: Texture2D
@export var plancia_singola: Texture2D
@onready var texture_rect: TextureRect = $TextureRect
@onready var slot_3: TextureRect = $Slot3

func _ready():
	Inventory.item_set.connect(func(a,b): update_slots())
	update_slots()

func update_slots():
	var item1 = Inventory.get_item(1)
	var item2 = Inventory.get_item(2)
	
	if item1 and item1.icon:
		if item1.double_slot:
			texture_rect.texture = plancia_singola
			slot_3.texture = item1.icon
			slot_1.texture = null
		else:
			slot_1.texture = item1.icon
			slot_3.texture = null
			texture_rect.texture = plancia_doppia
	else:
		slot_1.texture = null
		slot_3.texture = null
		texture_rect.texture = plancia_doppia
	
	if item2 and item2.icon:
		slot_2.texture = item2.icon
	else:
		slot_2.texture = null
		
