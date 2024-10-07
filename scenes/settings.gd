extends Control

@onready var settings: Control = $"."
@onready var h_separator: HSeparator = $VBoxContainer/HSeparator



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Funcion que calcule el procentaje de pixeles de margen superior
	pass
	
func _on_full_screen_pressed() -> void:
	print("FullScreen pressed")
	SettingsManager.fullscreen = true
	SettingsManager.update_settings()

func _on_window_mode_pressed() -> void:
	print("WindowMode pressed")
	SettingsManager.fullscreen = false
	SettingsManager.update_settings()

func _on_volume_slider_value_changed(value: float) -> void:
	print("Slider moved, new value: ", value)
	SettingsManager.change_vol(value)
	SettingsManager.update_settings()
