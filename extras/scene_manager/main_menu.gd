class_name MainMenu extends Control

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("PlayButton"):
		SceneManager.load_scene("res://scenes/zones/zone1.tscn")

func _on_play_button_up() -> void:
	SceneManager.load_scene("res://scenes/zones/zone1.tscn")


func _on_options_button_button_up() -> void:
	pass # Replace with function body.


func _on_credits_button_button_up() -> void:
	pass # Replace with function body.


func _on_exit_button_up() -> void:
	pass # Replace with function body.
