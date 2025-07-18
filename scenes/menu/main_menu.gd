extends Control

const SHIP_WITH_TIME_TRAVEL = preload("res://scenes/rooms/ship_with_time_travel/ShipWithTimeTravel.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(SHIP_WITH_TIME_TRAVEL)


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
