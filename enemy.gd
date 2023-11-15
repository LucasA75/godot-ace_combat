extends RigidBody2D
signal enemy_hit
signal enemy_die
var life = 1
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
