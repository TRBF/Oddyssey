extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fall_prevention_body_entered(body):
	$Player.position = Vector2(25, 850)
#	$Player.velocity = Vector2(0, -150)
