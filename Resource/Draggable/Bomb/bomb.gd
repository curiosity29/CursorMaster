class_name Bomb
extends Draggable

@export var blowup_delay: float = 5.
@export var blowup_radius: float = 64 * 5
@export var damage: int = 100
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var second_countdown_timer: Timer = $SecondCountdownTimer
@onready var damage_effect_texture_rect: TextureRect = $DamageEffectTextureRect
@onready var second_label: Label = $SecondLabel

var second_left: int
func _ready() -> void:
	super()
	var timer = Timer.new()
	add_child(timer)
	timer.start(blowup_delay)
	timer.timeout.connect(blowup)
	#get_tree().create_timer(blowup_delay).timeout.connect(blowup)
	second_countdown_timer.start()
	second_countdown_timer.timeout.connect(decrease_sec)
	second_left = int(blowup_delay)
	set_sec_label(second_left)
func decrease_sec():
	second_left -= 1
	set_sec_label(second_left)
func set_sec_label(second: int):
	second_label.text = str(second)
func blowup():
	#print("bomb blowup")
	damage_effect_texture_rect.show()
	animation_player.play("blowup")
	var damage_center: Vector2 = global_position + size/2
	#effect_animation.global_position = State 
	for enemy: Enemy in State.get_tree().get_nodes_in_group("Enemy"):
		if (enemy.global_position - damage_center).length() < blowup_radius:
			enemy.take_damage(damage, State)
	
