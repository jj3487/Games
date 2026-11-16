extends Resource
class_name DateTime

signal time_changed(date_time: DateTime)

@export_range(0,59) var seconds: int = 0
@export_range(0,59) var minutes: int = 0
@export_range(0,23) var hours: int = 0
@export var days: int = 0

var delta_time: float = 0

func inc_by_sec(delta_sec: float) -> void:
	delta_time += delta_sec
	if delta_time < 1:
		return
	var delta_int_secs: int = int(delta_time)
	delta_time -= delta_int_secs

	seconds += delta_int_secs
	minutes += seconds / 60
	hours += minutes / 60
	days += hours / 24

	seconds = seconds % 60
	minutes = minutes % 60
	hours = hours % 24
	
	print(str(hours) + ":" + str(minutes) + ":" + str(seconds))
	time_changed.emit(self)
