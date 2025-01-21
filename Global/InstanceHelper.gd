# InstanceHelper
extends Node

var core: Core

const APP_WINDOW = preload("res://Scene/Element/app_window.tscn")

func create_enemy(id: String) -> Enemy:
	var enemy_resource = Database.enemy_map[id]
	var enemy: Enemy = enemy_resource.scene.instantiate()
	enemy.enemy_resource = enemy_resource
	return enemy

func create_app_window(app_name: String = "", max_size: Vector2 = Vector2(300, 300)) -> AppWindow:
	var app_window: AppWindow = APP_WINDOW.instantiate()
	app_window.max_size = max_size
	app_window.app_name = app_name
	return app_window
