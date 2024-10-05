extends Node

enum Axis {
	WIDTH,
	HEIGHT,
}

const screen_sizes = {
	"large": [1920, 1080], # common for Full HD
	"mid": [1366, 768], # common for laptops
	"small": [1024, 576], # common for smaller devices
};

const volume_def: float = 5
const screen_width_def: int = 1920
const screen_height_def: int = 1080
const fullscreen_def: bool = false

var volume: float = volume_def
var screen_width: int = screen_width_def
var screen_height: int = screen_height_def
var fullscreen: bool = fullscreen_def

const max_vol: int = 10

func change_vol(newVol: float) -> void:
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
