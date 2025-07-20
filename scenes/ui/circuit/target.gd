extends CharacterBody2D

@onready var target_sprite: Sprite2D = $TargetSprite

var laser_count := 0


func register_laser_hit():
	laser_count += 1
	check_laser_state()


func unregister_laser_hit():
	laser_count = max(laser_count - 1, 0)
	check_laser_state()


func check_laser_state():
	if laser_count == 1:
		print("You Win")
		target_sprite.visible == true
