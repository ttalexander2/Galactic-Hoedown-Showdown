extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var hud = $HUD
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hud.update_score(score)


func killed_mob():
	score += 10
	hud.update_score(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	pass


func _on_ScoreTimer_timeout():
	if $Player.lives > 0:
		score += 1
		hud.update_score(score)
