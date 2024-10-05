class_name Level extends Control

@export var scene_triggers:Array[SceneLoader]
var data:LevelDataHandoff

func _ready() -> void:
	for trigger in scene_triggers:
		trigger.hide()
	# TODO: Disable old creatures with EntityManager
	if data == null:
		enter_level()
	

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
	#data.entry_trigger_name = trigger.entry_trigger_name
	data.move_dir = trigger.get_move_dir()
	set_process(false)
	
func _connect_to_triggers() -> void:
	for trigger in scene_triggers:
		if not trigger.player_entered_trigger.is_connected(_on_player_entered_trigger):
			trigger.player_entered_trigger.connect(_on_player_entered_trigger)
	
func _disconnect_from_triggers() -> void:
	for trigger in scene_triggers:
		if not trigger.player_entered_trigger.is_connected(_on_player_entered_trigger):
			trigger.player_entered_trigger.disconnect(_on_player_entered_trigger)
