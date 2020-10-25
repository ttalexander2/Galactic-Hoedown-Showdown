extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var enemy

onready var hud = $HUD
var score = 0

var score_achieved = [
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
]

var rng = RandomNumberGenerator.new()
onready var player = get_node("/root/Main/Player")
onready var playerSpawn = [get_node("/root/Main/Player/Spawn0"),
					get_node("/root/Main/Player/Spawn1"),
					get_node("/root/Main/Player/Spawn2"),
					get_node("/root/Main/Player/Spawn3")]

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
	if !score_achieved[9] and score >= 1000:
		score_achieved[9] = true
		player.play_score_sound()
		$EnemySpawnTimer.wait_time /= 2
	elif !score_achieved[9] and score >= 900:
		score_achieved[8] = true
		player.play_score_sound()
		$EnemySpawnTimer.wait_time /= 2
	elif !score_achieved[7] and score >= 800:
		score_achieved[7] = true
		player.play_score_sound()
		$EnemySpawnTimer.wait_time /= 2
	elif !score_achieved[6] and score >= 700:
		score_achieved[6] = true
		player.play_score_sound()
		$EnemySpawnTimer.wait_time /= 2
	elif !score_achieved[5] and score >= 600:
		score_achieved[5] = true
		player.play_score_sound()
		$EnemySpawnTimer.wait_time /= 2
	elif !score_achieved[4] and score >= 500:
		score_achieved[4] = true
		player.play_score_sound()
		$EnemySpawnTimer.wait_time /= 2
	elif !score_achieved[3] and score >= 400:
		score_achieved[3] = true
		player.play_score_sound()
		$EnemySpawnTimer.wait_time /= 2
	elif !score_achieved[2] and score >= 300:
		score_achieved[2] = true
		player.play_score_sound()
		$EnemySpawnTimer.wait_time = 2
	elif !score_achieved[1] and score >= 200:
		score_achieved[1] = true
		player.play_score_sound()
		$EnemySpawnTimer.wait_time = 3
	elif !score_achieved[0] and score >= 100:
		score_achieved[0] = true
		player.play_score_sound()
		$EnemySpawnTimer.wait_time = 3.5


func _on_ScoreTimer_timeout():
	if $Player.lives > 0:
		score += 1
		hud.update_score(score)

func spawnEnemies():
	var index = rng.randi_range(0,3)
	var bg = enemy.instance()
	get_node("/root/Main").add_child(bg)
	bg.global_position = playerSpawn[index].global_position
