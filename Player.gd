extends CharacterBody3D

@export var speed = 15

@export var fall_acceleration = 80

var target_velocity = Vector3.ZERO		#// Vector 3 combines speed with a vector


func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	
	if direction != Vector3.ZERO:		# this normalizes movement if two or more things are held at once, instead of adding them together.
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)	# this will pivot the model it in the air when it lands.
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if not is_on_floor():		# causes the node to move downward if not colliding with the floor, we will have to add collisions later I think.
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	velocity = target_velocity
	move_and_slide()		# moves model smoothly given the velocity
	
	
