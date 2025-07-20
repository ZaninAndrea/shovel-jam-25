class_name EngineRoom extends Room

@onready var sphere_holder_1: SphereHolder = $SphereHolder1
@onready var sphere_holder_2: SphereHolder = $SphereHolder2
const SPHERE_ACTIVE = preload("res://resources/items/sphere_active.tres")
const END_SCREEN = preload("res://scenes/menu/end_screen.tscn")

func _ready():
	sphere_holder_1.sphere_change.connect(check_victory)
	sphere_holder_2.sphere_change.connect(check_victory)

func enable():
	camera_2d.make_current()

func check_victory():
	if sphere_holder_1.item == SPHERE_ACTIVE and sphere_holder_2.item==SPHERE_ACTIVE:
		await get_tree().create_timer(0.8).timeout
		get_tree().change_scene_to_packed(END_SCREEN)
