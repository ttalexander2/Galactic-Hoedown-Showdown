extends KinematicBody2D

const ACCELERATION = 250
const MAX_SPEED = 250
const SPEED = 30
const FRICTION = 500
const JUMP = -500
const GRAVITY = 1000.0

var velocity = Vector2.ZERO
var direction = -1

export (PackedScene) var bullet 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerDirection
onready var player = get_node("/root/Main/Player")
onready var shootingTime = $ShootingTime
onready var betweenShots = $BetweenShots
var shooting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	betweenShots.start()

func aim():
	print("aiming")
	shooting = true
	shootingTime.start()
	
func shoot():
	direction = (player.position - position).normalized().x
	var shot = bullet.instance()
	shot.set_direction(direction)
	get_node("/root/Main").add_child(shot)
	shot.global_position = self.global_position
	
func move():
	shoot()
	shooting = false
	betweenShots.start()
	
func die():
	self.queue_free();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playerDirection = (player.position - position).normalized() * MAX_SPEED
	#print(playerDirection)
		
	if !shooting:
		velocity = velocity.move_toward(playerDirection * MAX_SPEED * delta * SPEED, ACCELERATION * delta)
		direction = velocity.x
		
	else:
		velocity = Vector2.ZERO
	
	velocity.y += delta * GRAVITY
	velocity = move_and_slide(velocity)
	


	
	#velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
