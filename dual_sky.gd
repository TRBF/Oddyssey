extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/TextPrompts/WarnSeparation.hide()
	$CanvasLayer/TextPrompts/NextLevelIndication.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fall_prevention_body_entered(body):
	$Player.position = Vector2(25, 850)
#	$Player.velocity = Vector2(0, -150)


func _on_warning_body_entered(body):
	if(body.name == "Player"):
		$CanvasLayer/TextPrompts/WarnSeparation.show()


func _on_warning_body_exited(body):
	if(body.name == "Player"):
		$CanvasLayer/TextPrompts/WarnSeparation.hide()
	

func _on_next_level_instructions_body_entered(body):
	if(body.name == "Player"):
		$CanvasLayer/TextPrompts/NextLevelIndication.show()


func _on_next_level_instructions_body_exited(body):
	if(body.name == "Player"):
		$CanvasLayer/TextPrompts/NextLevelIndication.hide()
