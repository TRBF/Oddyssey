extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -700.0
var GDIR = 1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var finished_playing = {}
var anim_names = ["Air Dash", "Attack1", "Attack2", "Attack3", "AttackHeavy",
 "Block", "Dash", "Death", "Idle", "JumpAsc", "JumpAttack1", "JumpAttack2",
 "JumpAttack3", "JumpDesc", "JumpFlip", "JumpPrepare", "Knockback", "Run",
 "RunEnd"]

var attacking_anims = ["Attack1", "Attack2", "Attack3", "AttackHeavy",
"Block", "JumpAttack1", "JumpAttack2", "JumpAttack3"]
var attacking_coolodowns = {
	
} 

var last_ran:String

var position_corrected = 0
var c = 0
var direction
var time = 0

var jumptime = 0
var jumpmax = 0.5

func _ready():
	for name in anim_names:
		finished_playing[name] = 0

func _physics_process(delta):
	time += delta
	Input.is_action_pressed("game_jump")
	if not is_on_floor() and !is_attacking():
		velocity.y += gravity * delta * GDIR
	
	if(time-jumptime>jumpmax && jumptime!=0):
		velocity.y = JUMP_VELOCITY * GDIR
		jumptime = 0
	
	if jumptime == 0 and velocity.y * GDIR==0 and Input.is_action_pressed("game_jump") and is_on_floor() and !is_attacking():
		jumptime = time
	elif jumptime!=0 and not Input.is_action_pressed("game_jump"):
		velocity.y = JUMP_VELOCITY * (time-jumptime) / jumpmax * GDIR
		jumptime = 0

	if Input.is_action_pressed("game_jump") and is_on_floor():
		runanim("JumpPrepare")
	
	if is_on_floor():
		direction = Input.get_axis("game_left", "game_right")
	if is_on_wall_only():
		direction *= -1
		runanim("Knockback")
	if direction and not(Input.is_action_pressed("game_jump") and is_on_floor()):
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if($AnimationPlayer.current_animation != "Knockback"):
		if(velocity.x>0):
			get_node("AnimatedPlayer2D").flip_h = false
		if(velocity.x<0):
			get_node("AnimatedPlayer2D").flip_h = true
	if(velocity.y==0):
		if(velocity.x!=0):
			runanim("Run")
		else:
			if_animation_running_play("Run", "RunEnd", "Idle")
		if(not $AnimationPlayer.is_playing()):
			runanim("Idle")
	elif(velocity.y * GDIR<0 and $AnimationPlayer.current_animation != "Knockback"):
		runanim("JumpAsc")
	elif(velocity.y * GDIR>0 and $AnimationPlayer.current_animation != "Knockback"):
		if(last_ran != "JumpDesc"):
			runanim("JumpDesc")
		
	
	
	
	move_and_slide()



func _on_animation_player_animation_finished(animation_name):
	finished_playing[animation_name] = 1
	last_ran = animation_name

func runanim(animation_name: String):
	$AnimationPlayer.play(animation_name)
	finished_playing[animation_name] = 0

func if_animation_running_play(current_anim_name: String, target_anim_name: String, default_anim_name := current_anim_name):
	if($AnimationPlayer.current_animation == current_anim_name):
		finished_playing[current_anim_name] = 1
		runanim(target_anim_name)
	else:
		if(finished_playing[target_anim_name] == 1): 
			runanim(default_anim_name)

func is_attacking():
	var detected = false
	for attack in attacking_anims:
		if $AnimationPlayer.current_animation == attack:
			detected = true

func invert_gravity():
	GDIR = -1 * GDIR
