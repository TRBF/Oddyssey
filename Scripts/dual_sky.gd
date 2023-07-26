extends Node2D

var level_tracker 

# Called when the node enters the scene tree for the first time.
func _ready():
	level_tracker = get_node("/root/LevelTracker")
	$CanvasLayer/TextPrompts/WarnSeparation.hide()
	$CanvasLayer/TextPrompts/NextLevelIndication.hide()
	$CanvasLayer/TextPrompts/FinalLevelIndication.hide()
	if(level_tracker.get_level()!=2):
		ud_ready()
	else:
		normal_ready()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fall_prevention_body_entered(body):
	if body.name == "Player":
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


func _on_next_level_area_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Scenes/inner_1.tscn")
		level_tracker.next_level()

func normal_ready():
	$UpsideDownPlayer.queue_free()
	$UDSkyBG.queue_free()

func ud_ready():
	$UpsideDownPlayer.invert_gravity()
#	$UpsideDownPlayer.position = Vector2(1500, 0)
	$Player.queue_free()
	$DualSkyBG.queue_free()



func _on_udc_fall_prevention_body_entered(body):
	if body.name == "UpsideDownPlayer":
		$UpsideDownPlayer.position = Vector2(1325, 170)


func _on_udc_5_area_area_entered(area):
	$CanvasLayer/TextPrompts/FinalLevelIndication.show()
	print("eewe")


func _on_udc_5_area_body_entered(body):
	$CanvasLayer/TextPrompts/FinalLevelIndication.show()
	print("eewe")


func _on_udc_5_area_body_exited(body):
	$CanvasLayer/TextPrompts/FinalLevelIndication.hide()


func _on_final_level_area_body_entered(body):
	get_tree().change_scene_to_file("Scenes/ending.tscn")

