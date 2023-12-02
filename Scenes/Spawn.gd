extends Node




@export var enemy_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	$UserInterface/RetryButton.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass






func _on_spawn_enemy_timer_timeout():
	var enemy := enemy_scene.instantiate()
	var enemy_spawn_location := get_node("SpawnPath/SpawnLocation") as PathFollow3D
	enemy_spawn_location.progress_ratio = randf()		# random number betweeen 0 and 1, 0 is start, 1 is end of path.
	
	var player_position = $Player.position
	
	enemy.initialize(enemy_spawn_location.position, player_position)
	
	add_child(enemy)
	
	enemy.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())
	
	
	
	
	
	


func _on_player_hit():
	$SpawnEnemyTimer.stop()
	$UserInterface/RetryButton.show()



func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") && $UserInterface/RetryButton.visible:
		get_tree().reload_current_scene()	
