#AnimationHelper
extends Node

const DAMAGE_INDICATOR = preload("res://Scene/Element/damage_indicator.tscn")

func spawn_damage_indicator(value: int, global_pos: Vector2):
	var damage_indicator = DAMAGE_INDICATOR.instantiate()
	get_tree().current_scene.add_child(damage_indicator)
	damage_indicator.set_damage_value(value)
	damage_indicator.global_position = global_pos
