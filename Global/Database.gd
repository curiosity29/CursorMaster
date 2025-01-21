# Database
extends Node

var _all_enemies = preload("res://Resource/ResourceGroup/all_enemies.tres")
var all_enemies: Array[EnemyResource]
var enemy_map: Dictionary[String, EnemyResource]

var _all_cursors = preload("res://Resource/ResourceGroup/all_cursors.tres")
var all_cursors: Array[CursorManagerResource]
var cursor_map: Dictionary[String, CursorManagerResource]


func _ready() -> void:
	_all_enemies.load_all_into(all_enemies)
	_all_cursors.load_all_into(all_cursors)
	
	for enemy_resource: EnemyResource in all_enemies:
		enemy_map[enemy_resource.id] = enemy_resource
	for cursor_resource: CursorManagerResource in all_cursors:
		cursor_map[cursor_resource.id] = cursor_resource
		
	pass
