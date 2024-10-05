extends Node

const MONSTER = preload("res://entities/monster.tscn")

var amount_entities: int = 0
var entities: Array = []
const amount_entities_max: int = 15

func new_monster(this_node: Node) -> void:
	if amount_entities < amount_entities_max:
		var instance = MONSTER.instantiate()
		entities.push_back(instance)
		this_node.add_child(instance)
		amount_entities += 1
