extends KinematicBody2D

const SPEED = 45000
const MAX_SPEED = 50000
const FRICTION = 20
const JUMP = -750
const GRAVITY = 5000

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var direction = 1

var hurt = false

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
export (PackedScene) var bullet3
var flag = false

onready var playerHealth = [get_node("/root/Main/HUD/Health1"),
					get_node("/root/Main/HUD/Health2"),
					get_node("/root/Main/HUD/Health3"),
					get_node("/root/Main/HUD/Health4"),
					get_node("/root/Main/HUD/Health5"),
					get_node("/root/Main/HUD/Health6"),
					get_node("/root/Main/HUD/Health7"),
					get_node("/root/Main/HUD/Health8"),
					get_node("/root/Main/HUD/Health9"),
					get_node("/root/Main/HUD/Health10")]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var BPM = 60.0;

var time_begin;
var time_delay = 0;
var time_since_last_shot = 0;

var has_jump = 1;

var lives = 10

var last_delta = 0



# Called when the node enters the scene tree for the first time.
func _ready():

	time_begin = OS.get_ticks_usec();
	animationTree.active = true
	
func _physics_process(delta):
	match state:
		MOVE:
			if lives > 0:
				move_state(delta)
		ROLL:
			pass
		ATTACK:
			if lives > 0:
				attack_state(delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	last_delta = delta
	#if is_colliding():
	#	print(get_collider())
		
	# Obtain from ticks.
	var time = (OS.get_ticks_usec() - time_begin) / 1000000.0;
	# Compensate for latency.
	time -= time_delay;
	# May be below 0 (did not begin yet).
	time = max(0, time);
	
	time_since_last_shot += delta;
		# print(str(time_since_last_shot, ">=", 1.0/bpm*100));
		
	if (Input.is_action_just_pressed("ui_page_up")):
		$Voice.play_score_sound()
			
			
	if (lives > 0 and time_since_last_shot >= 10000.0/BPM*delta):
		time_since_last_shot = 0;
		$Shoot.play_gun()
		shoot();
		BPM += 0.25;
		
func play_score_sound():
	$Voice.play_score_sound()
	
func play_kill_sound():
	$Voice.play_kill_sound()

func play_death_sound():
	$Voice.play_death_sound()
		
func shoot():
	#print(BPM)
	var shot = bullet3.instance()
	shot.set_direction(direction)
	get_node("/root/Main").add_child(shot)
	shot.global_position = self.global_position
	shot.global_position.x += direction * 50.0
	var animation = animationState.get_current_node()
	if (animation == "Idle" || animation == "Idle_Fire"):
		animationState.start("Idle_Fire");
	elif (animation == "Run" || animation == "Run_Fire"):
		animationState.start("Run_Fire");
	elif (animation == "Jump" || animation == "Fall" || animation == "Jump_Fire"):
		animationState.start("Jump_Fire");
	


func move_state(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if (input_vector.x != 0):
		direction = input_vector.x
		
	if (direction != $Sprite.scale.x):
		$Sprite.scale.x = direction;
		
	var animation = animationState.get_current_node()
	if animation == "Run" or animation == "Idle" or animation == "Idle_Fire" or animation == "Run_Fire":
		has_jump = 1;
	else:
		has_jump = 0;
		

	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Move/blend_position", input_vector)
		#animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		velocity.x = min(input_vector.x * SPEED * 0.006, MAX_SPEED * 0.006)
		
	else:
		animationState.travel("Idle")
		velocity = Vector2(velocity.move_toward(Vector2.ZERO, FRICTION).x, velocity.y)
		
	if Input.is_action_just_pressed("ui_up") and has_jump > 0:
		has_jump = 0;
		velocity.y = JUMP
		animationState.travel("Jump");
	else:
		velocity.y += 0.006 * GRAVITY
		
		
	velocity = move_and_slide(velocity)
	
	if (animation == "Jump" and velocity.y == 0):
		animationState.travel("Fall")
	
	if (velocity.y < 0):
		animationState.travel("Jump");
	
	if (velocity.y > 0):
		animationState.travel("Fall")
	
	if Input.is_action_just_pressed("attack"):
		#state = ATTACK
		pass


func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE
	
func set_sprite_position():
	$Sprite.position.x = direction * $Sprite.position.x;


func _on_Player_input_event(viewport, event, shape_idx):
	print("event")
	pass # Replace with function body.
	
func hit():
	if animationState.get_current_node() == "Hurt":
		return
	lives -= 1
	if lives > -1:
		velocity += Vector2(5500*direction, -15000) * 0.006;
		playerHealth[lives].hide()
		animationState.travel("Hurt")
		$Voice.play_hurt_sound()
	print("Lives: " + str(lives))
	if lives < 1:
		play_death_sound()
