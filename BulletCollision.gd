extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.contact_monitor = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	var collisions = self.get_colliding_bodies();
	for body in collisions:
		print(body)
		if (body.is_in_group("Enemies")):
			body.die();
			self.get_parent().destroy();
