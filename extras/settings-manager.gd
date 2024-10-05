extends Node

enum axis {
	width,
	height,
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
		screen_width = screen_sizes[screen_size][axis.width]
		screen_height = screen_sizes[screen_size][1]


func toggle_fullscreen() ->void:
	fullscreen = !fullscreen
