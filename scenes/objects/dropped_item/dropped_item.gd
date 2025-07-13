@tool
class_name DroppedItem extends Node2D
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
	elif sprite_2d:
		sprite_2d.texture = null
