extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var sfx = [
	preload("res://assets/gun_1.wav"),
	preload("res://assets/gun_2.wav"),
	preload("res://assets/gun_3.wav"),
	preload("res://assets/gun_4.wav"),
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func play_gun():
	stream = sfx[randi()%4]
	play()
