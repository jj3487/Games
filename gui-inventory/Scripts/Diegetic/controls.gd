extends Node2D

signal damaged_d(hp: int)
signal heal_d(hp: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_heal_pressed_d() -> void:
	heal_d.emit(20)


func _on_button_damage_pressed_d() -> void:
	damaged_d.emit(10)
