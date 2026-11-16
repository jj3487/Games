extends Control

@onready var mainUi = $"../MainUi"
@onready var gameController = $"../GameController"

func _on_button_play_pressed() -> void:
	gameController._show_only(mainUi)

func _on_button_settings_pressed() -> void:
	pass

func _on_button_quit_pressed() -> void:
	get_tree().quit()
