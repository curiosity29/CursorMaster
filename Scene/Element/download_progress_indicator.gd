extends Control

@onready var percent_label: Label = $VBoxContainer/ColorRect/PercentLabel
@onready var color_rect: ColorRect = $VBoxContainer/ColorRect

func _ready() -> void:
	match State.game_mode:
		State.GameMode.NORMAL:
			State.sec_elapsed.connect(update_visual_normal)
			update_visual_normal()
		State.GameMode.ENDLESS:
			State.sec_elapsed.connect(update_visual_endless)
			update_visual_endless()

func update_visual_normal() -> void:
	var progress_value = State.elapsed_time/State.win_time
	percent_label.text = "%s%%" % int(progress_value * 100)
	color_rect.material.set_shader_parameter("progress", progress_value)


func update_visual_endless() -> void:
	var progress_value = State.elapsed_time/State.win_time
	var file_count: int = int(progress_value)
	progress_value -= file_count
	percent_label.text = "%s + %s%%" % [file_count, int(progress_value * 100)]
	color_rect.material.set_shader_parameter("progress", progress_value)
