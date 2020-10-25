extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tobLogo = $Sprite
var readyToStart = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$PresentsLabel.hide()
	$TitleLabel.hide()
	$AnimationPlayer.play("LogoFadeIn")


func presents():
	$PresentsLabel.show()
	
func title():
	$LogoSprite.hide()
	$PresentsLabel.hide()
	$TitleLabel.show()
	readyToStart = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if readyToStart:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene("res://Main.tscn")
