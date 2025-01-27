extends AppWindow

@onready var cursor_texture: TextureRect = %CursorTexture
@onready var option_button: OptionButton = %OptionButton
#var cursor_possession: Dictionary[String, CursorManagerResource] = {}
var cursor_option_map: Dictionary[int, CursorManagerResource] = {}
var cursor_manager: CursorManagerResource
var is_left_click: bool = true
func _ready() -> void:
	super()
	set_cursor_option()
	
func set_cursor_option():
	## possess all for testing
	#cursor_possession = Database.cursor_map
	#var owned_app_id = State.owned_app_list.map(func(app: App) return app.app_r)
	var index: int = 0
	for app_resource: AppResource in State.owned_apps:
		#print(app_resource)
		if not State.owned_apps[app_resource] is CursorApp: continue
		## NOTE: this rely on cursor app resource id and cursor resource id being the same string
		cursor_manager = Database.cursor_map[app_resource.id]
		# check app possesion
		#if not cursor_manager.app_id in 
		option_button.add_item(cursor_manager.name, index)
		cursor_option_map[index] = cursor_manager
		index += 1
	_on_option_button_item_selected(0)
	
func _on_option_button_item_selected(index: int) -> void:
	cursor_manager = cursor_option_map[index]
	cursor_texture.texture = cursor_manager.cursor_texture
func _on_timer_timeout() -> void:
	#print(cursor_manager)
	if not cursor_manager: return
	var click_pos = cursor_texture.global_position + cursor_manager.cursor_hotspot
	#InstanceHelper.simulate_click_action(click_pos)
	
	if is_left_click: cursor_manager.on_click(click_pos)
	else: cursor_manager.on_right_click(click_pos)
