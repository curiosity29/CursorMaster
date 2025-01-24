class_name AppShopItem
extends Control
@onready var price_label: RichTextLabel = $VBoxContainer/HBoxContainer/PriceLabel
@onready var buy_button: Button = $VBoxContainer/HBoxContainer/BuyButton
@onready var description: RichTextLabel = $VBoxContainer/Description

const price_text_format = "%d\n[img=32]res://Resource/Texture/bytecoin.png[/img]"
@onready var disable_input_timer: Timer = $DisableInputTimer

var app_resource: AppResource:
	set(value):
		app_resource = value
		price_label.text = price_text_format % app_resource.buy_price
		buy_button.icon = app_resource.icon
		description.text = app_resource.description

func _ready() -> void:
	#app_resource = 
	pass
func _on_buy_button_pressed() -> void:
	if disable_input_timer.time_left > 0.: return
	if not app_resource or State.bytecoin < app_resource.buy_price: return
	disable_input_timer.start()
	State.bytecoin -= app_resource.buy_price
	## remove from database and hide (until next refresh) if not allow multiple
	if not app_resource.allow_multiple:
		app_resource.is_for_sale = false
		Database.shop_app_map.erase(app_resource.id)
		hide()
	
	Event.app_buy_request.emit(app_resource)
