extends Control

@onready var laser_emitters: Array[Node2D] = [
	$Emitter1/LaserEmitter1,
	$Emitter2/LaserEmitter2,
	$Emitter3/LaserEmitter3,
	$Emitter4/LaserEmitter4,
	$Emitter5/LaserEmitter5,
	$Emitter6/LaserEmitter6,
	$Emitter7/LaserEmitter7,
	$Emitter8/LaserEmitter8,
]

var button_pressed: Array[bool] = [
	false, false, false, false,
	false, false, false, false
]


func _process(_delta: float) -> void:
	var i = 0
	for emitter in laser_emitters:
		if button_pressed[i]:
			emitter.is_active = true
		else:
			emitter.is_active = false
		i += 1


func _on_button_1_pressed() -> void:
	button_pressed[0] = !button_pressed[0]


func _on_button_2_pressed() -> void:
	button_pressed[1] = !button_pressed[1]


func _on_button_3_pressed() -> void:
	button_pressed[2] = !button_pressed[2]


func _on_button_4_pressed() -> void:
	button_pressed[3] = !button_pressed[3]


func _on_button_5_pressed() -> void:
	button_pressed[4] = !button_pressed[4]


func _on_button_6_pressed() -> void:
	button_pressed[5] = !button_pressed[5]


func _on_button_7_pressed() -> void:
	button_pressed[6] = !button_pressed[6]


func _on_button_8_pressed() -> void:
	button_pressed[7] = !button_pressed[7]
