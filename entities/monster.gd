class_name Monster extends Area2D
var id: int

@onready var sprite: Sprite2D = $MonsterSprite

var play_area_size: Vector2
var play_area_pos: Vector2

# Random movement
var speed: int = 150
var time_to_move: float = 3.0
var tolerance: float = 10.0

var evolution: int = 1 
var level: int = 1     
var base: int = 1       

var position_target: Vector2 = Vector2()
var sprite_size: Vector2 = Vector2()
var time_waited: float = 0.0
var is_moving: bool = false

# Drag and drop
var delay: float = 10.0
var mouse_offset: Vector2 = Vector2()  # Center mouse on click
var is_dragging: bool = false

func _ready() -> void:
	pass

func _process(delta) -> void:
	move(delta)
	drag(delta)

func set_up():
	sprite.scale = Vector2(0.2, 0.2)
	sprite_size = sprite.texture.get_size() * sprite.scale

# Random movement
func move(delta) -> void:
	if is_moving:
		move_to_target(delta)
	else:
		time_waited += delta
		if time_waited >= time_to_move:
			generate_random_position()

func generate_random_position() -> void:
	position_target = Vector2(
		randf_range(play_area_pos.x / 2 + tolerance, play_area_size.x - sprite_size.x / 2 - tolerance),
		randf_range(play_area_pos.y / 2 + tolerance, play_area_size.y - sprite_size.y / 2 - tolerance)
	)
	is_moving = true
	time_waited = 0.0

func move_to_target(delta) -> void:
	var direction: Vector2 = (position_target - position).normalized()
	position += direction * speed * delta

	if position.distance_to(position_target) <= tolerance:
		is_moving = false

# Drag and Drop
func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed: 
			var point_query = PhysicsPointQueryParameters2D.new()
			point_query.position = get_global_mouse_position()
			point_query.collide_with_areas = true
			point_query.collide_with_bodies = false

			var space_state = get_world_2d().direct_space_state
			var result = space_state.intersect_point(point_query, 32)

			if result.size() > 0:
				var clicked_node = result[0]["collider"]
				if clicked_node is Monster and clicked_node == self:
					is_dragging = true
					is_moving = false  # Stop movement when dragging starts
					mouse_offset = get_global_mouse_position() - global_position
		else: 
			if is_dragging:
				is_dragging = false
				var overlapping_areas = get_overlapping_areas()
				var other_id: int = -1
				for area in overlapping_areas:
					if area is Monster and area != self: 
						other_id = area.id
						break
				if other_id != -1:  
					EntityManager.merge_monster(self, self.id, other_id)

func drag(delta) -> void:
	if is_dragging:
		position = get_global_mouse_position() - mouse_offset 
