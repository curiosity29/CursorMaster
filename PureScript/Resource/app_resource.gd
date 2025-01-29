class_name AppResource
extends Resource

@export var id: String
@export var app_name: String
@export var description: String
@export var icon: Texture
@export var buy_price: int = 5
@export var app_scene: PackedScene

@export var is_for_sale: bool = true
@export var allow_multiple: bool = true

var is_for_sale_run: bool

func _init() -> void:
	reset_values()

func reset_values():
	is_for_sale_run = is_for_sale
