extends KinematicBody2D

const ACCELERATION = 10000
const MAX_SPEED = 25
const SPEED = 24
const FRICTION = 1
const JUMP = -500
const GRAVITY = 1000.0

const TIME_BETWEEN_SHOTS = 2.5
const TIME_BETWEEN_BULLETS = 0.1

var velocity = Vector2.ZERO
var direction = -1

export (PackedScene) var bullet 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerDirection
onready var player = get_node("/root/Main/Player")
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var main = get_node("/root/Main")


var shooting = false
var second_shot = false
var time_to_shoot = 0
var time_till_second_shot = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	animationState.start("Walk")
	
func shoot():
	var dir = round((player.position - position).normalized().x)
	if (dir != 0):
		direction = dir
	var shot = bullet.instance()
	shot.set_direction(direction)
	get_node("/root/Main").add_child(shot)
	shot.global_position = self.global_position
	
func die():
	main.killed_mob()
	self.queue_free();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playerDirection = (player.position - position).normalized() * MAX_SPEED
	#print(playerDirection)
	var animation = animationState.get_current_node()
		
	if animation == "Walk":
		velocity = Vector2(velocity.move_toward(playerDirection * MAX_SPEED * delta * SPEED, ACCELERATION * delta).x, velocity.y)
		var dir = round(velocity.normalized().x);
		if dir != 0:
			direction = dir
		
	else:
		velocity = Vector2.ZERO
	
	velocity.y += delta * GRAVITY
	velocity = move_and_slide(velocity)

	if ($Sprite.scale.x != direction):
		$Sprite.scale.x = direction;
		$Sprite.position.x = $Sprite.position.x * direction;
		

	if animation == "Walk" and shooting == true:
		animationState.travel("Draw");
	if animation == "Shoot" and shooting == true:
		shooting = false
		second_shot = true
		time_to_shoot = 0
		shoot()
		
	if animation == "Shoot" and shooting == false and second_shot:
		time_till_second_shot += delta
		if (time_till_second_shot >= TIME_BETWEEN_BULLETS):
			shoot()
			second_shot = false
			time_till_second_shot = 0

		
	time_to_shoot += delta
	if time_to_shoot >= TIME_BETWEEN_SHOTS:
		time_to_shoot = 0
		time_till_second_shot = 0
		shooting = true
		second_shot = true
	
	#velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
