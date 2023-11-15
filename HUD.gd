extends CanvasLayer

signal start_game

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
	
func update_score(score):
	var text = "Score : {score}"
	$ScoreLabel.text = text.format({"score": score})


func _on_start_button_pressed():
	$StartButton.hide()
	$Message.hide()
	start_game.emit()
	pass # Replace with function body. 
