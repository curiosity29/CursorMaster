class_name Shop
extends Control

@onready var app_container: VBoxContainer = $VBoxContainer/AppContainer
const app_count: int = 3
const ram_upgrade_cost: int = 5
const ram_upgrade_value: float = 16.
@onready var refresh_count_down_label: RichTextLabel = $VBoxContainer/RefreshCountDownLabel
@onready var second_timer: Timer = $SecondTimer
var max_count_down_time: int = State.second_per_round
var count_down_time: int = max_count_down_time
const count_down_label_format: String = "refresh after %d secs"
func _ready() -> void:
	second_timer.start()
	refresh_shop()


func refresh_shop():

	#app_container.add_child()
	var random_app_resources = pick_n_random(
		Database.shop_app_map.values(), Database.shop_app_map.size()
	) as Array[AppResource]
	for index in app_count:
		var app_resource = random_app_resources[index]
		
		var child = app_container.get_child(index) as AppShopItem
		child.show()
		child.app_resource = random_app_resources[index]
		
func pick_n_random(array: Array, n: int = app_count) -> Array:
	var picked_array = []
	for index in n:
		picked_array.append(array.pop_at(randi_range(0, array.size()-1)))
	return picked_array


func _on_ram_upgrade_button_pressed() -> void:
	if State.bytecoin < ram_upgrade_cost: return
	State.bytecoin -= ram_upgrade_cost
	State.max_ram_value += ram_upgrade_value


func _on_second_timer_timeout() -> void:
	decrease_countdown()

func decrease_countdown():
	count_down_time -= 1
	if count_down_time == 0:
		refresh_shop()
		count_down_time = max_count_down_time
		
	refresh_count_down_label.text = count_down_label_format % count_down_time
