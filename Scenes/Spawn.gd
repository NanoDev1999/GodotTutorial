extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


@export var enemy_scene: PackedScene



func _on_spawn_enemy_timer_timeout():
	var enemy := enemy_scene.instantiate()
	var enemy_spawn_location := get_node("SpawnPath/SpawnLocation") as PathFollow3D
	enemy_spawn_location.progress_ratio = randf()		# random number betweeen 0 and 1, 0 is start, 1 is end of path.
	
	var player_position = $Player.position
	
	enemy.initialize(enemy_spawn_location.position, player_position)
	
	add_child(enemy)
	
	
	
	
	
	
