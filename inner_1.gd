extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$UpsideDownPlayer.invert_gravity()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
