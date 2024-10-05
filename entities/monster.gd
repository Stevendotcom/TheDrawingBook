#Tampoco chequea los limites del movimiento en base a las medidas del monster

extends Area2D
@onready var sprite = $MonsterSprite

#Random movement
var speed = 300
var position_target = Vector2()
var time_to_move = 3.0
var time_waited = 0.0
var tolerance = 10.0
var is_moving = false
var sprite_size = Vector2()

func _ready():
	if sprite.texture:
		sprite_size = sprite.texture.get_size() * sprite.scale
	else:
		print("Error: El sprite no tiene una textura asignada.")


func _process(delta):
	move(delta)


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
	print("Target position: ", position_target)
	is_moving = true
	time_waited = 0.0

func move_to_target(delta):
	var direction = (position_target - position).normalized()
	position += direction * speed * delta

	if position.distance_to(position_target) <= tolerance:
		is_moving = false
		print("Position reached")
