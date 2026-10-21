extends Node2D

signal damaged(hp: int)
signal heal(hp: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_damage_pressed() -> void:
	damaged.emit(10)

func _on_button_heal_pressed() -> void:
	heal.emit(20)
