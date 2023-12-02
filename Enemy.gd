extends CharacterBody3D

@export var min_speed = 10
@export var max_speed = 20

signal squashed

func _physics_process(delta):		# it's going to move in a single direction at a constant speed.
	move_and_slide()
	
func initialize(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range((-PI/4), (PI/4)))		# this rotates it to not look exactly at the player each time and add randomness

	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)		# this accounts for the rotation, so that the velocity is corerctly angled forward
	
	
	
	


func _on_visibility_notifier_screen_exited():
	queue_free()
	

func squash():
	
	squashed.emit()
	queue_free()
