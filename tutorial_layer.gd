extends CanvasLayer
signal startTutorial

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func show_tutorial():
	show()
	$TutorialTimer.start()
	await  $TutorialTimer.timeout
	hide()
