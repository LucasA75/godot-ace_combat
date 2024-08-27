extends RigidBody2D
var power_type
var max_fall_speed = 70

func change_animated(type):
	if(type == "Velocity"):
		$AnimatedSprite2D2.animation = "velocity"
		$AnimatedSprite2D2.modulate = Color(0.5, 0.7, 1)
	elif(type == "Attack"):
		$AnimatedSprite2D2.animation = "attack"
		$AnimatedSprite2D2.modulate = Color(1, 0.6, 0.6)
	pass

func _ready():
	self.add_to_group("PowerUps")
	linear_velocity = Vector2(0.0,50.0)
	gravity_scale = 0.05
	pass # Replace with function body.

func _process(delta):
	change_animated(power_type)
	pass

func _physics_process(delta):
	# Limita la velocidad de caída a `max_fall_speed`
	if linear_velocity.y > max_fall_speed:
		linear_velocity.y = max_fall_speed
