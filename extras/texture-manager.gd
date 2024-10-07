extends Node

var dir: DirAccess = DirAccess.open("res://resources/monsters/")
var textures: Array #its Array[Array[Array]] but godot does not support it yet

var populated: bool = false
var error: Error = Error.OK

const amount_bases: int = 12
const amount_levels: int = 4
const amount_evolution: int = 3


func _ready() -> void:
	if populate():
		printerr("Something went wrong while getting textures. Please reinstall.")
	
func populate() -> Error:
	# looks through all the files, if the file contains "level-x" and "base-y" 
	# it adds them to textures_lvl_x[y]
	init_array()
	if not populated:
		for file in dir.get_files():
			if not file.ends_with("import"):
				var level = file.get_slice("-",1).to_int() - 1
				var base = file.get_slice("-",3).to_int() - 1
				var evolution = file.get_slice("-",5).to_int() - 1
				textures[level][base][evolution] = ResourceLoader.load("res://resources/monsters/" + file, "Image")
				#load() returns empty if it could not find the file
				if not textures[level][base][evolution]:
					error = Error.ERR_FILE_NOT_FOUND
				#for level in amount_levels:
					#if file.containsn("level-{0}".format([level + 1])):
						#for base in amount_bases: 
							#if file.containsn("base-{0}".format([base + 1])):
								#var evolution: int = file.get_slice("-",5).to_int() - 1
								#textures[level][base][evolution] = ResourceLoader.load("res://resources/monsters/" + file, "Image")
								##load() returns empty if it could not find the file
								#if not textures[level][base][evolution]:
									#error = Error.ERR_FILE_NOT_FOUND
								#break
						#break
		return Error.OK
	return Error.ERR_ALREADY_IN_USE

func init_array()->void:
	for levels in amount_levels:
		textures.append([])
		for bases in amount_bases:
			textures[levels].append([])
			for evoultions in amount_evolution:
				textures[levels][bases].append([])

func get_corresponding_texture(base: int, level: int, evolution: int):
	return textures[level-1][base-1][evolution-1]
