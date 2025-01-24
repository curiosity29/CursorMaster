class_name TaskManager
extends Control

@export var bytecoin_texture: Texture

@onready var heat_label: Label = %HeatLabel
@onready var ram_label: Label = %RamLabel
@onready var coin_label: RichTextLabel = %CoinLabel

@onready var heat_display: ColorRect = %Heat
@onready var ram_display: ColorRect = %Ram

const heat_label_format = "%.1f°C away from %.1f°C"
const ram_label_format = "%.1f MB free of %.1f MB"
var coin_label_format: String

func _ready() -> void:
	coin_label_format = "%d" + "[img=32]%s[/img]" % bytecoin_texture.resource_path
	State.task_stats_changed.connect(update_display)
	update_display()
func _exit_tree() -> void:
	State.task_stats_changed.disconnect(update_display)

func update_display():
	coin_label.text = coin_label_format % State.bytecoin
	heat_label.text = heat_label_format % [State.heat_value_left, State.max_heat_value]
	ram_label.text = ram_label_format % [State.ram_value_left, State.max_ram_value]
	heat_display.material.set_shader_parameter("progress", State.heat_value/State.max_heat_value)
	ram_display.material.set_shader_parameter("progress", State.ram_value/State.max_ram_value)
	
