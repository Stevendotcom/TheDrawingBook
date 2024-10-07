extends Control
@onready var volume_slider: HSlider = $VolumeSlider
@onready var arrow: TextureRect = $Arrow


var arrow_original_position : Vector2


func _ready() -> void:
	arrow_original_position = arrow.position
	$Small.mouse_entered.connect(toggle_hover.bind([$Small, true]))
	

func toggle_hover(button : TextureButton, is_hovering: bool):
	print(is_hovering)
	if is_hovering:
		_upscale(button)
	else	:
		_downscale(button)
	
func _upscale(button: TextureButton) -> void:
	const scale: float = 1.1
	button.scale = Vector2(scale,scale)
	button.position = Vector2(button.position.x - (button.size.x * scale - button.size.x)/2, button.position.y - (button.size.y * scale - button.size.y)/2)

func _downscale(button: TextureButton) -> void:
	button.scale = Vector2(1,1)
	button.position = Vector2(button.position.x + (button.size.x - button.size.x*0.9)/2, button.position.y + (button.size.y - button.size.y*0.9)/2)

func _on_volume_slider_value_changed(value: float) -> void:
	update_arrow_position(value)
	SettingsManager.change_vol(value)
	SettingsManager.update_settings()

func update_arrow_position(value):
	print("arrow: ", arrow.position.x)
	print("slider: ", volume_slider.get_rect().position.x)
	var max_position : float = volume_slider.get_rect().size.x - arrow.size.x / 2
	arrow.position.x = arrow_original_position.x + lerpf(0, max_position, value / volume_slider.max_value)


func _on_small_pressed() -> void:
	SettingsManager.change_screen_size("small")

func _on_medium_pressed() -> void:
	SettingsManager.change_screen_size("mid")

func _on_large_pressed() -> void:
	SettingsManager.change_screen_size("large")
	
func _on_full_screen_pressed() -> void:
	SettingsManager.toggle_fullscreen()
	SettingsManager.update_settings()
