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

@onready var check_box_button: CheckButton = $MarginContainer/VBoxContainer/Body/VBoxContainer/HBoxContainer5/CheckBoxButton


func _ready() -> void:
	State.game_mode = State.GameMode.NORMAL
func _on_check_box_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		check_box_button.text = "Yes"
		State.game_mode = State.GameMode.ENDLESS
	else:
		check_box_button.text = "No"
		State.game_mode = State.GameMode.NORMAL
