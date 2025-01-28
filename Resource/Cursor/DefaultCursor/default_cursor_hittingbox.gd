class_name DefaultCursorHittingBox
extends Area2D

@export var damage: int = 20
var heat_cost: float = 0.8
@export var audio_on_hit: AudioStream

signal overheat_malfunction
func _on_area_entered(area: Area2D) -> void:
	if State.heat_value_left < heat_cost:
		## possible hit with not enough cost
		if area.owner is Enemy:
			overheat_malfunction.emit()
		return
	
	## casing heat on successfull hit
	if CombatHelper.damage_area_entered(damage, area):
		State.heat_value += heat_cost
		SoundPlayer.play(audio_on_hit)

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
