extends Node2D


var level_tracker


func _ready():
	$UpsideDownPlayer.invert_gravity()
	level_tracker = get_node("/root/LevelTracker")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_level_area_body_entered(body):
	if(body.name=="UpsideDownPlayer"):
		level_tracker.next_level()
		get_tree().change_scene_to_file("res://Scenes/dual_sky.tscn")
