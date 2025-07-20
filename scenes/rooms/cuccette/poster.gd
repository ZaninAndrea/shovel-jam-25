extends Area2D

@export var poster: PackedScene = null
var poster_instance: Enigma = null

func interact():
	var poster_scene = poster.instantiate()
	poster_instance = poster_scene
	get_tree().current_scene.add_child(poster_instance)
	poster_instance.closed.connect(closed_poster)


func closed_poster():
	poster_instance.queue_free()
	poster_instance = null
