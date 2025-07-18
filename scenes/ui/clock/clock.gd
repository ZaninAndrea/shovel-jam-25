@tool
extends Label

func _ready():
	Clock.clock.connect(update_clock_label)
	
func update_clock_label(hour: int, minute: int, second: int) -> void:
	text = "%02d:%02d:%02d" % [hour, minute, second]
