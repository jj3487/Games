extends Node

@onready var controls: Control = $"../Controls"
@onready var mainMenu: Control = $"../CenterContainer/MainMenu"
@onready var watch = $"../Watch"
@onready var mainMenu_layer: CanvasLayer = $"../MainMenu/CanvasLayer"
#const CONTROLS_SCENE := "res://Scenes/controls.tscn"
#var previous_scene := ""



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_show_only(mainMenu)
	pass # Replace with function body.

func _show_only(target: CanvasItem) -> void:
	for n in [mainMenu, controls, watch]:
		n.visible = (n == target)

func _toggle(target: CanvasItem) -> void:
	if target.visible:
		_show_only(watch)
	else:
		_show_only(target)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_main_menu"):
		_toggle(mainMenu)
	if event.is_action_pressed("open_controls"):
		_toggle(controls)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
