class_name Level extends Control

@export var scene_triggers:Array[SceneLoader]
var data:LevelDataHandoff
var is_enabled:bool = false
@onready var buy_fx = preload("res://audio/vfx/buy_creature.wav")

func _ready() -> void:
	is_enabled = false
	for trigger in scene_triggers:
		trigger.hide()
	if data == null:
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


func enter_level() -> void:
	if data != null:
		for entity in data.entities:
			EntityManager.new_monster(self)
	# TODO: Enable them creatures with EntityManager
	
	for trigger in scene_triggers:
		trigger.show()
		
	_connect_to_triggers()

func _on_player_entered_trigger(trigger:SceneLoader) -> void:
	_disconnect_from_triggers()
	data = LevelDataHandoff.new()
	data.move_dir = trigger.get_move_dir()
	data.entities = EntityManager.entities.duplicate()
	EntityManager.amount_entities = 0
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
	pass # Replace with function body.

func _bought(base: int) -> void:
	#probably a bad place to put it, but if there is no bottons there is no problem
	#if enough ink
	#subtract from ink
	var monster: Monster = EntityManager.new_monster(self)
	monster.base = base
	monster.level = 1
	monster.evolution = 1
	monster.find_child("MonsterSprite").texture = TextureManager.get_corresponding_texture(base, 1,1)
	monster.set_up()
	AudioManager.play_fx(buy_fx)
