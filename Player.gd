extends CharacterBody3D

@export var speed = 15

@export var fall_acceleration = 80

@export var jump_impluse = 20

@export var bounce_impulse = 16



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
	
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impluse
	
	for index in range(get_slide_collision_count()):		# goes through all collisions that happened this frame for the Player
		var collision := get_slide_collision(index) as KinematicCollision3D 		# get one of the collisions
		
		if collision.get_collider() == null:		# if the collision is with the ground/world/main then we just ignore this.
			continue
			
		if collision.get_collider().is_in_group("enemy"):
			var enemy = collision.get_collider()
			
			if Vector3.UP.dot(collision.get_normal()) > 0.1:	# check to see if we hit it by jumping on it and not running into it.
				
				enemy.squash()
				target_velocity.y = bounce_impulse
				break
				
			
	
	velocity = target_velocity
	move_and_slide()		# moves model smoothly given the velocity
	
	
