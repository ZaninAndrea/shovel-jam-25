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

@onready var labels: Array[Label] = [
	$Emitter1/Label1,
	$Emitter2/Label2,
	$Emitter3/Label3,
	$Emitter4/Label4,
	$Emitter5/Label5,
	$Emitter6/Label6,
	$Emitter7/Label7,
	$Emitter8/Label8,
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
	if labels[0].text == "ON":
		labels[0].text = "OFF"
	else:
		labels[0].text = "ON"


func _on_button_2_pressed() -> void:
	button_pressed[1] = !button_pressed[1]
	if labels[1].text == "ON":
		labels[1].text = "OFF"
	else:
		labels[1].text = "ON"


func _on_button_3_pressed() -> void:
	button_pressed[2] = !button_pressed[2]
	if labels[2].text == "ON":
		labels[2].text = "OFF"
	else:
		labels[2].text = "ON"


func _on_button_4_pressed() -> void:
	button_pressed[3] = !button_pressed[3]
	if labels[3].text == "ON":
		labels[3].text = "OFF"
	else:
		labels[3].text = "ON"


func _on_button_5_pressed() -> void:
	button_pressed[4] = !button_pressed[4]
	if labels[4].text == "ON":
		labels[4].text = "OFF"
	else:
		labels[4].text = "ON"


func _on_button_6_pressed() -> void:
	button_pressed[5] = !button_pressed[5]
	if labels[5].text == "ON":
		labels[5].text = "OFF"
	else:
		labels[5].text = "ON"


func _on_button_7_pressed() -> void:
	button_pressed[6] = !button_pressed[6]
	if labels[6].text == "ON":
		labels[6].text = "OFF"
	else:
		labels[6].text = "ON"


func _on_button_8_pressed() -> void:
	button_pressed[7] = !button_pressed[7]
	if labels[7].text == "ON":
		labels[7].text = "OFF"
	else:
		labels[7].text = "ON"


func _on_back_pressed() -> void:
	print("Go back")
