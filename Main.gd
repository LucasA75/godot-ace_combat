extends Node
@export var enemy_scene: PackedScene
@export var bullet_scene: PackedScene
var time
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func new_game():
	time = 0
	score = 0
	$HUD.update_score(score)
	$GameTime.start()
	$Ship.start($StartPosition.position)
	$StartTime.start()
	$Ship.life = 3
	$Music.play()
	$TutorialLayer.show_tutorial()
	$HUD.show_life_player($Ship.life)
	get_tree().call_group("enemys","queue_free")
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
	var positionInitial = enemy_spawn_location.position[0]
	
	
	for enemy in arrayEnemys:
		enemy.position = Vector2(positionInitial * (arrayEnemys.find(enemy)+0.5) ,0.0)
		var velocity = Vector2(150.0,0.0)
		enemy.linear_velocity = velocity.rotated(direction)
		enemy.level_of_enemy(change_dificulty_enemy())
		add_child(enemy)
		enemy.connect("enemy_die",_on_enemy_destroyed)	
	pass # Replace with function body.

func change_dificulty_enemy():
	if time <= 40:
		return 1
	elif time > 40 && time <= 90:
		return 2
	elif time > 90:
		return 3
	pass

func _on_enemy_destroyed():
	score += 1
	$HUD.update_score(score)
	pass
		
func _on_start_time_timeout():
	$EnemyTimer.start()
	pass # Replace with function body.


func _on_ship_shoot():
	var bullet = bullet_scene.instantiate()
	var ship_position = $Ship.position 
	print(ship_position)
	$SoundEffectBullet.play()
	bullet.position = Vector2(ship_position[0], ship_position[1] - 30.0)
	add_child(bullet)
	pass # Replace with function body.
	
func _on_game_time_timeout():
	time += 1
	pass # Replace with function body.


func _on_ship_hit():
	$HUD.update_life($Ship.life)
	pass # Replace with function body.
