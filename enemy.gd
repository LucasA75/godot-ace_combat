extends RigidBody2D
signal enemy_hit
signal enemy_die
var life = 0
var levelEnemy
@export var powerUP_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	$EliminatedSprite.hide()
	$AnimatedSprite2D.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(life <= 0):
		$CollisionShape2D.disabled = true
	pass
	
func generate_reward():
	var num_random = round(randf_range(0,15))
	if(num_random == 1 || num_random == 2):
		var powerUp = powerUP_scene.instantiate()
		if(num_random == 1):
			powerUp.power_type = "Velocity"
			add_child(powerUp)
		elif(num_random == 2 ):
			powerUp.power_type = "Attack"
			add_child(powerUp)
			
	pass

func level_of_enemy(level):
	if level == 1:
		$AnimatedSprite2D.animation = "Level1"
		life = 2
	elif level == 2:
		$AnimatedSprite2D.animation = "Level2"
		life = 8
	elif level == 3:
		$AnimatedSprite2D.animation = "Level3"
		life = 20
	else:
		var text = "not Found : Level {level}"
		print(text.format({"level": level}))

func _on_enemy_hit(hit_value):
	life -= hit_value
	if(life <= 0):
		enemy_die.emit()
		generate_reward()
		var velocity = linear_velocity
		linear_velocity = Vector2(0.0,50.0)
		$AnimatedSprite2D.hide()
		$EliminatedSprite.show()
		$EliminatedSprite.play()
		$DieTime.start()
		await $DieTime.timeout
		var childrenArray = get_children()
		for children in childrenArray:
			$EliminatedSprite.hide()
			$PowerUpTime.start()
			await  $PowerUpTime.timeout
		queue_free()
	pass # Replace with function body.
