@tool
class_name DroppedItem extends Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var item: Item:
	set(value):
		item = value
		_update_icon()

func _ready():
	_update_icon()

func _update_icon():
	if sprite_2d and item and item.icon:
		sprite_2d.texture = item.icon
		sprite_2d.scale = Vector2.ONE * item.scale
	elif sprite_2d:
		sprite_2d.texture = null

func interact():
	Inventory.set_item(item)
	self.queue_free()
