extends Node2D

@export_range(1,180,1,"suffix:s") var time_between_travels: int = 30
@onready var sub_viewport: SubViewport = $SubViewport
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var warped_view: Sprite2D = $WarpedView
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var noise_player: AudioStreamPlayer = $NoisePlayer

@export var time_travelling: bool = false

func _ready():
	audio_stream_player.play()
	get_tree().create_timer(time_between_travels).timeout.connect(start_reset_sequence)

	var has_player_warp_animation = (warped_view.material as ShaderMaterial).get_shader_parameter("time") != 0
	if has_player_warp_animation:
		noise_player.play()
		Clock.reset()
		animation_player.play("after_reset")
		
	
func start_reset_sequence():
	InputFreeze.lock_input = true
	animation_player.play("before_reset")

func end_reset_sequence():
	print("END")
	InputFreeze.lock_input = false
	
func reset_time():
	get_tree().reload_current_scene()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("skip_time"):
		start_reset_sequence()
	elif not InputFreeze.lock_input:
		sub_viewport.push_input(event)
