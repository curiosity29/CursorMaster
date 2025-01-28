class_name EndRun
extends Control


@onready var hidden_text_label: RichTextLabel = %HiddenTextLabel
@onready var reset_button: Button = %ResetButton
@onready var on_win: Control = %OnWin
@onready var on_lose: Control = %OnLose
@onready var blue_background: ColorRect = $BlueBackground
@onready var normal_back_ground: TextureRect = $NormalBackGround
@onready var score_label: Label = %ScoreLabel


var normal_lose_score_text_format: String = \
"""your download progress:
%d%%"""
var endless_lose_score_text_format: String = \
"""your download progress:
%d + %d%%"""

func _ready() -> void:
	if State.run_end_state == State.RunEndState.WIN:
		on_win.show()
		on_lose.hide()
		hidden_text_label.hide()
	else: 
		on_lose.show()
		on_win.hide()
		reset_button.show()
		
		if State.game_mode == State.GameMode.NORMAL:
			score_label.text = normal_lose_score_text_format % int(State.elapsed_time/State.win_time * 100)
		elif State.game_mode == State.GameMode.ENDLESS:
			var progress = State.elapsed_time/State.win_time
			var file_count = int(State.elapsed_time/State.win_time)
			var progress_percent = int((progress - file_count) * 100)
			score_label.text = endless_lose_score_text_format % [file_count, progress_percent]

func _on_prize_button_pressed() -> void:
	hidden_text_label.show()
	reset_button.show()

func _on_reset_button_pressed() -> void:
	Event.exit_to_menu_request.emit()
