class_name MainMenu extends Control

@onready var transition_fx = preload("res://audio/vfx/button.mp3")

func _ready() -> void:
	#TODO: Add volume export variable for Music
	AudioManager.play_music_level()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("PlayButton"):
		SceneManager.load_scene("res://scenes/zones/zone1.tscn")

func _on_play_button_up() -> void:
	#TODO: Add volume export variable for FX
	AudioManager.play_fx(transition_fx)
	SceneManager.load_scene("res://scenes/zones/zone1.tscn")

func _on_options_button_button_up() -> void:
	#TODO: Add volume export variable for FX
	AudioManager.play_fx(transition_fx)
	pass # Replace with function body.


func _on_credits_button_button_up() -> void:
	#TODO: Add volume export variable for FX
	AudioManager.play_fx(transition_fx)
	pass # Replace with function body.


func _on_exit_button_up() -> void:
	#TODO: Add volume export variable for FX
	AudioManager.play_fx(transition_fx)
	pass # Replace with function body.
