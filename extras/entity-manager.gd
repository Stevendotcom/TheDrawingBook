extends Node

const MONSTER = preload("res://entities/monster.tscn")
const ICON = preload("res://extras/icon.svg") #TODO REMOVE

var amount_entities: int = 0
var entities: Array[Node] = [null]
const amount_entities_max: int = 15

func new_monster(this_node: Node) -> void:
	if amount_entities < amount_entities_max:
		var instance : Node = MONSTER.instantiate()
		entities.push_back(instance)
		this_node.add_child(instance)
		amount_entities += 1

func delete_monster(this_node: Node, monster_id: int) -> void:
	if _in_range(monster_id) and entities[monster_id] != null:
		entities[monster_id].free()
		entities[monster_id] = null
		amount_entities -= 1

func merge_monster(this_node: Node, monster_id_a: int, monster_id_b: int):
	if _in_range(monster_id_a) and _in_range(monster_id_b) and entities[monster_id_a] != null and entities[monster_id_b] != null:
		if entities[monster_id_a].evolution == entities[monster_id_b].evolution:
			upgrade_monster(this_node, monster_id_a)
			delete_monster(this_node, monster_id_b)
		
func upgrade_monster(this_node: Node, monster_id: int):
	if _in_range(monster_id) and entities[monster_id] != null:
		entities[monster_id].evolution +=1
		_set_sprite(monster_id)

func get_active_monsters() -> Array:
	var temp: Array[Node]
	for entity in entities:
		if entity != null:
			temp.push_back(entity)
	return temp

func _set_sprite(monster_id: int):
	if _in_range(monster_id) and entities[monster_id] != null:
		entities[monster_id].sprite.texture = TextureManager.get_corresponding_texture(entities[monster_id].level, entities[monster_id].base, entities[monster_id].evolution)

func _in_range(monster_id: int) -> bool:
	return monster_id < amount_entities_max and monster_id >= 0
