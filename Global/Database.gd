# Database
extends Node

var _all_enemies = preload("res://Resource/ResourceGroup/all_enemies.tres")
var all_enemies: Array[EnemyResource]
var enemy_map: Dictionary[String, EnemyResource]

var _all_cursors = preload("res://Resource/ResourceGroup/all_cursors.tres")
var all_cursors: Array[CursorManagerResource]
var cursor_map: Dictionary[String, CursorManagerResource]

var _all_apps = preload("res://Resource/ResourceGroup/all_apps.tres")
var all_apps: Array[AppResource]
var app_map: Dictionary[String, AppResource]
var shop_app_map: Dictionary[String, AppResource]


func _ready() -> void:
	_all_enemies.load_all_into(all_enemies)
	for enemy_resource: EnemyResource in all_enemies:
		enemy_map[enemy_resource.id] = enemy_resource
	_all_cursors.load_all_into(all_cursors)
	
	_all_enemies.load_all_into(all_enemies)
	for cursor_resource: CursorManagerResource in all_cursors:
		cursor_map[cursor_resource.id] = cursor_resource
		
	_all_apps.load_all_into(all_apps)
	for app_resource: AppResource in all_apps:
		app_map[app_resource.id] = app_resource
		if app_resource.is_for_sale: 
			shop_app_map[app_resource.id] = app_resource
		
func reset_app_resource():
	shop_app_map.clear()
	for app_resource: AppResource in all_apps:
		app_resource.reset_values()
		if app_resource.is_for_sale: 
			shop_app_map[app_resource.id] = app_resource	
