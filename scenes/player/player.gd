extends CharacterBody2D
class_name Player

@export var speed := 400
@export var push_force := speed / 3

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var interaction_area: Area2D = $InteractionArea
@onready var push_area: Area2D = $PushArea

var can_push: bool = false
var push_target: CharacterBody2D = null

signal interacted_with(object)
signal item_used(item)

func _physics_process(delta):
	var direction  = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	velocity = direction  * speed
	move_and_slide()
	
	# Flip sprite
	if velocity.x > 0:
		sprite_2d.flip_h = true
	elif velocity.x < 0:
		sprite_2d.flip_h = false
	
	# Flip push area so that it is in front
	var offset_distance = 35
	push_area.position = direction * offset_distance
	
	# Push logic
	if can_push and push_target and Input.is_action_pressed("push"):
		if direction != Vector2.ZERO:
			var push_dir = direction
			# Force push direction to cardinal
			if abs(direction.x) > abs(direction.y):
				push_dir = Vector2(sign(direction.x), 0)
			else:
				push_dir = Vector2(0, sign(direction.y))
			push_target.push(push_dir  * push_force)


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
		print("pressed 1")
		var overlapping_areas = interaction_area.get_overlapping_areas()
		for area in overlapping_areas:
			if area is Interactable:
				area.interact()
				
		var overlapping_bodies = interaction_area.get_overlapping_bodies()
		for body in overlapping_bodies:
			if body is Interactable:
				body.interact()
		
		if (len(overlapping_bodies) + len(overlapping_areas) == 0):
			UIManager.show_feedback("There is nothing here.", 3)
