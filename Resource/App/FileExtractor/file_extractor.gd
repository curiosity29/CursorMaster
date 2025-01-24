extends App
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wave: TextureRect = $Wave

@export var bomb_scene: PackedScene
const recharge_time: float = 10.
var current_bomb: Bomb
func _ready():
	super()
	
	#animation_player.animation_finished.connect(on_recharge_finish)
	recharge_bomb()
	
func recharge_bomb():
	#print("recharging")
	#animation_player.play("bombRecharge")
	var tween = create_tween()
	tween.tween_method(set_wave_parameter, 0.81, 0.15, recharge_time)
	tween.finished.connect(on_recharge_finish)

func set_wave_parameter(progress_value: float):
	wave.material.set_shader_parameter("progress", progress_value)

func on_recharge_finish():
	#print("recharging finish")
	current_bomb = bomb_scene.instantiate()
	add_child(current_bomb)
	current_bomb.position += Vector2.RIGHT * (current_bomb.size.x + 10)
	recharge_bomb()
