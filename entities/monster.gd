
extends Area2D
@onready var sprite = $MonsterSprite

#Random movement
var speed: int = 300
var time_to_move: float = 3.0
var tolerance: float = 10.0

var position_target: Vector2 = Vector2()
var sprite_size: Vector2 = Vector2()
var time_waited: float = 0.0
var is_moving: bool = false

#Drag and drop
var delay: float = 10.0
var is_dragging: bool = false #state management
var mouse_offset: Vector2 = Vector2() #center mouse on click

func _ready():
	if sprite.texture:
		sprite_size = sprite.texture.get_size() * sprite.scale
	else:
		print("Error: The sprite doesn't have a texture assigned")

func _process(delta):
	move(delta)
	drag(delta)


#Random movement
func move(delta):
	if is_moving:
		move_to_target(delta)
	else:
		time_waited += delta
		if time_waited >= time_to_move:
			generate_random_position()

func generate_random_position():
	position_target = Vector2(
		randf_range(sprite_size.x / 2 + tolerance, get_viewport().size.x - sprite_size.x / 2 - tolerance),
		randf_range(sprite_size.y / 2 + tolerance, get_viewport().size.y - sprite_size.y / 2 - tolerance)
	)
	#print("Target position: ", position_target)
	is_moving = true
	time_waited = 0.0

func move_to_target(delta):
	var direction = (position_target - position).normalized()
	position += direction * speed * delta

	if position.distance_to(position_target) <= tolerance:
		is_moving = false
		#print("Position reached")



#Drag and Drop
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT: 
		if event.pressed: #User Left Clicks
			var local_mouse_pos = to_local(event.position) #Save mouse position
			if sprite.get_rect().has_point(local_mouse_pos): #The click is on the monster
				is_dragging = true
				mouse_offset = get_global_mouse_position()-global_position
		else:
			is_dragging = false

func drag(delta):
	if is_dragging == true:
		var tween = get_tree().create_tween() #Generate tween for animation
		tween.tween_property(self, "position", get_global_mouse_position()-mouse_offset, delay * delta) #Set animation properties
		#Stop random movement
		is_moving = false
		time_waited = 0.0