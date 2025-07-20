@tool
class_name SphereHolder extends Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
const SPHERE_INACTIVE = preload("res://resources/items/sphere_inactive.tres")
@export var target_item: Item = null

signal sphere_change

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

func interact():
	SFX.play("click")
	
	if item != null:
		Inventory.set_item(item)
		UIManager.show_feedback("I collected a " + item.name, 4)
		item = null
	else:
		var sphere_slot := Inventory.find_item(target_item)
		if sphere_slot <= 0:
			if target_item == SPHERE_INACTIVE:
				UIManager.show_feedback("I have no sphere to charge")
			else:
				UIManager.show_feedback("I have no charged sphere to put here")
		else:
			Inventory.remove_item(sphere_slot)
			item = target_item
			
	sphere_change.emit()
