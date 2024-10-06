extends Node

var dir: DirAccess = DirAccess.open("res://resources/monsters/")
var textures = [[{}]] #its Array[Array{Dictonary] but godot does not support it yet

var populated: bool = false
var amount: Array[Array] = [[]]
var error: Error = Error.OK

const amount_bases: int = 3
const amount_levels: int = 4


func _onready() -> void:
	if populate():
		printerr("Something went wrong while getting textures. Please reinstall.")
	
func populate() -> Error:
	# looks through all the files, if the file contains "level-x" and "base-y" 
	# it adds them to textures_lvl_x[y]
	if not populated:
		for file in dir.get_files():
			for level in amount_levels:
				if file.contains("level-{0}".format(level + 1)):
					for base in amount_bases: 
						if file.contains("base-{0}".format(base + 1)):
							textures[level][base][amount[level][base]] = ResourceLoader.load(file, "Image")
							#load() returns empty if it could not find the file
							if not textures[level][base][amount[level][base]]:
								error = Error.ERR_FILE_NOT_FOUND
							amount[level][base] += 1
							break
					break
		return Error.OK
	return Error.ERR_ALREADY_IN_USE

func get_corresponding_texture(base: int, level: int, monster_id: int):
	return textures[level][base][monster_id]
