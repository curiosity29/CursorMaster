extends Area2D

@export var damage: int = 20
var heat_cause: float = 0.3
func _on_area_entered(area: Area2D) -> void:

	if State.heat_value_left < heat_cause: return
	
	## casing heat on successfull hit
	if CombatHelper.damage_area_entered(damage, area):
		State.heat_value += heat_cause

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
