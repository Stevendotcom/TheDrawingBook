extends Control



func _on_texture_button_button_up() -> void:
	$Settings.visible = true


func _on_continue_button_up() -> void:
	self.visible = false


func _on_exit_button_up() -> void:
	pass # Replace with function body.
