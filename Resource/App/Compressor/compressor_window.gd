extends AppWindow


@onready var compress_area: Area2D = %CompressArea
@onready var collision_shape_2d: CollisionShape2D = $MarginContainer/VBoxContainer/Body/CompressArea/CollisionShape2D
var target_enemies: Array[Enemy] = []
var compress_y_acceleration: float = 100.
@onready var pull_timer: Timer = $PullTimer
@export var max_pull_count: int = 8
func _ready() -> void:
	super()
	#resize_hitting_box()
	#header.close_button.
	
func resize_hitting_box():
	var rectangle = RectangleShape2D.new()
	rectangle.size = body.size
	collision_shape_2d.shape = rectangle
	collision_shape_2d.position = rectangle.size/2



func _on_compress_area_body_entered(col_body: Node2D) -> void:
	if col_body is Enemy:
		target_enemies.append(col_body as Enemy)
func _on_compress_area_body_exited(col_body: Node2D) -> void:
	col_body = col_body as Enemy
	if col_body in target_enemies:
		target_enemies.erase(col_body)

var enemy_to_erase: Array[Enemy]
#func _process(delta: float) -> void:


func top_n_custom(array: Array, callable: Callable, n: int = 1):
	if array.size() <= n: return array
	array.sort_custom(callable)
	return array.slice(0, n)
func enemy_closer_to_center_y(enemy_1: Enemy, enemy_2: Enemy):
	var body_center: Vector2 = body.global_position + body.size/2
	if abs(enemy_1.global_position.y - body_center.y) < abs(enemy_1.global_position.y - body_center.y):
		return true
	return false
	
func _on_pull_timer_timeout() -> void:
	var body_center: Vector2 = body.global_position + body.size/2
	enemy_to_erase.clear()
	for enemy: Enemy in top_n_custom(target_enemies, enemy_closer_to_center_y, max_pull_count):
		if enemy:
			var delta_y = enemy.global_position.y - body_center.y
			enemy.velocity.y += -delta_y / pull_timer.wait_time * 0.8
		## erase null 
		else: 
			enemy_to_erase.append(enemy)
			
	for enemy: Enemy in enemy_to_erase:
		target_enemies.erase(enemy)

func _on_body_resized() -> void:
	resize_hitting_box()
