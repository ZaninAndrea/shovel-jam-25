extends Area2D

@export var other_room_path: String = ""
@export var door_id: String = ""  # Unique ID for this door (e.g. "engine_entry")
var is_loading_new_scene = false

func _on_body_entered(body: Node2D):
	if not body.is_in_group("player"):
		return

	if other_room_path == "":
		push_warning("No scene assigned to this door.")
		return

	if !is_loading_new_scene:
		is_loading_new_scene = true
		call_deferred("_change_scene_for_body", body)

func _load_other_scene() -> Node:
	if other_room_path.is_empty():
		push_warning("No scene path specified.")
		return null

	var scene_res = load(other_room_path)
	if scene_res is PackedScene:
		return scene_res.instantiate()
	else:
		push_error("Failed to load scene at: %s" % other_room_path)
		return null

func _change_scene_for_body(body):
	var old_scene = get_tree().current_scene
	var new_scene = _load_other_scene()
	if new_scene == null:
		is_loading_new_scene = false		
		return

	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene

	old_scene.queue_free()
	
	var target_door = _find_matching_door(new_scene)
	var player = _find_player(new_scene)
	if target_door and player:
		player.position = target_door.position
	else:
		push_warning("Matching door not found in new scene.")
	
	
	is_loading_new_scene = false

func _find_matching_door(scene: Node) -> Node:
	for node in scene.get_tree().get_nodes_in_group("doors"):
		if node != self and node.door_id == door_id:
			return node
	return null

func _find_player(scene: Node) -> Node:
	for node in scene.get_tree().get_nodes_in_group("player"):
		return node
	return null
	
