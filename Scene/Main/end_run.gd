class_name EndRun
extends Control


@onready var hidden_text_label: RichTextLabel = %HiddenTextLabel
@onready var reset_button: Button = %ResetButton
@onready var on_win: Control = %OnWin
@onready var on_lose: Control = %OnLose


func _ready() -> void:
	if State.run_end_state == State.RunEndState.WIN:
		on_win.show()
	else: 
		on_lose.show()
		reset_button.show()
	
func _on_prize_button_pressed() -> void:
	hidden_text_label.visible = !hidden_text_label.visible
	reset_button.show()

func _on_reset_button_pressed() -> void:
	Event.exit_to_menu_request.emit()
