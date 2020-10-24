extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500
const JUMP = -500
const GRAVITY = 1000.0

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	animationTree.active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	move_state(delta)
	pass


func move_state(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Move/blend_position", input_vector)
		#animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Move")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = JUMP
	else:
		velocity.y += delta * GRAVITY
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		#state = ATTACK
		pass

func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE
