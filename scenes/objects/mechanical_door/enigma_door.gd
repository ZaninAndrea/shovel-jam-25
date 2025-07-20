@tool class_name EnigmaDoor extends MechanicalDoor

@export var enigma: PackedScene = null
var enigma_instance: Enigma = null

func interact():
	if state == "locked":
		if enigma == null:
			push_error("Null enigma with locked door")
			return
		
		if enigma_instance != null:
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
	state = "open"
	other_door.state = "unlocked"
	enigma_instance.queue_free()
	enigma_instance = null
