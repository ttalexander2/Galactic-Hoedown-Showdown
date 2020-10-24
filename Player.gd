extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const BPM = 130.0;

var time_begin;
var time_delay = 0;
var time_since_last_shot = 0;





# Called when the node enters the scene tree for the first time.
func _ready():
	time_begin = OS.get_ticks_usec();


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	# Obtain from ticks.
	var time = (OS.get_ticks_usec() - time_begin) / 1000000.0;
	# Compensate for latency.
	time -= time_delay;
	# May be below 0 (did not begin yet).
	time = max(0, time);
	
	time_since_last_shot += delta;
	
	
	
		# print(str(time_since_last_shot, ">=", 1.0/bpm*100));
	
	if (time_since_last_shot >= 10000.0/BPM*delta):
		time_since_last_shot = 0;
		shoot();

		
func shoot():
	print(BPM)
