extends Enigma

var textures = {
	"char1": preload("res://assets/sprites/Pinpad/Simbolo1_2.png"),
	"char2": preload("res://assets/sprites/Pinpad/Simbolo2_2.png"),
	"char3": preload("res://assets/sprites/Pinpad/Simbolo3_2.png"),
	"char4": preload("res://assets/sprites/Pinpad/Simbolo4_2.png"),
	"char5": preload("res://assets/sprites/Pinpad/Simbolo5_2.png"),
	"char6": preload("res://assets/sprites/Pinpad/Simbolo6_2.png"),
	"char7": preload("res://assets/sprites/Pinpad/Simbolo7_2.png")
}

var solution: Array[String] = [
	"char5",
	"char4",
	"char7",
	"char2"
]

var current_input: Array[String] = []

@onready var slots: Array[TextureRect] = [
	$Slot1,
	$Slot2,
	$Slot3,
	$Slot4
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
		solved.emit()
	else:
		await get_tree().create_timer(0.5).timeout
		for slot in slots:
			slot.texture = null
		current_input = []


func _on_texture_button_pressed() -> void:
	on_button_pressed("char1")
	SFX.play("click")


func _on_texture_button_2_pressed() -> void:
	on_button_pressed("char2")
	SFX.play("click")


func _on_texture_button_3_pressed() -> void:
	on_button_pressed("char3")
	SFX.play("click")


func _on_texture_button_4_pressed() -> void:
	on_button_pressed("char4")
	SFX.play("click")


func _on_texture_button_5_pressed() -> void:
	on_button_pressed("char5")
	SFX.play("click")


func _on_texture_button_6_pressed() -> void:
	on_button_pressed("char6")
	SFX.play("click")


func _on_texture_button_7_pressed() -> void:
	on_button_pressed("char7")
	SFX.play("click")


func _on_back_button_pressed() -> void:
	SFX.play("click")
	closed.emit()


func _on_cancel_pressed() -> void:
	if current_input.size() >= 1:
		SFX.play("click")
		current_input.pop_back()
		slots[current_input.size()].texture = null
