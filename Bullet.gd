extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction = Vector2.ZERO
const SPEED = 250;
onready var player = get_node("/root/Main/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_direction(x):
	$Bullet.scale.x = x
	direction.x = x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#direction = direction.move_toward(direction * SPEED, SPEED * delta)
	pass

func _physics_process(delta):
	position.x += direction.x * SPEED * delta


func destroy():
	queue_free()


func _on_Area2D_body_entered(body):
	if body == player:
		body.hit()
		self.destroy()
