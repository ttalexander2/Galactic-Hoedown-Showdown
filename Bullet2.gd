extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction = Vector2.ZERO
const SPEED = 1000;

func set_direction(x):
	direction.x = x

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	position.x += direction.x * SPEED * delta
	
func destroy():
	queue_free()
