extends Control

@onready var percent_label: Label = $VBoxContainer/ColorRect/PercentLabel
@onready var color_rect: ColorRect = $VBoxContainer/ColorRect

func _ready() -> void:
	State.sec_elapsed.connect(update_visual)
	update_visual()
func update_visual() -> void:
	var progress_value = State.elapsed_time/State.WIN_TIME
	percent_label.text = "%s%%" % int(progress_value * 100)
	color_rect.material.set_shader_parameter("progress", progress_value)
