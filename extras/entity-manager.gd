extends Node

const MONSTER = preload("res://entities/monster.tscn")

var entity_id: int = 0
var amount_entities: int = 0
var entities: Array[Node]
const amount_entities_max: int = 25

@onready var merge_creature_1 = preload("res://audio/vfx/merge_creature_1.mp3")
@onready var merge_creature_2 = preload("res://audio/vfx/merge_creature_2.mp3")
@onready var merge_creature_3 = preload("res://audio/vfx/merge_creature_3.mp3")

func new_monster(this_node: Node, is_null: bool) -> Node:
	if is_null == true:
		entities.push_back(null)
		return
	if amount_entities < amount_entities_max:
		var instance : Node = MONSTER.instantiate()
		entities.push_back(instance)
		this_node.add_child(instance)
		instance.id = entity_id
		instance.play_area_size = this_node.get_node("PlayableArea/Shape").get_shape().size
		instance.play_area_pos = this_node.get_node("PlayableArea/Shape").position
		entity_id += 1
		amount_entities += 1
		
		return instance
	return null

func clone_monster(this_node: Node, is_null: bool) -> Node:
	if is_null == true:
		entities.push_back(null)
		return
	if amount_entities < amount_entities_max:
		var instance : Node = MONSTER.instantiate()
		entities.push_back(instance)
		this_node.add_child(instance)
		instance.id = entity_id
		instance.play_area_size = this_node.get_node("PlayableArea/Shape").get_shape().size
		instance.play_area_pos = this_node.get_node("PlayableArea/Shape").position
		
		return instance
	return null

func delete_monster(this_node: Node, monster_id: int) -> void:
	if _in_range(monster_id) and entities[monster_id] != null:
		entities[monster_id].free()
		entities[monster_id] = null
		amount_entities -= 1

func merge_monster(this_node: Node, monster_id_a: int, monster_id_b: int):
	if _in_range(monster_id_a) and _in_range(monster_id_b) and entities[monster_id_a] != null and entities[monster_id_b] != null:
		print("Entidad A, evolution: ", entities[monster_id_a].evolution)
		print("Entidad B, evolution: ", entities[monster_id_b].evolution)
		print("Entidad A, base: ", entities[monster_id_a].base)
		print("Entidad B, base: ", entities[monster_id_b].base)
		if entities[monster_id_a].level >= 4 && entities[monster_id_a].evolution >= 3:
			return
		if entities[monster_id_b].level >= 4 && entities[monster_id_b].evolution >= 3:
			return
		if entities[monster_id_a].level == entities[monster_id_b].level:
			if entities[monster_id_a].evolution == entities[monster_id_b].evolution:
				if entities[monster_id_a].base == entities[monster_id_b].base:
					upgrade_monster(this_node, monster_id_a)
					delete_monster(this_node, monster_id_b)
		
func upgrade_monster(this_node: Node, monster_id: int):
	if _in_range(monster_id) and entities[monster_id] != null:
		if entities[monster_id].evolution <= 2:
			entities[monster_id].evolution +=1
		else:
			entities[monster_id].level += 1
			entities[monster_id].evolution = 1
		_play_merge_fx(entities[monster_id].evolution)
		_set_sprite(monster_id)

func get_active_monsters() -> Array:
	var temp: Array[Node]
	for entity in entities:
		if entity != null:
			temp.push_back(entity)
	return temp

func _play_merge_fx(evolution: int) -> void:
	match evolution:
		1:
			AudioManager.play_fx(merge_creature_1)
		2:
			AudioManager.play_fx(merge_creature_2)
		3:
			AudioManager.play_fx(merge_creature_3)
		_:
			print("Unknown evolution value: ", evolution)

func _set_sprite(monster_id: int):
	if _in_range(monster_id) and entities[monster_id] != null:
		print("Entidad A, evolucion: ", entities[monster_id].evolution)
		print("Entidad A, base: ", entities[monster_id].base)
		print("Entidad A, level: ", entities[monster_id].level)
		entities[monster_id].sprite.texture = TextureManager.get_corresponding_texture(entities[monster_id].base, entities[monster_id].level, entities[monster_id].evolution)

func _in_range(monster_id: int) -> bool:
	return amount_entities <= amount_entities_max and monster_id >= 0
