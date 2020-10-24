extends Node2D

onready var screen_size = Vector2(640, 360)
onready var player = get_parent().get_node("Player")

const HORIZONTAL_OFFSET = 200

var new_position = Vector2()
var player_pos = Vector2()


func _ready():
	update_camera()

func _fixed_process(delta):
	update_camera()

func update_camera():
	if player:
		var canvas_transform = get_viewport().get_canvas_transform()
		player_pos = player.position
		new_position = -player_pos + screen_size / 2
		new_position.x -= HORIZONTAL_OFFSET
		new_position.y = canvas_transform[2].y
		canvas_transform[2] = new_position
		get_viewport().set_canvas_transform(canvas_transform)
