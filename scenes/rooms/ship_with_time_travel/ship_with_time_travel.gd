extends Node2D

@export_range(1,180,1,"suffix:s") var time_between_travels: int = 30
@onready var sub_viewport: SubViewport = $SubViewport
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var warped_view: Sprite2D = $WarpedView

func _ready():
	get_tree().create_timer(time_between_travels).timeout.connect(start_reset_sequence)

	var has_player_warp_animation = (warped_view.material as ShaderMaterial).get_shader_parameter("time") != 0
	if has_player_warp_animation:
		animation_player.play("after_reset")
		
	
func start_reset_sequence():
	animation_player.play("before_reset")
	
func reset_time():
	get_tree().reload_current_scene()

func _input(event: InputEvent) -> void:
	sub_viewport.push_input(event)
