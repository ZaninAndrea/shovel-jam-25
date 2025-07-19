extends CanvasLayer

@onready var rich_text_label: RichTextLabel = $Control/Sprite2D/RichTextLabel
@onready var interaction_feedback: Label = $Control/InteractionFeedback
@onready var sprite_2d: Sprite2D = $Control/Sprite2D

var hide_timer : Timer = null

func _ready():
	UIManager.set_interaction_ui(self, sprite_2d)
	UIManager.set_feedback_label(rich_text_label)
