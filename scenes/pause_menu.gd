extends Control



func _on_texture_button_button_up() -> void:
	$Settings.visible = true


func _on_continue_button_up() -> void:
	self.visible = false
	get_tree().paused = false


func _on_exit_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
