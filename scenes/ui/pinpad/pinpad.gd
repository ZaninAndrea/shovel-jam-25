extends Enigma

var textures = {
	"char1": preload("res://assets/sprites/Pinpad/Simbolo1.png"),
	"char2": preload("res://assets/sprites/Pinpad/Simbolo2.png"),
	"char3": preload("res://assets/sprites/Pinpad/Simbolo3.png"),
	"char4": preload("res://assets/sprites/Pinpad/Simbolo4.png"),
	"char5": preload("res://assets/sprites/Pinpad/Simbolo5.png"),
	"char6": preload("res://assets/sprites/Pinpad/Simbolo6.png"),
	"char7": preload("res://assets/sprites/Pinpad/Simbolo7.png")
}

var solution: Array[String] = [
	"char1",
	"char2",
	"char3",
	"char1"
]

var current_input: Array[String] = []

@onready var slots: Array[TextureRect] = [
	$Slot1,
	$Slot2,
	$Slot3,
	$Slot4
]


func on_button_pressed(character: String):
	print(character)
	if current_input.size() >= 4:
		return
	
	current_input.append(character)
	slots[current_input.size() - 1].texture = textures[character]
	
	if current_input.size() == 4:
		check_password()


func check_password():
	if current_input == solution:
		print("Solved")
		solved.emit()
	else:
		print("Wrong!")
		await get_tree().create_timer(0.5).timeout
		for slot in slots:
			slot.texture = null
		current_input = []


func _on_texture_button_pressed() -> void:
	on_button_pressed("char1")


func _on_texture_button_2_pressed() -> void:
	on_button_pressed("char2")


func _on_texture_button_3_pressed() -> void:
	on_button_pressed("char3")


func _on_texture_button_4_pressed() -> void:
	on_button_pressed("char4")


func _on_texture_button_5_pressed() -> void:
	on_button_pressed("char5")


func _on_texture_button_6_pressed() -> void:
	on_button_pressed("char6")


func _on_texture_button_7_pressed() -> void:
	on_button_pressed("char7")


func _on_back_button_pressed() -> void:
	closed.emit()


func _on_cancel_pressed() -> void:
	if current_input.size() >= 1:
		current_input.pop_back()
		slots[current_input.size()].texture = null
