class_name AppHeader
extends Control

signal close_button_pressed
signal minimize_button_pressed
signal maximize_button_pressed

@onready var app_name_label: RichTextLabel = $HBoxContainer/Grabber/HBoxContainer/AppNameLabel
@onready var grabber: Control = %Grabber


func _on_close_button_pressed() -> void:
	close_button_pressed.emit()

func _on_maximize_button_pressed() -> void:
	maximize_button_pressed.emit()

func _on_minimize_button_pressed() -> void:
	minimize_button_pressed.emit()
