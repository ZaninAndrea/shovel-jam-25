extends Control

var textures = {
	"char1": preload("res://assets/sprites/Pinpad/char1.png"),
	"char2": preload("res://assets/sprites/Pinpad/char2.png"),
	"char3": preload("res://assets/sprites/Pinpad/char3.png")
}

var solution: Array[String] = [
	"char1",
	"char2",
	"char3",
	"char1"
]

var current_input: Array[String] = []

@onready var slots: Array[TextureRect] = [
	$Display/Slot1,
	$Display/Slot2,
	$Display/Slot3,
	$Display/Slot4
]


func on_button_pressed(character: String):
	if current_input.size() >= 4:
		return
	
	current_input.append(character)
	slots[current_input.size() - 1].texture = textures[character]
	
	if current_input.size() == 4:
		check_password()


func check_password():
	if current_input == solution:
		print("Correct!")
	else:
		print("Wrong!")


func _on_texture_button_pressed() -> void:
	on_button_pressed("char1")


func _on_texture_button_2_pressed() -> void:
	on_button_pressed("char2")


func _on_texture_button_3_pressed() -> void:
	on_button_pressed("char3")
