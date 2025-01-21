extends App

func on_open() -> void:
	State.cursor_manager = Database.cursor_map["default"]
