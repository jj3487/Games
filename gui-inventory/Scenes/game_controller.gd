extends Node






# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func open_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _input(event) -> void:
	if event.is_action_pressed("open_main_menu"):
		open_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
