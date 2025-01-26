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
const min_pc_heat_offset: float = 40.
var coin_label_format: String

func _ready() -> void:
	coin_label_format = "%d" + "[img=32]%s[/img]" % bytecoin_texture.resource_path
	State.task_stats_changed.connect(update_display)
	update_display()
	InstanceHelper.task_manager = self
func _exit_tree() -> void:
	State.task_stats_changed.disconnect(update_display)

func update_display():
	coin_label.text = coin_label_format % State.bytecoin
	heat_label.text = heat_label_format % [State.heat_value_left, State.max_heat_value + min_pc_heat_offset]
	ram_label.text = ram_label_format % [State.ram_value_left, State.max_ram_value]
	heat_display.material.set_shader_parameter("progress", State.heat_value/State.max_heat_value)
	ram_display.material.set_shader_parameter("progress", State.ram_value/State.max_ram_value)
	

#region speed mode
@onready var speed_label: Label = $HBoxContainer/VBoxContainer/SpeedController/SpeedLabel
enum SpeedMode {PAUSED, HALF, NORMAL, DOUBLE}
var speed_mode: SpeedMode = SpeedMode.NORMAL:
	set(value):
		speed_mode = value
		get_tree().paused = false
		match speed_mode:
			SpeedMode.PAUSED:
				get_tree().paused = true
				speed_label.text = "0X"
			SpeedMode.HALF:
				Engine.time_scale = 0.5
				speed_label.text = "0.5X"
			SpeedMode.NORMAL:
				Engine.time_scale = 1.
				speed_label.text = "1X"
			SpeedMode.DOUBLE:
				Engine.time_scale = 2.
				speed_label.text = "2X"
		
func _on_pause_button_pressed() -> void:
	speed_mode = SpeedMode.PAUSED
func _on_speedup_button_pressed() -> void:
	## pause -> x0.5 -> x1 -> x2
	match speed_mode:
		SpeedMode.DOUBLE:
			pass
		SpeedMode.NORMAL:
			speed_mode = SpeedMode.DOUBLE
		SpeedMode.HALF:
			speed_mode = SpeedMode.NORMAL
		SpeedMode.PAUSED:
			speed_mode = SpeedMode.HALF
#endregion

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if speed_mode == SpeedMode.PAUSED:
			speed_mode = SpeedMode.NORMAL
		else:
			speed_mode = SpeedMode.PAUSED
