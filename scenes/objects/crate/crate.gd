extends CharacterBody2D

var external_push := Vector2.ZERO  # Temporary push input from the player

func _physics_process(delta):
	if external_push.length() > 0.1:
		# Only move if there's a push
		velocity = external_push
		move_and_slide()
		
		# Reset push so it doesn't continue moving on its own
		external_push = Vector2.ZERO
	else:
		velocity = Vector2.ZERO  # Stay still when not pushed

func push(force: Vector2):
	# Called by the player to apply a push
	external_push = force
