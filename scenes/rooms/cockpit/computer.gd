class_name Computer extends Area2D

@export var badge: Item = null
@export var active_badge: Item = null
@export var enigma: PackedScene = null
@export_enum("locked", "unlocked") var state: String = "locked"
var enigma_instance: Enigma = null

func interact():
	if state == "locked":
		if enigma == null:
			push_error("Null enigma with locked computer")
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
	
	else:
		# If it is unlocked, activate the badge
		var badge_position = Inventory.find_item(badge)
		if badge_position <= 0:
			UIManager.show_feedback("The main computer can be used to activate a badge.")
		else:
			Inventory.remove_item(badge_position)
			Inventory.set_item(active_badge)
			UIManager.show_feedback("The main computer activated my badge!")
		return

func closed_enigma():
	enigma_instance.queue_free()
	enigma_instance = null

func solved_enigma():
	state = "unlocked"
	enigma_instance.queue_free()
	enigma_instance = null
	# On enigma solution, directly activate the badge
	var badge_position = Inventory.find_item(badge)
	if badge_position > 0:
		Inventory.remove_item(badge_position)
		Inventory.set_item(active_badge)
		UIManager.show_feedback("The main computer activated my badge!")
