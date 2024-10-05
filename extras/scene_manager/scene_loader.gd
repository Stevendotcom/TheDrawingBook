class_name SceneLoader extends Node

signal player_entered_trigger(scene_loader:SceneLoader,transition_type:String)

@export_enum("north","east","west","south") var entry_direction
@export_enum("fade_to_black","wipe_to_right", "wipe_to_left", "wipe") var transition_type:String
@export var path_to_new_scene:String
var is_enabled:bool = true

func _on_left_click() -> void:
	if not is_enabled:
		return
		
	player_entered_trigger.emit(self)
	if transition_type == "wipe":
		SceneManager.load_level_wipe(path_to_new_scene)
	else:
		SceneManager.load_scene(path_to_new_scene, transition_type)
		
	is_enabled = false
	queue_free()

func get_move_dir() -> Vector2:
	var dir:Vector2 = Vector2.DOWN
	match entry_direction:
		0:
			dir = Vector2.UP
		1:
			dir = Vector2.RIGHT
		2:
			dir = Vector2.LEFT
	return dir
