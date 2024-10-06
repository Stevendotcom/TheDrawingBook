class_name Level extends Control

@export var scene_triggers:Array[SceneLoader]
var data:LevelDataHandoff
var is_enabled:bool = false

func _ready() -> void:
	is_enabled = false
	for trigger in scene_triggers:
		trigger.hide()
	# TODO: Disable old creatures with EntityManager
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
		print("Init Creatures")
		# TODO: Init creatures with EntityManager if there is data of creatures
	# TODO: Enable them creatures with EntityManager
	
	for trigger in scene_triggers:
		trigger.show()
		
	_connect_to_triggers()

func _on_player_entered_trigger(trigger:SceneLoader) -> void:
	_disconnect_from_triggers()
	data = LevelDataHandoff.new()
	data.move_dir = trigger.get_move_dir()
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
