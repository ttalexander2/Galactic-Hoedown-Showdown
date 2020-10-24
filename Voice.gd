extends AudioStreamPlayer2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var samples_on_kill = {
	"1.01": preload("res://assets/voice-lines/Cyborg Tommy - 1.01 - Yeehaw.wav"),
	"1.02": preload("res://assets/voice-lines/Cyborg Tommy - 1.02 - Draw.wav"),
	"1.03": preload("res://assets/voice-lines/Cyborg Tommy - 1.03 - Oh my goodness.wav"),
	"1.04": preload("res://assets/voice-lines/Cyborg Tommy - 1.04 Skedaddle.wav"),
	"1.05": preload("res://assets/voice-lines/Cyborg Tommy - 1.05 Pony Up.wav"),
	"1.06": preload("res://assets/voice-lines/Cyborg Tommy - 1.06 Blowhard.wav"),
	"1.07": preload("res://assets/voice-lines/Cyborg Tommy - 1.07 Dreadful.wav"),
	"1.08": preload("res://assets/voice-lines/Cyborg Tommy - 1.08 Mudsil.wav"),
	"1.09": preload("res://assets/voice-lines/Cyborg Tommy - 1.09 Heheh Rich.wav"),
	"1.10": preload("res://assets/voice-lines/Cyborg Tommy - 1.10 R I P.wav"),
	"1.11": preload("res://assets/voice-lines/Cyborg Tommy - 1.11 Shoddy.wav"),
	"1.12": preload("res://assets/voice-lines/Cyborg Tommy - 1.12 Belly-up!.wav"),
	"1.13": preload("res://assets/voice-lines/Cyborg Tommy - 1.13 Corncracker.wav"),
	"1.14": preload("res://assets/voice-lines/Cyborg Tommy - 1.14 Whup.wav"),
	"1.15": preload("res://assets/voice-lines/Cyborg Tommy - 1.15 Yup.wav"),
	"1.16": preload("res://assets/voice-lines/Cyborg Tommy - 1.16 Bite the groud!.wav"),
	"1.17": preload("res://assets/voice-lines/Cyborg Tommy - 1.17 Yaw.wav"),
}

var samples_on_score = [
	preload("res://assets/voice-lines/Cyborg Tommy - 2.01 Hill of Beans.wav"),
	preload("res://assets/voice-lines/Cyborg Tommy - 2.02 Get a Wiggle On.wav"),
	preload("res://assets/voice-lines/Cyborg Tommy - 2.03 You can slide mistr.wav"),
	preload("res://assets/voice-lines/Cyborg Tommy - 2.04 Bed 'em down.wav"),
	preload("res://assets/voice-lines/Cyborg Tommy - 2.05 Tromped his britchs real good.wav"),
	preload("res://assets/voice-lines/Cyborg Tommy - 2.06 I love this song.wav"),
	preload("res://assets/voice-lines/Cyborg Tommy - 2.07 Who taught y'all how to shoot.wav"),
	preload("res://assets/voice-lines/Cyborg Tommy - 2.08 This town ain big nuff.wav"),
	preload("res://assets/voice-lines/Cyborg Tommy - 2.09 Ornery as a mama bear.wav"),
	preload("res://assets/voice-lines/Cyborg Tommy - 2.10 Fastest Gun in the West.wav"),
]

var samples_on_death = {
	"3.00": preload("res://assets/voice-lines/Cyborg Tommy - 3.00 - Hill of bees.wav"),
	"3.01": preload("res://assets/voice-lines/Cyborg Tommy - 3.01 Don't let your yearnings.wav"),
	"3.02": preload("res://assets/voice-lines/Cyborg Tommy - 3.02 Boot Licker.wav"),
	"3.03": preload("res://assets/voice-lines/Cyborg Tommy - 3.03 I'll b back.wav"),
	"3.04": preload("res://assets/voice-lines/Cyborg Tommy - 3.04 Highflautin no-gooder.wav"),
	"3.05": preload("res://assets/voice-lines/Cyborg Tommy - 3.05 Dirty sneaking polecats.wav"),
	"3.06": preload("res://assets/voice-lines/Cyborg Tommy - 3.06 HHUUUUUUH.wav"),
	"3.07": preload("res://assets/voice-lines/Cyborg Tommy - 3.07 Meat and tata.wav"),
	"3.08": preload("res://assets/voice-lines/Cyborg Tommy - 3.08 Nary....wav"),
	"3.09": preload("res://assets/voice-lines/Cyborg Tommy - 3.09 Sorta nice aint't it.wav"),
	"3.10": preload("res://assets/voice-lines/Cyborg Tommy - 3.10 Uselss as a bull with tits.wav"),
	"3.11": preload("res://assets/voice-lines/Cyborg Tommy - 3.11 Unsaltd waddie.wav"),
	"3.12": preload("res://assets/voice-lines/Cyborg Tommy - 3.12 Rode hard and put up wet.wav"),
}

var score_sound = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	score_sound = 0;


func play_kill_sound():
	var sound = samples_on_kill.keys()[randi() % samples_on_kill.keys().size()]
	stream = samples_on_kill[sound]
	play()
	
func play_score_sound():
	stream = samples_on_score[score_sound]
	score_sound += 1;
	play()
	
func play_death_sound():
	var sound = samples_on_death.keys()[randi() % samples_on_death.keys().size()]
	stream = samples_on_death[sound]
	play()
	
