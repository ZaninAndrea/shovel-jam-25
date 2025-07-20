extends CharacterBody2D

var laser_count := 0

signal solved


func register_laser_hit():
	laser_count += 1
	check_laser_state()


func unregister_laser_hit():
	laser_count = max(laser_count - 1, 0)
	check_laser_state()


func check_laser_state():
	if laser_count == 1:
		%TargetSprite.show()
		# Delay a couple of seconds
		await get_tree().create_timer(0.5).timeout
		solved.emit()
