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
	print(num_random)
	if(num_random == 1):
		var powerUp = powerUP_scene.instantiate()
		add_child(powerUp)
		print("Generar Recompensa de Velocidad")
	elif(num_random == 2 ):
		var powerUp = powerUP_scene.instantiate()
		add_child(powerUp)
		print("Generar recompensa de Ataque")
	pass
	
func level_of_enemy(level):
	if level == 1:
		$AnimatedSprite2D.animation = "Level1"
		life = 1
	elif level == 2:
		$AnimatedSprite2D.animation = "Level2"
		life = 3
	elif level == 3:
		$AnimatedSprite2D.animation = "Level3"
		life = 5
	else:
		var text = "not Found : Level {level}"
		print(text.format({"level": level}))

func _on_enemy_hit():
	life -= 1
	if(life <= 0):
		enemy_die.emit()
		var velocity = linear_velocity
		linear_velocity = Vector2(0.0,50.0)
		$AnimatedSprite2D.hide()
		$EliminatedSprite.show()
		$EliminatedSprite.play()
		$DieTime.start()
		await $DieTime.timeout
	
		var childrenArray = get_children()
		for children in childrenArray:
			if children.name == "powerUp":
				$EliminatedSprite.hide()
				$PowerUpTime.start()
				await  $PowerUpTime.timeout
		queue_free()
	pass # Replace with function body.
