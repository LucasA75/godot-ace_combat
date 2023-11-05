extends Area2D
@export var speed = 300
signal hit
signal shoot
signal dead
var screen_size
@export var life = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$GPUParticles2D.hide()
	screen_size = get_viewport_rect().size
	pass # Replace with function body.

func start(pos):
	position = pos
	$DeadSpriteAnimate.hide()
	$GPUParticles2D.show()
	$AnimatedSprite2D.show()
	show()
	$CollisionShape2D.disabled = false

func shot():
	shoot.emit()
	print('Shoting')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		$AnimatedSprite2D.animation = "default"
		if life != 0:
			control_ship(delta)
		pass

func control_ship(delta):
		var velocity = Vector2.ZERO	
		if Input.is_action_just_pressed('shot'):
			shot()
		
		if Input.is_action_pressed("right"):
			velocity.x += 1
		if Input.is_action_pressed("left"):
			velocity.x -= 1
		if Input.is_action_pressed("up"):
			velocity.y -= 1
		if Input.is_action_pressed("down"):
			velocity.y += 1
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()
		position += velocity * delta
		position = position.clamp(Vector2(20.0,30.0),Vector2(screen_size[0] - 20.0,screen_size[1] - 20.0))
		pass
	


func dead_ship():
	$DeadSpriteAnimate.show()
	$DeadSpriteAnimate.play()
	$AnimatedSprite2D.hide()
	$GPUParticles2D.hide()
	$CollisionShape2D.disabled = true
	dead.emit()
	pass


func _on_body_entered(body):
	life -= 1
	if(life == 0):
		dead_ship()
	hit.emit() 
	pass # Replace with function body.