extends CanvasLayer
signal start_game
@export var life_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message('Game Over')
	await  $MessageTimer.timeout
	
	$Message.text = "Ace Combat"
	$StartButton.show()
	$Message.show()
	
func show_life_player(lifePlayer):
	var distance_lifes = 17
	for x in lifePlayer:
		var life = life_scene.instantiate()
		life.position = Vector2(distance_lifes, 9)
		distance_lifes += 45
		add_child(life)
	pass
	
func update_life(numberOfLifes):
	print(numberOfLifes)
	get_tree().call_group("lifes","queue_free")
	show_life_player(numberOfLifes)

func update_powerUp(powerUp):
	$TimerPowerUp.start()
	$PowerUpLabel.show()
	var text = "You got a power of {powerUP}"
	$PowerUpLabel.text = text.format({"powerUP": powerUp})
	await $TimerPowerUp.timeout
	$PowerUpLabel.hide()

func update_score(score):
	var text = "Enemys : {score}"
	$ScoreLabel.text = text.format({"score": score})


func _on_start_button_pressed():
	$StartButton.hide()
	$Message.hide()
	start_game.emit()
	pass # Replace with function body. 
