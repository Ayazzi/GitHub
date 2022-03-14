extends Actor
class_name Player

export var delay_bigfall_time = 1 #lets me set the fall time

func _physics_process(_delta:float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction: = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") else 1.0
	)


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var veloci: = linear_velocity
	veloci.x = speed.x * direction.x 
	veloci.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		veloci.y = speed.y * direction.y
	if is_jump_interrupted:
		veloci.y = 0.0
	if (velocity.y < max_y_velocity):
		velocity.y += gravity * get_physics_process_delta_time()
	if veloci.y > 1500: 
		veloci.y = 1500
	return veloci




onready var _animated_sprite = $AnimatedSprite

func _process(_delta:float) -> void:
	
	if velocity.y != 0:
		if velocity.y < 0.0:
			_animated_sprite.play("flappy")
		else:
			_animated_sprite.play("fall")
		if velocity.y > 1000.0:
			_animated_sprite.play("bigfall")
	else:
		if is_on_floor(): # oder: if velocity.y == 0:
			_animated_sprite.play("idle")
	if is_on_ceiling():
		_animated_sprite.play("ceilingspam")


