extends ParallaxBackground

var mod = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(scroll_base_offset.x <= -400):
		mod = 1
	elif(scroll_base_offset.x >= 0):
		mod = -1
	scroll_base_offset += mod * Vector2(50, 0) * delta
	
