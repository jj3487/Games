extends Node

@onready var controls: Control = $"../Controls"
@onready var mainMenu: Control = $"../CenterContainer/MainMenu"
@onready var watch = $"../Watch"
@onready var hand: Camera3D = $"../Hand"
@onready var anim: AnimationPlayer = $"../Hand/AnimationPlayer"
@onready var mainMenu_layer: CanvasLayer = $"../MainMenu/CanvasLayer"

var hand_out := false  # false = hand is out of view

func _ready() -> void:
	_show_only(hand)  # hand is the default
	# start with the hand out of view (first frame of the animation)
	anim.play("appear")
	anim.seek(0.0, true)
	anim.pause()

func _show_only(target: Node) -> void:
	mainMenu.visible = (target == mainMenu)
	controls.visible = (target == controls)
	# hand is a Camera3D: it stays active, so nothing to hide

func _toggle(target: Control) -> void:
	if target.visible:
		_show_only(hand)
	else:
		_show_only(target)

func _toggle_hand_anim() -> void:
	hand_out = !hand_out
	if hand_out:
		anim.play("appear")
	else:
		anim.play_backwards("appear")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_main_menu"):
		_toggle(mainMenu)
	if event.is_action_pressed("open_controls"):
		_toggle(controls)
	if event.is_action_pressed("toggle_hand"):
		_toggle_hand_anim()
