extends Control
@onready var volume_slider: HSlider = $VolumeSlider
@onready var arrow: TextureRect = $Arrow
@onready var small: TextureButton = $Small
@onready var medium: TextureButton = $Medium
@onready var large: TextureButton = $Large
@onready var full_screen: TextureButton = $FullScreen



var arrow_original_position : Vector2


func _ready() -> void:
	arrow_original_position = arrow.position

func _upscale(button: TextureButton) -> void:
	const scale_factor: float = 1.1
	button.scale *= scale_factor
	button.position -= Vector2(button.size.x * (scale_factor - 1) / 2, button.size.y * (scale_factor - 1) / 2)

func _downscale(button: TextureButton) -> void:
	const scale_factor: float = 1.1
	button.scale /= scale_factor
	# Calculamos el cambio en la posición para centrar el botón de vuelta
	button.position += Vector2(button.size.x * (scale_factor - 1) / 2, button.size.y * (scale_factor - 1) / 2)

func _on_volume_slider_value_changed(value: float) -> void:
	update_arrow_position(value)
	SettingsManager.change_vol(value)
	SettingsManager.update_settings()

func update_arrow_position(value):
	print("arrow: ", arrow.position.x)
	print("slider: ", volume_slider.get_rect().position.x)
	var max_position : float = volume_slider.get_rect().size.x - arrow.size.x / 2
	arrow.position.x = arrow_original_position.x + lerpf(0, max_position, value / volume_slider.max_value)


#Back button
func _on_back_pressed() -> void:
	self.visible = false


#Small Button
func _on_small_pressed() -> void:
	print("small")
	SettingsManager.change_screen_size("small")
	SettingsManager.update_settings()

func _on_small_mouse_entered() -> void:
	_upscale(small)

func _on_small_mouse_exited() -> void:
	_downscale(small)


#Medium button
func _on_medium_pressed() -> void:
	print("mid")
	SettingsManager.change_screen_size("mid")
	SettingsManager.update_settings()

func _on_medium_mouse_entered() -> void:
	_upscale(medium)

func _on_medium_mouse_exited() -> void:
	_downscale(medium)


#Large button	
func _on_large_pressed() -> void:
	print("large")
	SettingsManager.change_screen_size("large")
	SettingsManager.update_settings()
	
func _on_large_mouse_entered() -> void:
	_upscale(large)

func _on_large_mouse_exited() -> void:
	_downscale(large)
	
	
#FullScreen button
func _on_full_screen_pressed() -> void:
	SettingsManager.toggle_fullscreen()
	SettingsManager.update_settings()

func _on_full_screen_mouse_entered() -> void:
	_upscale(full_screen)

func _on_full_screen_mouse_exited() -> void:
	_downscale(full_screen)
