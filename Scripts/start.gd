extends CanvasLayer

var level_tracker

# Called when the node enters the scene tree for the first time.
func _ready():
	level_tracker = get_node("/root/LevelTracker")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ground.tscn")
	level_tracker.next_level()
