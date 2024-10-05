extends Node

const MONSTER = preload("res://entities/monster.tscn")

var amount_entities: int = 0
var entities: Array = [null]
const amount_entities_max: int = 15

func new_monster(this_node: Node) -> void:
	if amount_entities < amount_entities_max:
		var instance : Node = MONSTER.instantiate()
		entities.push_back(instance)
		this_node.add_child(instance)
		amount_entities += 1

func delete_monster(this_node: Node, monster_id: int) -> void:
	if monster_id < amount_entities_max and monster_id >= 0 and entities[monster_id] != null:
		entities[monster_id].free()
		entities[monster_id] = null
		amount_entities -= 1
