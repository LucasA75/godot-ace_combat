extends Area2D
var velocidad = 300
signal hitBullet

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	pass # Replace with function body.

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= velocidad * delta
	if position.y < -get_viewport_rect().size.y / 2:
		queue_free()
	pass


func _on_body_entered(body):
	if body.has_method("_on_enemy_hit"):
		body.emit_signal("enemy_hit")
	queue_free()
	
	pass # Replace with function body.
