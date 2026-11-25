extends ScrollContainer
func _ready():
	var bar = get_v_scroll_bar()
	var grab = StyleBoxFlat.new()
	grab.bg_color = Color(1, 0, 0)
	bar.custom_minimum_size.x = 5
	bar.add_theme_stylebox_override("grabber", grab)
	bar.add_theme_stylebox_override("grabber_highlight", grab)
	bar.add_theme_stylebox_override("grabber_pressed", grab)
	visibility_changed.connect(_measure)

func _measure():
	await get_tree().process_frame
	await get_tree().process_frame
	var bar = get_v_scroll_bar()
	print("visible: ", is_visible_in_tree(), " size: ", bar.size, " page: ", bar.page, " max: ", bar.max_value)
