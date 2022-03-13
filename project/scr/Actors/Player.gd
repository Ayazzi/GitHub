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
		if velocity.y == 0:
			_animated_sprite.play("idle")
	
	
	#_animated_sprite.play("bigfall") #plays the BIG fall animation if player falls
	
	#if velocity.y > 0.0 and "Timer is active":
		#_animated_sprite.play("fall") #plays the normal fall animation if player falls
	#else:
		#velocity.y > 0.0 and "Timer is no longer active"
		#_animated_sprite.play("bigfall")
	
	#return 





#func _ready(): #lets me use the function
	#bigfall_animation() 


#func bigfall_animation(): 
	#if velocity.y > 0.0 and "timer is no longer active": 
		#_animated_sprite.play("bigfall") #plays the BIG fall animation if player falls
	#$delay_bigfall.start(delay_bigfall_time) #delays the function


#func _on_delay_fall_ani_timeout() -> void: #connected with Node
	
	#$delay_bigfall.start(delay_bigfall_time)#delays the function
	
	#if ($delay_bigfall.delay_bigfall_time > 0):
		#print ("Timer is active")
	#else:
		#print ("Timer is no longer active")
	#return





		#get_scene.queue_free()


#func _on_Area2D_body_entered(body: Node) -> void:
#	if body.get_name() == "Player":





