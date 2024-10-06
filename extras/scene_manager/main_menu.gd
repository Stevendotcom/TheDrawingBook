class_name MainMenu extends Control

@onready var play_button: TextureButton = $BoxContainer/HBoxContainer/Buttons/PlayButton
@onready var options_button: TextureButton = $BoxContainer/HBoxContainer/Buttons/OptionsButton
@onready var credits_button: TextureButton = $BoxContainer/HBoxContainer/Buttons/CreditsButton
@onready var exit: TextureButton = $BoxContainer/HBoxContainer/Buttons/Exit
const scale_factor: float = 0.1

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("PlayButton"):
		SceneManager.load_scene("res://scenes/zones/zone1.tscn")


#PLAY
func _on_play_button_up() -> void:
	SceneManager.load_scene("res://scenes/zones/zone1.tscn")

func _on_play_button_mouse_entered() -> void:
	_upscale(play_button)

func _on_play_button_mouse_exited() -> void:
	_downscale(play_button)



#OPTIONS
func _on_options_button_button_up() -> void:
	pass # Replace with function body.

func _on_options_button_mouse_entered() -> void:
	_upscale(options_button)

func _on_options_button_mouse_exited() -> void:
	_downscale(options_button)



#CREDITS
func _on_credits_button_button_up() -> void:
	pass # Replace with function body.

func _on_credits_button_mouse_entered() -> void:
	_upscale(credits_button)

func _on_credits_button_mouse_exited() -> void:
	_downscale(credits_button)



#EXIT
func _on_exit_button_up() -> void:
	get_tree().quit()

func _on_exit_mouse_entered() -> void:
	_upscale(exit)

func _on_exit_mouse_exited() -> void:
	_downscale(exit)



func _upscale(button: TextureButton) -> void:
	
	button.scale = Vector2(scale_factor + 1,scale_factor + 1)
	button.position = Vector2(button.position.x - (button.size.x * (1 + scale_factor) - button.size.x)/2, button.position.y - (button.size.y * (1 + scale_factor) - button.size.y)/2)

func _downscale(button: TextureButton) -> void:
	button.scale = Vector2(1,1)	
	button.position = Vector2(button.position.x + (button.size.x - button.size.x * (1 - scale_factor))/2, button.position.y + (button.size.y - button.size.y * (1 - scale_factor))/2)
