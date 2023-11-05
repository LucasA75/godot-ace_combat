extends Node
@export var enemy_scene: PackedScene
@export var bullet_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func new_game():
	$Ship.start($StartPosition.position)
	$StartTime.start()
	$Ship.life = 3
	$Music.play()
	pass

func game_over():
	$StartTime.stop()
	$EnemyTimer.stop()
	$HUD.show_game_over()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_enemy_timer_timeout():
	
	var arrayEnemys = []
	
	for i in range(3):
		var enemy = enemy_scene.instantiate()
		arrayEnemys.append(enemy)
	
	var enemy_spawn_location = get_node("EnemyPath/EnemySpawnLocation")
	var direction = enemy_spawn_location.rotation + PI / 2
	enemy_spawn_location.progress_ratio = randf_range(0.091,0.380)
	print(enemy_spawn_location.progress_ratio)
	var positionInitial = enemy_spawn_location.position[0]
	
	
	for enemy in arrayEnemys:
		# print( arrayEnemys.find(enemy))
		enemy.position = Vector2(positionInitial * (arrayEnemys.find(enemy)+0.5) ,0.0)
		# print(enemy.position)
		var velocity = Vector2(150.0,0.0)
		enemy.linear_velocity = velocity.rotated(direction)
	
		add_child(enemy)
	pass # Replace with function body.


func _on_start_time_timeout():
	$EnemyTimer.start()
	pass # Replace with function body.


func _on_ship_shoot():
	var bullet = bullet_scene.instantiate()
	var ship_position = $Ship.position 
	$SoundEffectBullet.play()
	bullet.position = Vector2(ship_position)
	add_child(bullet)
	pass # Replace with function body.
	

