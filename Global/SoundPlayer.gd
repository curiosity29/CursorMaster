#class_name BaseSoundPlayer
extends Node

static var add_max_db = 0.
static var add_min_db = -20.
static var add_max_linear_db: float
static var add_min_linear_db: float

var setting_volume_db: float:
	get:
		return get_setting_volume_db()
		
func get_setting_volume_db() -> float:
	return State.master_volume
	

func _ready():
	add_max_linear_db = db_to_linear(add_max_db)
	add_min_linear_db = db_to_linear(add_min_db)

func play(audio: AudioStream, single: bool = false, adjusted_volumb_db: float = 0.):
	if not audio:
		return
	
	if single:
		stop()
	
	for player: AudioStreamPlayer in get_children():
		if not player.playing:
			player.volume_db = setting_volume_db + adjusted_volumb_db
			player.stream = audio
			player.play()
			break

func play_energy(audio: AudioStream, single: bool = false, 
		energy_factor: float = 0.5):
			
	energy_factor = clamp(energy_factor, 0, 1)
	var volumb_db = linear_to_db(lerp(add_min_linear_db, add_max_linear_db, energy_factor))
	play(audio, single, volumb_db)
	

func stop():
	for player: AudioStreamPlayer in get_children():
		player.stop()
