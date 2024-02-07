extends RigidBody2D
var power_type

func change_animated(type):
	if(type == "Velocity"):
		$AnimatedSprite2D2.animation = "velocity"
	elif(type == "Attack"):
		$AnimatedSprite2D2.animation = "attack"
	pass

func _ready():
	self.add_to_group("PowerUps")
	linear_velocity = Vector2(0.0,50.0)
	pass # Replace with function body.

func _process(delta):
	change_animated(power_type)
	pass

