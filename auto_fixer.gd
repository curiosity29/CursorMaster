extends App



@export var heal_per_sec: int = 2

func _on_heal_timer_timeout() -> void:
	InstanceHelper.core.health += heal_per_sec
