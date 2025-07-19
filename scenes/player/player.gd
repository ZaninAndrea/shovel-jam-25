extends CharacterBody2D
class_name Player

@export var speed := Vector2(150, 400)
@export var push_force := speed / 3

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: Area2D = $InteractionArea
@onready var push_area: Area2D = $PushArea

var bottom_scale: float = 3.0
var top_scale: float = 2.0
var top_position: float = 1.0

var can_push: bool
var push_target: CharacterBody2D = null
var relative : Vector2
var last_facing_direction : float

signal interacted_with(object)
signal item_used(item)

var previous_room_rotation: float = 0.0

func _physics_process(_delta):
	var direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	if InputFreeze.lock_input:
		direction = Vector2.ZERO
	if direction.x > 0.1 || direction.x < -0.1:
		last_facing_direction = direction.x
	
	if direction.length() < 0.1:
		# Reset the input rotation when the player releases the key
		previous_room_rotation = 0.0
	direction = direction.rotated(previous_room_rotation)
	
	# Play animations
	if direction.y < 0 || (direction.y == 0 && direction.x != 0):
		animated_sprite_2d.play("walk_up")
	elif direction.y > 0:
		animated_sprite_2d.play("walk_down")
	else:
		animated_sprite_2d.play("idle")
	
	var is_pushing : bool = can_push and push_target and Input.get_action_strength("push") > 0
	var offset_distance = 35
	
	if !is_pushing && direction.length() > 0:
		relative = direction
	push_area.position = relative * offset_distance
	
	# Scale the player depending on its distance from the camera
	var distance_from_bottom = (540 - get_viewport().get_camera_2d().to_local(global_position).y) / 1080
	if distance_from_bottom > 1:
		distance_from_bottom = 1
	elif distance_from_bottom < -0.3:
		distance_from_bottom = -0.3
	
	var interpolation_coeff = distance_from_bottom / top_position
	var scale_factor: float = interpolation_coeff * top_scale \
		+ (1-interpolation_coeff) * bottom_scale

	scale = Vector2.ONE * scale_factor

	
	if !is_pushing:
		# Flip sprite only if we are not pushing
		if direction.x > 0:
			animated_sprite_2d.flip_h = false
		elif direction.x < 0:
			animated_sprite_2d.flip_h = true
		else:
			#print(last_facing_direction)
			if last_facing_direction > 0:
				animated_sprite_2d.flip_h = true
			elif last_facing_direction < 0:
				animated_sprite_2d.flip_h = false
		velocity = direction * speed * Vector2(scale_factor, 1.0)
		move_and_slide()
	
	# Push logic
	if is_pushing:
		# Don't change facing direction but change movement direction
		velocity = direction * push_force * Vector2(scale_factor, 1.0)
		move_and_slide()
		if direction != Vector2.ZERO:
			var push_dir = direction
			# Force push direction to cardinal
			if abs(direction.x) > abs(direction.y):
				push_dir = Vector2(sign(direction.x), 0)
			else:
				push_dir = Vector2(0, sign(direction.y))
			push_target.push(push_dir * push_force)

func _on_push_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("pushable"):
		push_target = body
		can_push = true


func _on_push_area_body_exited(body: Node2D) -> void:
	if body == push_target:
		push_target = null
		can_push = false


func _input(event):
	if event.is_action_pressed("select_slot_1"): # custom action mapped to key "1"
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
