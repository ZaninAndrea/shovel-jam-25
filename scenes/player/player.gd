extends CharacterBody2D
class_name Player

@export var speed := 200
@onready var sprite := $Sprite2D
@onready var interaction_area := $InteractionArea

var facing_dir := Vector2.RIGHT

signal interacted_with(object)
signal item_used(item)

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	velocity = input_vector * speed
	facing_dir = input_vector if input_vector.length() > 0 else facing_dir
	move_and_slide()
	
	rotation = velocity.angle()
