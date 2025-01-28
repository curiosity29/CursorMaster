class_name Shop
extends Control

@onready var app_container: VBoxContainer = $VBoxContainer/AppContainer
const app_count: int = 3
const ram_upgrade_cost: int = 5
@export var ram_upgrade_value: float = 16.
@export var cool_speed_upgrade_value: float = 0.3
const cool_speed_upgrade_cost: int = 5
@onready var refresh_count_down_label: RichTextLabel = $VBoxContainer/RefreshCountDownLabel
@onready var second_timer: Timer = $SecondTimer
var max_count_down_time: int = State.second_per_round
var count_down_time: int = max_count_down_time
const count_down_label_format: String = "refresh after %d secs"

@export var refresh_shop_sound: AudioStream

func _ready() -> void:
	second_timer.start()
	refresh_shop(false)

func refresh_shop(do_play_sound: bool = true):
	var app_left_to_display: int = min(app_count, Database.shop_app_map.size())
	#app_container.add_child()
	var random_app_resources = pick_n_random(
		Database.shop_app_map.values(), app_left_to_display
	) as Array[AppResource]
	for index in app_count:
		var child = app_container.get_child(index) as AppShopItem
		child.show()
		
		if index >= app_left_to_display:
			child.is_sold_out = true
			continue
		var app_resource = random_app_resources[index]
		child.app_resource = random_app_resources[index]
	
	if do_play_sound:
		SoundPlayer.play(refresh_shop_sound)
	
func pick_n_random(array: Array, n: int = app_count) -> Array:
	var picked_array = []
	for index in n:
		picked_array.append(array.pop_at(randi_range(0, array.size()-1)))
	return picked_array


func _on_ram_upgrade_button_pressed() -> void:
	if State.bytecoin < ram_upgrade_cost: return
	State.bytecoin -= ram_upgrade_cost
	State.max_ram_value += ram_upgrade_value
	
func _on_cooler_upgrade_button_pressed() -> void:
	if State.bytecoin < cool_speed_upgrade_cost: return
	State.bytecoin -= cool_speed_upgrade_cost
	State.heat_reduction_speed += 0.3


func _on_second_timer_timeout() -> void:
	decrease_countdown()

func decrease_countdown():
	count_down_time -= 1
	if count_down_time == 0:
		refresh_shop()
		count_down_time = max_count_down_time
		
	refresh_count_down_label.text = count_down_label_format % count_down_time
