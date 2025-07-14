extends Node2D

@export var max_bounces := 5
@export var max_distance := 1000.0
@onready var beam: Line2D = $LaserBeam

func _process(_delta):
	cast_laser(global_position, global_rotation)

func cast_laser(start_pos: Vector2, angle: float):
	var points = [start_pos]
	var current_origin = start_pos
	var current_dir = Vector2.RIGHT.rotated(angle)
	var remaining_bounces = max_bounces
	
	while remaining_bounces > 0:
		var space_state = get_world_2d().direct_space_state
		var query := PhysicsRayQueryParameters2D.create(current_origin, current_origin + current_dir * max_distance)
		query.collision_mask = 1  # Make sure this matches the layers of what it should hit
		var result = space_state.intersect_ray(query)
		
		if result:
			var hit_pos = result.position
			var normal = result.normal
			var collider = result.collider
			points.append(hit_pos)
			if collider.is_in_group("mirror"):
				current_origin = hit_pos
				current_dir = current_dir.bounce(normal)
				remaining_bounces -= 1
			else:
				# Hit target or wall
				if collider.is_in_group("laser_target"):
					collider.call("on_laser_hit")
				break
		else:
			# No hit — laser goes off into the void
			points.append(current_origin + current_dir * max_distance)
			break
	
	beam.points = points
