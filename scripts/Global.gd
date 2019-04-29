extends Node

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func switch_scene_to(path):
	call_deferred("_deferred_switch_scene_to", path)

func _deferred_switch_scene_to(path):
	current_scene.free()
	var new_scene = ResourceLoader.load(path)
	current_scene = new_scene.instance()
	
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)