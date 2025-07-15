extends Node

var canvas_layer: CanvasLayer
var feedback_label: Label
var hide_timer: Timer

func _ready():
	# Optional: you can delay setup until feedback_label is assigned
	pass

func set_interaction_ui(canvas: CanvasLayer):
	canvas_layer = canvas
	canvas_layer.visible = false
	hide_timer = Timer.new()
	hide_timer.wait_time = 1.5
	hide_timer.one_shot = true
	hide_timer.timeout.connect(hide_feedback)
	canvas_layer.add_child(hide_timer)

func set_feedback_label(label: Label):
	feedback_label = label

func show_feedback(text: String, duration = 1.5):
	if canvas_layer == null:
		push_warning("UIManager: UI Canvas Layer not assigned!")
		return
	if feedback_label == null:
		push_warning("UIManager: Feedback Label not assigned!")
		return
	canvas_layer.visible = true
	feedback_label.text = text
	hide_timer.wait_time = duration
	hide_timer.start()

func hide_feedback():
	if canvas_layer:
		canvas_layer.visible = false
