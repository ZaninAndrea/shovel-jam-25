extends CharacterBody2D

@onready var laser_emitter: Node2D = $LaserEmitter

var laser_count := 0

func _ready() -> void:
	check_laser_state()

func register_laser_hit():
	laser_count += 1
	check_laser_state()


func unregister_laser_hit():
	laser_count = max(laser_count - 1, 0)
	check_laser_state()


func check_laser_state():
	if laser_count == 0:
		laser_emitter.is_active = true
	else:
		laser_emitter.is_active = false
