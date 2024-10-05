extends Node

enum Axis {
	WIDTH,
	HEIGHT,
}

var volume: int = 5
var screen_width: int = 1366
var screen_height: int = 768
var fullscreen: bool = false

const screen_sizes = {
	"large" = [1366, 768],
	"mid" = [1280, 720],
	"small" = [1024, 576],
}

const max_vol: int = 10

func change_vol(newVol: int) -> void:
	volume = newVol

func change_screen_size(screen_size: String) -> void:
	if screen_sizes.find_key(screen_size):
		screen_width = screen_sizes[screen_size][Axis.WIDTH]
		screen_height = screen_sizes[screen_size][Axis.HEIGHT]


func toggle_fullscreen() ->void:
	fullscreen = !fullscreen

func update_settings() -> void:
	ProjectSettings.set_setting("display/window/size/viewport_height", screen_height)
	ProjectSettings.set_setting("display/window/size/viewport_width", screen_width)
	ProjectSettings.set_setting(
		"", 
		DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN if fullscreen 
		else DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED
		)
	AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index("Master"),
			linear_to_db(volume)
		)
