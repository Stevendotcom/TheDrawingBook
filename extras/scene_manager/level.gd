class_name Level extends Control

@export var scene_triggers:Array[SceneLoader]
@onready var ink_amount: RichTextLabel = $Ink/InkAmount

var data:LevelDataHandoff
var is_enabled:bool = false
@onready var buy_fx = preload("res://audio/vfx/buy_creature.wav")
var rebirth_count: int = 0
var timer: float
var total_ink: float

func _ready() -> void:
	is_enabled = false
	for trigger in scene_triggers:
		trigger.hide()
	if data == null:
		ink_amount.set_text("[center]{0} oz[/center]".format(["0"]))
		var monster = EntityManager.new_monster(self, false)
		monster.find_child("MonsterSprite").texture = TextureManager.get_corresponding_texture(1,1,1)
		monster.set_up(1, 1, 1)
		enter_level()

func _process(_delta: float) -> void:
	if not is_enabled:
		return
		
	if Input.is_action_just_pressed("Right"):
		scene_triggers[0]._on_left_click()
		is_enabled = false
		
	if Input.is_action_just_pressed("Left"):
		scene_triggers[1]._on_left_click()
		is_enabled = false
	
	timer += _delta	
	if timer > 1:
		_get_total_ink_per_second()
		ink_amount.set_text("[center]{0} oz[/center]".format([total_ink]))
		timer = 0


func enter_level() -> void:
	if data != null:
		total_ink = data.total_ink
		for entity in data.entities:
			if entity == null:
				EntityManager.clone_monster(self, true, 0)
				continue
			var monster: Node = EntityManager.clone_monster(self, false, entity.id)
			monster.find_child("MonsterSprite").texture = TextureManager.get_corresponding_texture(entity.base, entity.level, entity.evolution)
			monster.set_up(entity.base, entity.level, entity.evolution)
	for trigger in scene_triggers:
		trigger.show()
		
	_connect_to_triggers()

func _on_player_entered_trigger(trigger:SceneLoader) -> void:
	_disconnect_from_triggers()
	data = LevelDataHandoff.new()
	data.move_dir = trigger.get_move_dir()
	data.entities = EntityManager.entities.duplicate()
	EntityManager.entities.clear()
	data.total_ink = total_ink
	set_process(false)
	
func _connect_to_triggers() -> void:
	for trigger in scene_triggers:
		if not trigger.player_entered_trigger.is_connected(_on_player_entered_trigger):
			trigger.player_entered_trigger.connect(_on_player_entered_trigger)
	is_enabled = true
	
func _disconnect_from_triggers() -> void:
	for trigger in scene_triggers:
		if not trigger.player_entered_trigger.is_connected(_on_player_entered_trigger):
			trigger.player_entered_trigger.disconnect(_on_player_entered_trigger)


func _on_pause_button_up() -> void:
	$PauseMenu.visible = true
	get_tree().paused = true


func _bought(base: int, price: int) -> void:
	#probably a bad place to put it, but if there is no bottons there is no problem
	if has_enough_ink(price): 
		deduct_ink(price)
		var monster: Monster = EntityManager.new_monster(self, false)
		monster.base = base
		monster.level = 1
		monster.evolution = 1
		monster.find_child("MonsterSprite").texture = TextureManager.get_corresponding_texture(base, 1,1)
		monster.set_up(base, 1, 1)
		AudioManager.play_fx(buy_fx)

func _get_ink_rate(creature: Node) -> float:
	# Base ink calculation
	var base_ink = creature.level * creature.base
	var evolution_multiplier = creature.evolution * 2 # Multipier to ramp up the ink production per evolution

	# Rebirth multiplier: 10% more ink per rebirth
	var rebirth_multiplier = 1 + (rebirth_count * 0.10)

	return base_ink * evolution_multiplier * rebirth_multiplier

func _get_total_ink_per_second() -> void:
	for creature in EntityManager.entities:
		if creature == null:
			continue
		total_ink += _get_ink_rate(creature)

# Rebirth function to reset the game and increase the rebirth count
func rebirth():
# TODO: Reset game state, creatures, etc.
	rebirth_count += 1  # Increase rebirth count


# Function to check if the player has enough ink
func has_enough_ink(price: float) -> bool:
	return total_ink >= price

# Function to deduct ink from the player
func deduct_ink(price: float):
	total_ink  -= price
