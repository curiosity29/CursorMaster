extends AppWindow


func _on_easy_button_pressed() -> void:
	request_start_run(State.Difficulty.EASY)

func _on_normal_button_pressed() -> void:
	request_start_run(State.Difficulty.NORMAL)
	
func _on_hard_button_pressed() -> void:
	request_start_run(State.Difficulty.HARD)


func request_start_run(difficulty: State.Difficulty):
	State.difficulty = difficulty
	Event.run_start_request.emit()
