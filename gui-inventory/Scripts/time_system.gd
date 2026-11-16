extends Node
class_name TimeSystem

@export var dateTime: DateTime
@export var ticks_per_second: int = 6


func _process(delta: float) -> void:
	dateTime.inc_by_sec(delta * ticks_per_second)
