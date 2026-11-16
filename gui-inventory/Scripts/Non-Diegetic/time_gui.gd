extends Control

@onready var label: Label = $Panel/Label
@onready var time_system: TimeSystem = get_node("/root/main_non_diegetic/TimeSystem")

func _ready() -> void:
	time_system.dateTime.time_changed.connect(_on_time_changed)

func _on_time_changed(newTime: DateTime) -> void:
	label.text = "%02d:%02d:%02d" % [newTime.hours, newTime.minutes, newTime.seconds]
