class_name CursorApp
extends App

func on_open():
	State.cursor_manager = Database.cursor_map[app_resource_id]
	
