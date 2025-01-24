class_name AppShopItem
extends Control
@onready var price_label: RichTextLabel = $VBoxContainer/HBoxContainer/PriceLabel
@onready var buy_button: Button = $VBoxContainer/HBoxContainer/BuyButton
@onready var description: RichTextLabel = $VBoxContainer/Description

const price_text_format = "%d\n[img=32]res://Resource/Texture/bytecoin.png[/img]"

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
	if not app_resource or State.bytecoin < app_resource.buy_price: return
	State.bytecoin -= app_resource.buy_price
	## remove from database
	app_resource.is_for_sale = false
	Database.shop_app_map.erase(app_resource.id)
	
	Event.app_buy_request.emit(app_resource)
