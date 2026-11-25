extends Node

@onready var controls: Node2D = $"../Controls"
@onready var mainMenu: Control = $"../MainMenu"
@onready var inventory: Control = $"../CanvasLayer/Inventory"
@onready var main_ui: Control = $"../MainUi"
@onready var controls_layer: CanvasLayer = $"../Controls/CanvasLayer"
@onready var mainMenu_layer: CanvasLayer = $"../MainMenu/CanvasLayer"
@onready var main_ui_layer: CanvasLayer = $"../MainUi/CanvasLayer"

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	mainMenu.process_mode = Node.PROCESS_MODE_ALWAYS
	controls.process_mode = Node.PROCESS_MODE_ALWAYS
	inventory.process_mode = Node.PROCESS_MODE_ALWAYS
	_show_only(mainMenu)

func toggle_menu() -> void:
	var show_it := not mainMenu.visible
	controls.hide()
	controls.get_node("Canvas_Layer").hide()
	main_ui.hide()
	inventory.hide()
	mainMenu.visible = show_it

func toggle_inventory() -> void:
	var show_it := not inventory.visible
	controls.hide()
	controls.get_node("Canvas_Layer").hide()
	main_ui.hide()
	mainMenu.hide()
	inventory.visible = show_it

func toggle_controls() -> void:
	var show_it := not controls.visible
	main_ui.hide()
	mainMenu.hide()
	inventory.hide()
	controls.get_node("Canvas_Layer").show()
	controls.visible = show_it

func _show_only(target: CanvasItem) -> void:
	for n in [main_ui, mainMenu, controls, inventory]:
		n.visible = (n == target)
	controls_layer.visible = (target == controls)
	mainMenu_layer.visible = (target == mainMenu)
	main_ui_layer.visible = (target == main_ui or target == inventory)
	get_tree().paused = (target == mainMenu)

func _toggle(target: CanvasItem) -> void:
	if target.visible:
		_show_only(main_ui)
	else:
		_show_only(target)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_main_menu"):
		_toggle(mainMenu)
	if event.is_action_pressed("open_controls"):
		_toggle(controls)
	if event.is_action_pressed("inventory"):
		_toggle(inventory)
