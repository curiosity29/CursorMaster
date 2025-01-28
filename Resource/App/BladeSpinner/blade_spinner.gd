extends App

@onready var wave: TextureRect = %Wave

@export var bot_scene: PackedScene
@export var recharge_time: float = 1.55
@export var max_bot_count: int = 32
@onready var bot_container: Control = %BotContainer

var current_bot: OrbittingBlade
func _ready():
	super()
	
	#animation_player.animation_finished.connect(on_recharge_finish)
	recharge_bot()
	
func recharge_bot():
	#print("recharging")
	#animation_player.play("bombRecharge")
	var tween = create_tween()
	tween.tween_method(set_wave_parameter, 0.81, 0.15, recharge_time)
	tween.finished.connect(on_recharge_finish)

func set_wave_parameter(progress_value: float):
	wave.material.set_shader_parameter("progress", progress_value)

func on_recharge_finish():
	## retry when a bot die
	if bot_container.get_child_count() >= max_bot_count:
		bot_container.child_order_changed.connect(on_recharge_finish, CONNECT_ONE_SHOT)
		return
	#print("recharging finish")
	current_bot = bot_scene.instantiate()
	bot_container.add_child(current_bot)
	recharge_bot()
