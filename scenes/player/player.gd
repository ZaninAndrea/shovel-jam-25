extends CharacterBody2D
class_name Player

@export var speed := 200
@export var push_force := 50.0

@onready var sprite := $Sprite2D
@onready var interaction_area := $InteractionArea

var can_push: bool = false
var push_target: CharacterBody2D = null

signal interacted_with(object)
signal item_used(item)

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	velocity = input_vector * speed
	move_and_slide()
	
	if velocity.length() > 0:
		rotation = velocity.angle()
	
	# Push logic
	if can_push and push_target and Input.is_action_pressed("push"):
		if input_vector != Vector2.ZERO:
			push_target.push(input_vector * push_force)


func _on_push_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("pushable"):
		push_target = body
		can_push = true


func _on_push_area_body_exited(body: Node2D) -> void:
	if body == push_target:
		push_target = null
		can_push = false
	rotation = velocity.angle()

func _input(event):
	if event.is_action_pressed("select_slot_1"): # custom action mapped to key "1"
		var overlapping = interaction_area.get_overlapping_areas()
		for area in overlapping:
			if area is DroppedItem:
				Inventory.set_item(area.item, 1)
				area.queue_free()
