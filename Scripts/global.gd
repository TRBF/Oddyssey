extends Node

var level = 0

func _ready():
	pass



func _process(delta):
	pass
	
func next_level():
	level+=1
	
func get_level():
	return level
