extends Node

var canvas_layer: CanvasLayer
var sprite: Sprite2D 
var feedback_label: RichTextLabel
var hide_timer: Timer

func _ready():
	pass

func set_interaction_ui(canvas: CanvasLayer, sprite2d: Sprite2D):
	canvas_layer = canvas
	sprite = sprite2d
	canvas_layer.visible = false
	
	hide_timer = Timer.new()
	hide_timer.wait_time = 1.5
	hide_timer.one_shot = true
	hide_timer.timeout.connect(_on_hide_timer_timeout)
	canvas_layer.add_child(hide_timer)

func set_feedback_label(label: RichTextLabel):
	feedback_label = label

func show_feedback(text: String, duration = 1.5):
	if canvas_layer == null:
		push_warning("UIManager: UI Canvas Layer not assigned!")
		return
	if feedback_label == null:
		push_warning("UIManager: Feedback Label not assigned!")
	
	canvas_layer.visible = true
	sprite.modulate.a = 1
	feedback_label.modulate.a = 1
	feedback_label.text = text
	
	hide_timer.wait_time = duration
	hide_timer.start()

func _on_hide_timer_timeout():
	var sprite_tween = create_tween()
	sprite_tween.tween_property(
		sprite,
		"modulate:a",
		0.0,
		0.5
	)
	var label_tween = create_tween()
	label_tween.tween_property(
		feedback_label,
		"modulate:a",
		0.0,
		0.5
	)
	await sprite_tween.finished
	await label_tween.finished
	_on_fade_finished()

func _on_fade_finished():
	if canvas_layer:
		canvas_layer.visible = false
