extends CanvasLayer

@onready var interaction_feedback: Label = $Control/InteractionFeedback
@onready var sprite_2d: Sprite2D = $Control/Sprite2D

var hide_timer : Timer = null

func _ready():
	UIManager.set_interaction_ui(self)
	UIManager.set_feedback_label(interaction_feedback)
