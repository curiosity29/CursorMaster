class_name DamageArea
extends Area2D

@export var damage: int = 1
func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(area: Area2D) -> void:
	CombatHelper.damage_area_entered(damage, area)
