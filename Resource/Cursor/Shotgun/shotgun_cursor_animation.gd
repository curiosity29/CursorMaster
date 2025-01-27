extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var damage: int = 25
func _ready() -> void:
	animation_player.play("damageEffect")

func damge_enemy_in_area():
	for enemy: Enemy in get_tree().get_nodes_in_group("Enemy"):
		if overlaps_body(enemy):
			enemy.take_damage(damage)
