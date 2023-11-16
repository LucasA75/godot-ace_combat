extends RigidBody2D
signal enemy_hit
signal enemy_die
var life = 0
var levelEnemy
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
	
func level_of_enemy(level):
	if level == 1:
		$AnimatedSprite2D.animation = "Level1"
		life = 1
	elif level == 2:
		$AnimatedSprite2D.animation = "Level2"
		life = 2
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
		queue_free()
	pass # Replace with function body.
