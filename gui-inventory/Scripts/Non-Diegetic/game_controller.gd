extends Node



@onready var controls: Node2D = $"../Controls"
@onready var mainMenu: Control = $"../MainMenu"
@onready var inventory: Control = $"../CanvasLayer/Inventory"
@onready var health = $"../Health"
@onready var controls_layer: CanvasLayer = $"../Controls/CanvasLayer"
@onready var mainMenu_layer: CanvasLayer = $"../MainMenu/CanvasLayer"
#const CONTROLS_SCENE := "res://Scenes/controls.tscn"
#var previous_scene := ""



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_show_only(mainMenu)
	pass # Replace with function body.

func toggle_menu() -> void:
	var show_it := not mainMenu.visible
	controls.hide()
	controls.get_node("Canvas_Layer").hide()
	health.hide()
	inventory.hide()
	mainMenu.visible = show_it

func toggle_inventory() -> void:
	var show_it := not inventory.visible
	controls.hide()
	controls.get_node("Canvas_Layer").hide()
	health.hide()
	mainMenu.hide()
	inventory.visible = show_it

func toggle_controls() -> void:
	var show_it := not controls.visible
	health.hide()
	mainMenu.hide()
	inventory.hide()
	controls.get_node("Canvas_Layer").show()
	controls.visible = show_it

func _show_only(target: CanvasItem) -> void:
	for n in [health, mainMenu, controls, inventory]:
		n.visible = (n == target)
	controls_layer.visible = (target == controls)
	mainMenu_layer.visible = (target == mainMenu)

func _toggle(target: CanvasItem) -> void:
	if target.visible:
		_show_only(health)
	else:
		_show_only(target)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_main_menu"):
		_toggle(mainMenu)
	if event.is_action_pressed("open_controls"):
		_toggle(controls)
	if event.is_action_pressed("inventory"):
		_toggle(inventory)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
