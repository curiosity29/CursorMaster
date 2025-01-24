extends Area2D

var damage: int = 5

func _on_area_entered(area: Area2D) -> void:
	CombatHelper.damage_area_entered(damage, area)

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
