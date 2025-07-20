class_name EnigmaCircuit extends Area2D

@onready var sphere: SphereHolder = $"../SphereHolder"
@export var enigma: PackedScene = null

const SPHERE_ACTIVE = preload("res://resources/items/sphere_active.tres")
const SPHERE_INACTIVE = preload("res://resources/items/sphere_inactive.tres")
var enigma_instance: Enigma = null

func interact():
	if enigma == null:
		push_error("Null enigma with locked computer")
		return
	
	if enigma_instance != null:
		return
		
	if sphere.item != SPHERE_INACTIVE:
		SFX.play("boop")
		UIManager.show_feedback("There is no sphere to charge")
		return
	
	var enigma_scene = enigma.instantiate()
	if not enigma_scene is Enigma:
		push_error("Enigma scene does not extend enigma")
	
	enigma_instance = enigma_scene
	get_tree().current_scene.add_child(enigma_instance)
	
	enigma_instance.closed.connect(closed_enigma)
	enigma_instance.solved.connect(solved_enigma)


func closed_enigma():
	enigma_instance.queue_free()
	enigma_instance = null

func solved_enigma():
	enigma_instance.queue_free()
	enigma_instance = null
	# Change the sphere typ to charged
	sphere.item = SPHERE_ACTIVE
